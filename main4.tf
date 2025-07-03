provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  
 # Add IAM instance profile
  iam_instance_profile = aws_iam_instance_profile.upload_profile.name


 user_data = templatefile("user_dataa.sh", {
    env_name     = var.env_name,
    github_token = var.github_token
  })

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
   tags = {
    Name = "${var.env_name}-instance"
    Env  = var.env_name
  }
 
}


resource "aws_security_group" "allow_ssh" {
  name        = "${var.env_name}-sg"
  description = "Allow SSH and HTTP access"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_sns_topic" "alerts" {
  name = "app-alerts-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "app-log-group"
  retention_in_days = 7
}


resource "aws_cloudwatch_log_metric_filter" "error_filter" {
  name           = "app-error-filter"
  log_group_name = aws_cloudwatch_log_group.app_log_group.name
  pattern        = "?ERROR ? Exception"
  metric_transformation {
    name      = "ErrorCount"
    namespace = "AppLogs"
    value     = "1"
    unit      = "None"
  }
}

resource "aws_cloudwatch_metric_alarm" "error_alarm" {
  alarm_name          = "app-error-alarm"
  metric_name         = "ErrorCount"
  namespace           = "AppLogs"
  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  treat_missing_data  = "notBreaching"
  alarm_description   = "Triggers on ERROR or Exception logs"
}
