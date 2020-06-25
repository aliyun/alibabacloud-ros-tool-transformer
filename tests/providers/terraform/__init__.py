import os
from subprocess import check_call

# Ensure .terraform exist
cur_dir = os.getcwd()
dot_tf_path = os.path.join(cur_dir, ".terraform")
if not os.path.exists(dot_tf_path):
    check_call("terraform init", shell=True)
