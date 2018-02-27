data "aws_inspector_rules_packages" "rules" {}

# We have to use join until there is a solution for `conditional operator cannot be used with list values in`. More information about this can be found in https://github.com/hashicorp/terraform/issues/12453
locals {
  rules_package_arns = "${length(var.rules_package_arns) == 0 ? join(",", data.aws_inspector_rules_packages.rules.arns) : join(",", var.rules_package_arns)}"
}

resource "aws_inspector_resource_group" "group" {
  tags = "${var.tags}"
}

resource "aws_inspector_assessment_target" "assessment" {
  name               = "${var.name}"
  resource_group_arn = "${aws_inspector_resource_group.group.arn}"
}

resource "aws_inspector_assessment_template" "assessment" {
  name       = "${var.name}"
  target_arn = "${aws_inspector_assessment_target.assessment.arn}"
  duration   = "${var.duration}"

  rules_package_arns = ["${split(",", local.rules_package_arns)}"]
}
