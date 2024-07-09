# resource "aws_ecs_service" "strapi_service" {
#   name            = "strapi-service"
#   cluster         = aws_ecs_cluster.strapi_cluster.id
#   task_definition = aws_ecs_task_definition.ar-td.arn
#   desired_count   = 1
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets          = aws_subnet.public.*.id
#     security_groups  = [aws_security_group.alb_sg.id]
#     assign_public_ip = true
#   }

#   load_balancer {
#     target_group_arn = data.aws_lb_target_group.strapi_tg.arn
#     container_name   = "strapi"
#     container_port   = 1337
#   }
# }
resource "aws_ecs_service" "strapi_service" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.strapi_cluster.id
  task_definition = aws_ecs_task_definition.ar-td.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.public.*.id
    security_groups  = [aws_security_group.alb_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.strapi_tg.arn
    container_name   = "strapi"
    container_port   = 1337
  }
}
