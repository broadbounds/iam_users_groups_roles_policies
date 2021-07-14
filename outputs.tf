output "user_arn" {
 description = "The ARN assigned by AWS for this user"
 value = "${aws_iam_user.employee.*.arn}"
}

output "user_access_key_id" {
  description = "The access key ID"
  value = aws_iam_access_key.this.*.id
}

output "user_access_key_secret" {
  description = "The access key secret"
  value       = aws_iam_access_key.this_no_pgp.*.secret
}
