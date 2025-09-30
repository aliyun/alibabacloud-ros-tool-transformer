from typing import Set
import typer


class BaseReporter:
    """
    Base class for all transformation reporters.
    """
    def __init__(self):
        self.resources_supported: Set[str] = set()
        self.resources_unsupported: Set[str] = set()

    def add_supported_resource(self, resource_type: str):
        self.resources_supported.add(resource_type)

    def add_unsupported_resource(self, resource_type: str):
        self.resources_unsupported.add(resource_type)

    def generate_report(self):
        """
        Generate and print the transformation report.
        """
        typer.secho("=" * 60, fg="blue")
        typer.secho("ROS Template to Terraform Conversion Report", fg="blue", bold=True)
        typer.secho("=" * 60, fg="blue")

        self.resources_section()
        self.properties_section()
        self.outputs_section()
        self.manual_handling_section()

        typer.secho("\n" + "="*60, fg="blue")
        typer.secho("Conversion completed successfully!", fg="green", bold=True)
        typer.secho("="*60 + "\n\n", fg="blue")

    def resources_section(self):
        """
        The Resources section of the transformation report.
        """
        if not self.resources_supported and not self.resources_unsupported:
            return
        typer.secho(f"\nRESOURCES:", fg="blue", bold=True)
        total_count = len(self.resources_supported) + len(self.resources_unsupported)
        typer.secho(f"  • Total resources processed: {total_count}", fg="blue")
        typer.secho(f"  • Successfully transformed: {len(self.resources_supported)}", fg="green")
        if self.resources_unsupported:
            typer.secho(f"  • Unsupported resources: {', '.join(self.resources_unsupported)}", fg="yellow")

    def properties_section(self):
        """
        The Properties section of the transformation report.
        """
        pass

    def outputs_section(self):
        """
        The Outputs section of the transformation report.
        """
        pass

    def manual_handling_section(self):
        """
        The manual handling required of the transformation report.
        """
        pass


class ROS2TerraformReporter(BaseReporter):
    """
    Reporter class for ROS to Terraform transformation.
    """

    def __init__(self):
        super(ROS2TerraformReporter, self).__init__()
        self.properties_unsupported: Set[str] = set()
        self.properties_failed: Set[str] = set()
        self.outputs_failed: Set[str] = set()

    def add_unsupported_property(self, property_path: str):
        self.properties_unsupported.add(property_path)

    def add_failed_property(self, property_path: str):
        self.properties_failed.add(property_path)

    def add_failed_output(self, output_name: str):
        self.outputs_failed.add(output_name)

    def properties_section(self):
        """
        The Properties section of the transformation report.
        """
        if self.properties_unsupported or self.properties_failed:
            typer.secho(f"\nPROPERTIES:", fg="blue", bold=True)
            if self.properties_unsupported:
                typer.secho(f" • The following properties of ROS resources are not supported "
                            f"by Terraform: {', '.join(self.properties_unsupported)}", fg="yellow")
            if self.properties_failed:
                typer.secho(f" • The following properties of ROS resources are "
                            f"transformed failed: {', '.join(self.properties_failed)}", fg="yellow")

    def outputs_section(self):
        """
        The Outputs section of the transformation report.
        """
        if self.outputs_failed:
            typer.secho(f"\nOUTPUTS:", fg="blue", bold=True)
            typer.secho(f" • The following outputs of ROS template are "
                        f"transformed failed: {', '.join(self.outputs_failed)}", fg="yellow")

    def manual_handling_section(self):
        """
        The manual handling required of the transformation report.
        """
        if self.properties_failed or self.outputs_failed:
            typer.secho(f"\nMANUAL HANDLING REQUIRED:", fg="blue", bold=True)
            typer.secho(f"  • Please manually handle the failed properties or outputs "
                        f"which are commented in templates", fg="yellow")
