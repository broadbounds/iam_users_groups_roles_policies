# We set AWS as our default cloud provider
provider "aws" {
   region  = var.aws_region
   access_key = var.access_key
   secret_key = var.secret_key
 }

# We create new AWS IAM users with random passwords
resource "aws_iam_user" "employee" {
  count = "${length(var.username)}"
  name = "${element(var.username,count.index )
  # (Optional, default "/") Path in which to create the user
  path = "/system/"
}

# We create access and secret keys for created IAM users
# Set of credentials that allow API requests to be made as an IAM user
# This will write the secret to the state file
resource "aws_iam_access_key" "newemp" {
  count = length(var.username)
  user = element(var.username,count.index)
}
