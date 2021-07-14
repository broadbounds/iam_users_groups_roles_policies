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
resource "aws_iam_access_key" "employee_keys" {
  count = length(var.username)
  user = element(var.username,count.index)
}

# We create an IAM group for developers
resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}

# We create an IAM group for operations
resource "aws_iam_group" "operations" {
  name = "operations"
  path = "/users/"
}

# We manage IAM Group membership for IAM Users
resource "aws_iam_group_membership" "developers_team" {
  # The name to identify the Group Membership
  name = "developers-team"

  # A list of IAM User names to associate with the Group
  users = [
    aws_iam_user.user_one.name,
    aws_iam_user.user_two.name,
  ]

  # The IAM Group name to attach the list of users to
  group = aws_iam_group.developers.name
}

# We manage IAM Group membership for IAM Users
resource "aws_iam_group_membership" "operations_team" {
  # The name to identify the Group Membership
  name = "tf-testing-group-membership"

  # A list of IAM User names to associate with the Group
  users = [
    aws_iam_user.user_one.name,
    aws_iam_user.user_two.name,
  ]

  # The IAM Group name to attach the list of users to
  group = aws_iam_group.operations.name
}

# We add some IAM users to the developers IAM Group
resource "aws_iam_user_group_membership" "developers_membership" {
  user = aws_iam_user.user1.name

  groups = [
    aws_iam_group.developers.name,
  ]
}

# We add some IAM users to the operations IAM Group
resource "aws_iam_user_group_membership" "operations_membership" {
  user = aws_iam_user.user1.name

  groups = [
    aws_iam_group.operations.name,
  ]
}

# We add some IAM users to the developers and operations IAM Groups
resource "aws_iam_user_group_membership" "developers_operations_membership" {
  user = aws_iam_user.user1.name

  groups = [
    aws_iam_group.developers.name,
    aws_iam_group.operations.name,
  ]
}
