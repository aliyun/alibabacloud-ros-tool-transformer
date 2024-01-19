import typer
from rostran.core.properties import Properties

from rostran.core.resources import Resource, Resources


def get_ref_id(name, value, reason):
    ref_id = None
    if (
        isinstance(value, dict)
        and len(value) == 1
        and ("Ref" in value or "Fn::GetAtt" in value)
    ):
        if "Ref" in value:
            ref_id = value["Ref"]
            if not isinstance(ref_id, str):
                typer.secho(
                    f"The Ref value type of {name} needs to be a string.", fg="yellow"
                )
        else:
            get_att = value["Fn::GetAtt"]
            if not isinstance(get_att, list):
                typer.secho(
                    f"The Fn::GetAtt value type of {name} needs to be a list.",
                    fg="yellow",
                )
            elif len(get_att) != 2:
                typer.secho(
                    f"The Fn::GetAtt value of {name} needs to be a list of length 2.",
                    fg="yellow",
                )
            elif not isinstance(get_att[0], str):
                typer.secho(
                    f"The first element of Fn::GetAtt value of {name} needs to be a string",
                    fg="yellow",
                )
            else:
                ref_id = get_att[0]
    else:
        typer.secho(reason, fg="yellow")
    return ref_id


def merge_vpc_gateway_attachment_to_gateway(
    resource: Resource, out_resources: Resources
):
    tpl = f"  Resource type {resource.type!r} is not supported and will be ignored. Reason: {{}}."
    raw_vpc_id = resource.properties.get("VpcId")
    if not raw_vpc_id:
        typer.secho(tpl.format("missing VpcId"), fg="yellow")

    raw_vpc_gateway_id = resource.properties.get("VpnGatewayId")
    if raw_vpc_gateway_id:
        vpn_gateway_id = get_ref_id(
            "VpnGatewayId",
            raw_vpc_gateway_id.value,
            reason=tpl.format("VpnGatewayId does not reference any resource"),
        )
        out_resource = out_resources.get(vpn_gateway_id)
        if out_resource:
            if out_resource.type != "ALIYUN::VPC::VpnGateway":
                typer.secho(
                    tpl.format(
                        "VpnGatewayId references a resource other than EC2::VpnGateway"
                    ),
                    fg="yellow",
                )
                return
            out_resource.properties["VpcId"] = raw_vpc_id
    else:
        raw_internet_gateway_id = resource.properties.get("InternetGatewayId")
        if raw_internet_gateway_id:
            internet_gateway_id = get_ref_id(
                "InternetGatewayId",
                raw_internet_gateway_id.value,
                reason=tpl.format("InternetGatewayId does not reference any resource"),
            )
            out_resource = out_resources.get(internet_gateway_id)
            if out_resource:
                if out_resource.type != "ALIYUN::VPC::NatGateway":
                    typer.secho(
                        tpl.format(
                            "InternetGatewayId references a resource other than EC2::InternetGateway"
                        ),
                        fg="yellow",
                    )
                    return
                out_resource.properties["VpcId"] = raw_vpc_id


def split_nat_gateway(resource: Resource, out_resources: Resources):
    print(resource.properties.as_dict())
    raw_allocation_id = resource.properties.get("AllocationId")
    print(raw_allocation_id)
    if not raw_allocation_id:
        return

    eip_association_props = Properties.initialize(
        {
            "AllocationId": raw_allocation_id.value,
            "InstanceId": resource.resource_id,
        },
    )
    eip_association = Resource(
        resource_id=f"{resource.resource_id}EIPAssociation",
        resource_type="ALIYUN::VPC::EIPAssociation",
        properties=eip_association_props,
    )
    out_resources.add(eip_association)
