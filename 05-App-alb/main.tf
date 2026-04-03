resource "aws_lb" "app_alb" {
  name               = "${local.name}-${var.tags.Component}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.app_alb_sg_id.value]
  subnets            = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  #enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.id
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = merge(
          var.common_tags,
          var.tags)
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response from Application Load Balancer"
      status_code  = "200"
    }
    }

}

resource "aws_route53_record" "app_alb" {
    zone_id =data.aws_route53_zone.selected.zone_id
    name = "*.app-${var.environment}"
    allow_overwrite = true
    type = "A"
   
          alias {
            name                   = "${aws_lb.app_alb.dns_name}"
            zone_id                = "${aws_lb.app_alb.zone_id}"
            evaluate_target_health = true
          }
    
  
}