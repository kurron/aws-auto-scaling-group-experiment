resource "aws_ecs_cluster" "example" {
    name = "example-cluster"
}

resource "aws_ecs_task_definition" "jenkins" {
  family = "sample-app"
  container_definitions = "${file("task-definitions/simple-app.json")}"

  volume {
    name = "my-vol"
    host_path = "/ecs/sample-app"
  }
}
