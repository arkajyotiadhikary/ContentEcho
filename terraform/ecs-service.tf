resource "aws_ecs_service" "ar-svc" {
  name = "ar-svc"
  cluster = aws_ecs_cluster.ar-cluster.id
  task_definition = aws_ecs_task_definition.ar-td.arn
  desired_count = 1
  launch_type = "FARGATE"
  network_configuration {
    subnets = [var.subnet_id]
    security_groups = [var.sg_id]
  }
}
