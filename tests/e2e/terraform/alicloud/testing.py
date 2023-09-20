from rostran.providers import TerraformTemplate


def _test_template(root, tf_plan_path):
    template = TerraformTemplate.initialize(root, tf_plan_path=tf_plan_path)
    ros_template = template.transform()
    d = ros_template.as_dict()
    return d
