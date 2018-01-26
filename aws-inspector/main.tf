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

  rules_package_arns = "${var.rules_package_arns}"
}
