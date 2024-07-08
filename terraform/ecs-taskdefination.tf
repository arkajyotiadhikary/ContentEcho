resource "aws_ecs_task_definition" "ar-td" {
  family                   = "ar-td"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = file("./taskdef.json")
}

data "aws_ecs_task_definition" "ar-td" {
  task_definition = aws_ecs_task_definition.ar-td.family
}
