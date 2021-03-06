resource "aws_security_group" "web_traffic" {
    name = "web-traffic"
    description = "Allow inbound and outbound access on http(s) ports."
    vpc_id = "${aws_vpc.main.id}"
    tags {
        Name = "Web Traffic"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_elb" "load_balancer" {
    name = "auto-scaling-load-balancer"
#   availability_zones = ["${aws_instance.docker.*.availability_zone}"] 

    subnets = ["${aws_subnet.subnet.*.id}"]
#   instances = ["${aws_instance.docker.*.id}"]
    internal = false
    security_groups = ["${aws_security_group.web_traffic.id}"]
    cross_zone_load_balancing = true
    idle_timeout = 60
    connection_draining = true
    connection_draining_timeout = 60

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
#       ssl_certificate_id = "***********"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/"
        interval = 30
    }

    tags {
        Name = "Auto Scaling"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

