resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.environment}-alb-sg"
  vpc_id      = var.vpc_id

  tags = {
  Name = "${var.project_name}-${var.environment}-alb-sg"
  }
}

resource "aws_security_group" "ecs" {
  name   = "${var.project_name}-${var.environment}-ecs-sg"
  vpc_id = var.vpc_id

  tags = {
  Name = "${var.project_name}-${var.environment}-ecs-sg"
  }
}

resource "aws_security_group" "vpc_endpoints" {
  name   = "${var.project_name}-${var.environment}-vpc-endpoints-sg"
  vpc_id = var.vpc_id

    tags = {
    Name = "${var.project_name}-${var.environment}-vpc-endpoints-sg"
    }
  }

# Avoid cyclical dependencies by defining rules separately
# https://developer.hashicorp.com/terraform/tutorials/state/troubleshooting-workflow#correct-a-cycle-error

resource "aws_security_group_rule" "alb_ingress_http" {
      type        = "ingress"
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # From anywhere
    security_group_id = aws_security_group.alb.id
  }

resource "aws_security_group_rule" "alb_ingress_https" {
    type        = "ingress"
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # From anywhere
    security_group_id = aws_security_group.alb.id
  }

resource "aws_security_group_rule" "alb_egress" {
    type = "egress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"           # ONLY to ECS on container port (8080)
    source_security_group_id = aws_security_group.ecs.id
    security_group_id = aws_security_group.alb.id
  }

resource "aws_security_group_rule" "ecs_ingress" {
    type            = "ingress"
    description     = "From ALB"
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    source_security_group_id = aws_security_group.alb.id  # ONLY from ALB on 8080!
    security_group_id = aws_security_group.ecs.id
  }

resource "aws_security_group_rule" "ecs_egress" {
    type = "egress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    source_security_group_id = aws_security_group.vpc_endpoints.id # VPC endpoints for ECS must allow port 443
    security_group_id = aws_security_group.ecs.id
    description = "Allow all outbound traffic"
  }

resource "aws_security_group_rule" "vpc_endpoints_ingress" {
    type = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    source_security_group_id = aws_security_group.ecs.id # VPC endpoints for ECS must allow port 443
    security_group_id = aws_security_group.vpc_endpoints.id
    description = "HTTPS from VPC"
  }