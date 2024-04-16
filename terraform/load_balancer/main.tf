resource "aws_lb" "load_balancer" {
  for_each           = var.load_balancer
  name               = each.key
  internal           = each.value.internal
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = each.value.lb_subnet_ids
  tags = {
    Environment = "production"
  }
}




resource "aws_lb_listener" "listener" {
  for_each          = var.load_balancer
  load_balancer_arn = aws_lb.load_balancer[each.key].arn
  port              = each.value.port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[each.key].arn
  }
  tags = {
    name = "listener${each.key}"
  }
}




resource "aws_lb_target_group" "target_group" {
  for_each    = var.load_balancer
  name        = "target${each.key}"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

}


resource "aws_autoscaling_attachment" "autoscaling_target" {
  for_each = var.load_balancer
  lb_target_group_arn    = aws_lb_target_group.target_group[var.autoscaling_target_group_name].arn
  autoscaling_group_name = var.aws_autoscaling_group
  
}

resource "aws_lb_target_group_attachment" "public_target_group" {
  for_each = var.load_balancer
  target_group_arn = aws_lb_target_group.target_group[var.public_target_group_name].arn
  target_id        = var.instanece_ids[each.value.index]
}

