import zipfile


def test_build_playground_assets_creates_browser_subset(tmp_path):
    from website.scripts import build_playground_assets

    out_dir = tmp_path / "playground"

    manifest = build_playground_assets.build(out_dir)

    package_path = out_dir / manifest["pythonPackage"]
    assert package_path.is_file()
    assert manifest["pyodideVersion"]

    with zipfile.ZipFile(package_path) as package:
        names = set(package.namelist())

    assert "rostran/wasm.py" in names
    assert "rostran/providers/cloudformation/template.py" in names
    assert "rostran/rules/cloudformation/resource/aws_ec2_vpc.yml" in names
    assert "rostran/providers/terraform/template.py" not in names
    assert "rostran/providers/excel/template.py" not in names
    assert "rostran/providers/ros/template.py" not in names
