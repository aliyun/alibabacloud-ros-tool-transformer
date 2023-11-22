from rostran.core.rule_manager import RuleManager, RuleClassifier

from rostran.providers import CloudFormationTemplate


def _test_template(cf_tpl, ros_tpl):
    rule_manager = RuleManager.initialize(RuleClassifier.CloudFormation)
    template = CloudFormationTemplate(source=cf_tpl, rule_manager=rule_manager)
    print(template.transform().as_dict())
    # assert ros_tpl == template.transform().as_dict()
