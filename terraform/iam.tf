resource "aws_iam_instance_profile" "ecs_profile" {
    name = "ecs-instance-profile"
    roles = ["${aws_iam_role.ecs_instance_role.name}"]
}

# the trick is to provide TWO trust policies -- one for each role
resource "aws_iam_role" "ecs_instance_role" {
    name = "ecs-instance-role"
#   path = "/"
    assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# I was unable to create the policy by hand and have it work. Could be me, could be Terraform. Using the policy created by the wizard.
resource "aws_iam_policy_attachment" "ecs_instance_role" {
    name = "ecs_instance_role"
    roles = ["${aws_iam_role.ecs_instance_role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# I was unable to create the policy by hand and have it work. Could be me, could be Terraform. Using the policy created by the wizard.
resource "aws_iam_policy_attachment" "ecs_scheduler_role" {
    name = "ecs_scheduler_role"
    roles = ["${aws_iam_role.ecs_instance_role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

