resource "aws_cloudwatch_event_rule" "inspector" {
  name                = "aws-inspector-run-${var.name}"
  description         = "AWS Inspector run for ${var.name}"
  schedule_expression = "${var.schedule_expression}"
}

resource "aws_cloudwatch_event_target" "inspector" {
  rule     = "${aws_cloudwatch_event_rule.inspector.name}"
  arn      = "${aws_inspector_assessment_template.assessment.arn}"
  role_arn = "${aws_iam_role.inspector.arn}"
}
