# UT coverage reporting convention

CI enforces coverage thresholds. Codecov receives reports for visualization;
its GitHub App is not required for the local CI coverage gate.

## Artifact names and format

Each independently tested component publishes one artifact named
`ut-coverage-<component>`. An additional `ut-coverage` artifact contains the total.
Every artifact contains a single Cobertura XML file
named `coverage.xml` at the archive root. Names do not include a branch, commit,
runtime version, or date: those belong to the GitHub Actions run metadata.

Component names describe responsibilities, not implementation languages. Every
repository uses `main` for its primary production component, even if it has only
one report. The only separate component IDs are `frontend` and `desktop`.
Plugins are outside the reporting scope.
Codecov flags use the same component IDs as the artifact suffixes.

The component names planned across the repositories are:

| Repository | Artifacts |
| --- | --- |
| alibabacloud-ros-tool-transformer | `ut-coverage`, `ut-coverage-main`, `ut-coverage-frontend` |
| alibabacloud-ros-tool-iact3 | `ut-coverage`, `ut-coverage-main`, `ut-coverage-frontend` |
| iac-code | `ut-coverage`, `ut-coverage-main`; `ut-coverage-desktop` if desktop coverage is collected separately |
| infraguard | `ut-coverage`, `ut-coverage-main` |
| elastic-compute-control-cli | `ut-coverage`, `ut-coverage-main` |

Only Transformer is configured here. Other repositories must verify their
covered components when adopting this convention.

Do not create empty artifacts for components that have no coverage collection.
Documentation websites are outside the application UT coverage scope.

## Total coverage

For a single-component repository, the total has the same metrics as `main`.
For multiple components, sum the original covered and valid counts and preserve
the per-file details in a combined Cobertura report. Do not average percentages.
Source filenames must be repository-relative and disjoint across components;
overlapping files or missing component reports fail aggregation rather than
producing misleading totals. Component gates still apply independently.

The total is an artifact only. Codecov already combines the component uploads;
do not upload the total as another component. Inspect total metrics directly
instead of adding them to component metrics a second time.

## Programmatic inspection

Select the relevant test workflow run and commit first, then download its reports:

```sh
gh run download RUN_ID --repo OWNER/REPO --pattern 'ut-coverage*' --dir ./coverage-reports
```

Read these attributes from each XML document's root `coverage` element:

| Metric | Covered count | Total count |
| --- | --- | --- |
| Lines | `lines-covered` | `lines-valid` |
| Branches | `branches-covered` | `branches-valid` |

Compute percentages from the counts, rather than rounded `line-rate` or
`branch-rate` values. A zero denominator means unavailable/not applicable.
Check each required component separately; a combined percentage can hide an
under-covered component. Also inspect the run conclusion and artifact expiry:
a missing report is unknown, and an older successful run is not the latest run.

Go's native coverage measures statements. Its original statement gate remains
authoritative; converted Cobertura line coverage may differ. Go's native report
does not supply branch coverage.
Total branch counts describe only components that supply branch data; they do
not establish branch coverage for components without branch instrumentation.

## Transformer gates

Python (3.12) and frontend each require at least 95% line and branch coverage,
both overall and on changed code. Other Python versions run compatibility tests.
Reports are retained and uploaded whenever generated, even if a coverage gate
fails. Tests or gates failing still make the CI run fail.
