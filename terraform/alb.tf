# data "aws_lb" "strapi_lb" {
#   arn = "arn:aws:elasticloadbalancing:ap-south-1:533266978173:loadbalancer/app/strapi-alb/bd0c6d5cc1682e83"
# }

# data "aws_lb_target_group" "strapi_tg" {
#  arn = "arn:aws:elasticloadbalancing:ap-south-1:533266978173:targetgroup/strapi-tg/01fc939059feb29b"
# }

# data "aws_lb_listener" "http" {
#   load_balancer_arn = data.aws_lb.strapi_lb.arn
#   port              = 80
# }
resource "aws_lb" "strapi_lb" {
  name               = "strapi-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public.*.id
}

resource "aws_lb_target_group" "strapi_tg" {
  name     = "strapi-tg"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = aws_vpc.strapi_vpc.id
  target_type = "ip"
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.strapi_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.strapi_tg.arn
  }
}

