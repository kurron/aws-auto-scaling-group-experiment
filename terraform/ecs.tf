resource "aws_ecs_cluster" "example" {
    name = "example-cluster"
}

resource "aws_ecs_task_definition" "sample" {
    family = "sample-app"
    container_definitions = "${file("task-definitions/simple-app.json")}"

    volume {
        name = "my-vol"
        host_path = "/ecs/sample-app"
    }
}

resource "aws_ecs_service" "sample" {
    name = "sample"
    cluster = "${aws_ecs_cluster.example.id}"
    task_definition = "${aws_ecs_task_definition.sample.arn}"
    desired_count = 3
    iam_role = "${aws_iam_role.ecs_instance_role.arn}"
    depends_on = ["aws_iam_role_policy.ecs_scheduler_role", "aws_iam_role_policy.ecs_instance_role" ]

    load_balancer {
        elb_name = "${aws_elb.load_balancer.id}"
        container_name = "simple-app"
        container_port = 80
    }
}
