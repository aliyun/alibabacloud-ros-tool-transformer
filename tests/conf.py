import os

ROOT = os.path.dirname(os.path.abspath(__file__))
PROVIDERS_DIR = os.path.join(ROOT, "providers")
EXCEL_PROVIDRE_DIR = os.path.join(PROVIDERS_DIR, "excel")
TERRAFORM_PROVIDER_DIR = os.path.join(PROVIDERS_DIR, "terraform")
TERRAFORM_ALICLOUD_DIR = os.path.join(TERRAFORM_PROVIDER_DIR, "alicloud")
