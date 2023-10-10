# ROS tool to generate and format rules.

## Setup

1. Setup the local path of the Terraform Alibaba provider. If not set, the github repository will be accessed, which may
   cause slow speed.

```bash
git clone https://github.com/aliyun/terraform-provider-alicloud.git
export TERRAFORM_PROVIDER_ALICLOUD=`pwd`/terraform-provider-alicloud
```

2. Setup Alibaba Cloud credential:

```bash
export ALIBABA_CLOUD_ACCESS_KEY_ID=<access_key_id>
export ALIBABA_CLOUD_ACCESS_KEY_SECRET=<access_key_secret>
```

## Usage

Format rules:

```bash
python -m tools.cli format
```

Generate rules:

```bash
# generate all rules
python -m tools.cli generate

# generate single rule
python -m tools.cli generate --tf alicloud_dfs_access_group --ros ALIYUN::DFS::AccessGroup
```