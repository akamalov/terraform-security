# terraform-security
Terraform modules aimed at security tools (eg AWS Inspector)

## aws-inspector
This configures AWS inspector and will run it periodically with cloudwatch rules. 

### Available variables:
 * [`name`]: String(required): Name of your assessment
 * [`tags`]: Map(required): Instance tags that you want to include in your AWS inspector runs. This identifies which instances you want to scan. This follows the OR mechanism of selecting the instances based on tags.
 * [`duration`]: Int (optional): Duration in seconds an assessment can take. Defaults to `3600`.
 * [`rules_package_arns`]: map(optional): Package arns you want to use for testing. By default it takes all the packages rules available in the region of your AWS provider.
* [`schedule_expression`]: String(optional): Schedule expression to tell when AWS inspector has to run. For example, cron(0 20 * * ? *) or rate(5 minutes). Defaults to `cron(0 22 ? * SUN *)`

### Output
 * None

### Example
```
module "assessment" {
  source               = "github.com/skyscrapers/terraform-security//aws-inspector?ref=0.0.1"
  name                 = "Test"
  tags                 = {
      inspector   = "test"
      Environment = "test"
  }
}
```
