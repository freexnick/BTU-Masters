resource "aws_autoscaling_group" "demo_asg" {
  name                      = "demo-asg"
  availability_zones        = data.aws_availability_zones.zones.names
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  termination_policies      = ["OldestInstance"]


  launch_template {
    id      = aws_launch_template.demo_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "demo_asg_attachement" {
  autoscaling_group_name = aws_autoscaling_group.demo_asg.id
  elb                    = aws_elb.demo_elb.id
}


resource "aws_autoscaling_policy" "demo_scaling" {
  name                   = "demo-scaling"
  policy_type            = "TargetTrackingScaling"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.demo_asg.id

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 90
  }
}
