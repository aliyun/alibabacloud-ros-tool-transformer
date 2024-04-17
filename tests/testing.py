import os
import shutil
from libterraform import TerraformCommand

from rostran.providers import TerraformTemplate
from tests.conf import ROOT


def _test_tf_template(root, tf_plan_path):
    tf_dir = root if os.path.isdir(root) else os.path.dirname(root)
    for name in (".terraform", ".terraform.lock.hcl"):
        dst = os.path.join(tf_dir, name)
        if not os.path.exists(dst):
            src = os.path.join(ROOT, name)
            if not os.path.exists(src):
                print("Init terraform provider")
                tf = TerraformCommand(ROOT)
                tf.init()
            if os.path.isdir(src):
                shutil.copytree(src, dst)
            else:
                shutil.copyfile(src, dst)

    template = TerraformTemplate.initialize(root, tf_plan_path=tf_plan_path)
    ros_template = template.transform()
    d = ros_template.as_dict()
    return d
