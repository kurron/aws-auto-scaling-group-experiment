resource "aws_launch_configuration" "ecs" {
#   name_prefix = "ecs-instance-"
    image_id = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "t2.micro"
    iam_instance_profile = "${aws_iam_instance_profile.ecs_profile.id}"
    key_name = "${lookup(var.key_name, var.aws_region)}"
    security_groups = ["${aws_security_group.all_traffic.id}"]
    associate_public_ip_address = true
    user_data = <<DATA
#!/bin/bash
echo ECS_CLUSTER=example-cluster >> /etc/ecs/ecs.config
DATA 
    enable_monitoring = true
    ebs_optimized = false
#   root_block_device = ???
#   ebs_block_device = ???
#   ephemeral_block_device = ???
#   spot_price = ???
}

resource "aws_autoscaling_group" "ecs" {
    name = "ecs-autoscaling-experiment"
    max_size = 6
    min_size = 1
#   availability_zones = ["us-east-1a"]
    launch_configuration = "${aws_launch_configuration.ecs.name}"
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 3
#   min_elb_capacity = 9
    force_delete = false
#   load_balancers = []
    vpc_zone_identifier = ["${aws_subnet.subnet.*.id}"]
#   termination_policies = []
    wait_for_capacity_timeout = "10m"

    tag {
        key = "Name"
        value = "ECS Instance"
        propagate_at_launch = true
    }

    tag {
        key = "Realm"
        value = "${var.realm}"
        propagate_at_launch = true
    }

    tag {
        key = "Purpose"
        value = "${var.purpose}"
        propagate_at_launch = true
    }

    tag {
        key = "Managed-By"
        value = "${var.created_by}"
        propagate_at_launch = true
    }

    lifecycle {
        create_before_destroy = true
    }
}
