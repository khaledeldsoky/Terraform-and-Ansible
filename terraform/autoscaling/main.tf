

resource "aws_autoscaling_group" "autoscaling_group" {
  for_each            = var.launch_template
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2
  target_group_arns   = [each.value.target_group_arns]
  vpc_zone_identifier = each.value.subnet_id

  # launch_configuration = aws_launch_configuration.terramino[each.key].name

  launch_template {
    id      = aws_launch_template.ec2[each.key].id
    version = "$Latest"
  }

}

resource "aws_launch_template" "ec2" {
  for_each               = var.launch_template
  name                   = "ec2"
  image_id               = each.value.instance_ami
  instance_type          = each.value.instance_type
  key_name               = each.value.aws_key_pair_deployer_key_name
  vpc_security_group_ids = [each.value.vpc_security_group_ids]


  user_data = base64encode(<<EOF
#! /bin/bash
sudo apt-get update -y
sudo apt-get install -y openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "EC2_${each.key}"
      type = "private"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

}

# resource "aws_launch_configuration" "terramino" {
#   name          = each.key
#   for_each      = var.launch_template
#   image_id      = each.value.instance_ami
#   instance_type = each.value.instance_type
#   user_data = base64encode(<<-EOF
#                             #!/bin/bash
#                             sudo apt update
#                             sudo apt install -y python3-pip > /dev/null 2>&1
#                             sudo apt install python3-dev default-libmysqlclient-dev build-essential pkg-config -y > /dev/null 2>&1
#                             git clone https://github.com/h3itham/SimpleDjangoApp.git /home/ubuntu/project
#                             cd /home/ubuntu/project/
#                             sudo pip3 install -r requirements.txt
#                             sed -i 's/database_name/${each.value.dbname}/g' config/settings.py
#                             sed -i 's/database_username/${each.value.dbusername}/g' config/settings.py
#                             sed -i 's/database_password/${each.value.dbpassword}/g' config/settings.py
#                             sed -i 's/database_host/${each.value.dbhost}/g' config/settings.py
#                             sudo python3 manage.py migrate
#                             sudo nohup python3 manage.py runserver 0.0.0.0:80 &
#                             EOF
#   )
#   security_groups = [each.value.vpc_security_group_ids]
#   key_name        = each.value.aws_key_pair_deployer_key_name

#   lifecycle {
#     create_before_destroy = true
#   }

# }
