# UT coverage reporting convention

CI enforces coverage thresholds. Codecov receives reports for visualization;
its GitHub App is not required for the local CI coverage gate.

## Artifact names and format

Each independently tested component publishes one artifact named
`ut-coverage-<component>`. Every artifact contains a single Cobertura XML file
named `coverage.xml` at the archive root. Names do not include a branch, commit,
runtime version, or date: those belong to the GitHub Actions run metadata.

The component names planned across the repositories are:

| Repository | Artifacts |
| --- | --- |
| alibabacloud-ros-tool-transformer | `ut-coverage-python`, `ut-coverage-frontend` |
| alibabacloud-ros-tool-iact3 | `ut-coverage-python`, `ut-coverage-frontend` |
| iac-code | `ut-coverage-python`; `ut-coverage-desktop` if desktop coverage is collected separately |
| infraguard | `ut-coverage-go` |
| elastic-compute-control-cli | `ut-coverage-go` |

Only Transformer is configured here. Other repositories must verify their
covered components when adopting this convention.

These are baseline report names, not a claim that every source component is
covered. Elastic Compute Control CLI also has independent `dsh-plugin` tests;
reserve `ut-coverage-dsh-plugin` when collecting their coverage. InfraGuard's
Web and VS Code components currently have no coverage commands; future reports
use `ut-coverage-frontend` and `ut-coverage-vscode`. Do not create empty artifacts
or treat the Go report as coverage for those components. Documentation websites
are not application UT coverage components.

## Programmatic inspection

Select the relevant test workflow run and commit first, then download its reports:

```sh
gh run download RUN_ID --repo OWNER/REPO --pattern 'ut-coverage-*' --dir ./coverage-reports
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

## Transformer gates

Python (3.12) and frontend each require at least 95% line and branch coverage,
both overall and on changed code. Other Python versions run compatibility tests.
Reports are retained and uploaded whenever generated, even if a coverage gate
fails. Tests or gates failing still make the CI run fail.
