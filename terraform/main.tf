module "network" {

  source = "./network"

  subnets = {

    "private_subnet_1" = {
      cidr_block  = var.private_subnet_1_cidr_block
      AZ          = 0
      route_table = var.private_route_table_name
    }

    "private_subnet_2" = {
      cidr_block  = var.private_subnet_2_cidr_block
      AZ          = 1
      route_table = var.private_route_table_name
    }

    "private_subnet_3" = {
      cidr_block  = var.private_subnet_3_cidr_block
      AZ          = 0
      route_table = var.private_route_table_name
    }

    "private_subnet_4" = {
      cidr_block  = var.private_subnet_4_cidr_block
      AZ          = 1
      route_table = var.private_route_table_name
    }


    "public_subnet_1" = {
      cidr_block  = var.public_subnet_1_cidr_block
      AZ          = 0
      route_table = var.public_route_table_name
    }

    "public_subnet_2" = {
      cidr_block  = var.public_subnet_2_cidr_block
      AZ          = 1
      route_table = var.public_route_table_name
    }


  }


  route_table = {

    "public_route_table" = {
      cidr_block = var.defualt_cidr_block
      gateway_id = module.network.gatway_id
    }

    "private_route_table" = {
      cidr_block = var.defualt_cidr_block
      gateway_id = module.network.nat_id
    }



  }
  vpc_cidr_block = var.vpc_cidr_block
}


module "ec2" {
  source = "./ec2"
  ec2 = {
    # "private_ec2_1" = {
    #   ami                                = "ami-080e1f13689e07408"
    #   instance_type                      = "t2.micro"
    #   associate_public_ip                = false
    #   subnet_id                          = module.network.subnet_id["private_subnet_1"]
    #   secuirty_group                     = module.secert.secuirty_group_id_public
    #   aws_key_pair_deployer_key_name_var = module.secert.aws_key_pair_deployer_key_name
    # }

    # "private_ec2_2" = {
    #   ami                                = "ami-080e1f13689e07408"
    #   instance_type                      = "t2.micro"
    #   associate_public_ip                = false
    #   secuirty_group                     = module.secert.secuirty_group_id_public
    #   subnet_id                          = module.network.subnet_id["private_subnet_2"]
    #   aws_key_pair_deployer_key_name_var = module.secert.aws_key_pair_deployer_key_name
    # }


    "public_ec2_1" = {
      ami                                = data.aws_ami.ubuntu.id
      instance_type                      = var.instance_type_t2_micro
      associate_public_ip                = true
      subnet_id                          = module.network.subnet_id["public_subnet_1"]
      secuirty_group                     = module.secert.secuirty_group_id_public
      aws_key_pair_deployer_key_name_var = module.secert.aws_key_pair_deployer_key_name
    }

    "public_ec2_2" = {
      ami                                = data.aws_ami.ubuntu.id
      instance_type                      = var.instance_type_t2_micro
      associate_public_ip                = true
      subnet_id                          = module.network.subnet_id["public_subnet_2"]
      secuirty_group                     = module.secert.secuirty_group_id_public
      aws_key_pair_deployer_key_name_var = module.secert.aws_key_pair_deployer_key_name
    }
  }
  tls_private_key_var = module.secert.private_key
}


module "secert" {
  source          = "./secret"
  vpc_id          = module.network.vpc_id
  vpc_cidr_blocks = module.network.vpc_cidr_block
}


module "lb" {
  source            = "./load_balancer"
  security_group_id = module.secert.secuirty_group_id_public
  load_balancer = {
    publicLb = {
      lb_subnet_ids = [module.network.subnet_id["public_subnet_2"], module.network.subnet_id["public_subnet_1"]]
      port          = 80
      internal      = false
      index         = 0

    }
    privateLb = {
      lb_subnet_ids = [module.network.subnet_id["private_subnet_2"], module.network.subnet_id["private_subnet_1"]]
      port          = 80
      internal      = true
      index         = 1
    }
  }
  aws_autoscaling_group         = module.launch_template.aws_autoscaling_group["private_autoEc2_1"].id
  vpc_id                        = module.network.vpc_id
  instanece_ids                 = [module.ec2.instance_ids["public_ec2_1"], module.ec2.instance_ids["public_ec2_2"]]
  autoscaling_target_group_name = "privateLb"
  public_target_group_name      = "publicLb"

}


module "RDS" {
  source = "./RDS"
  aws_db = {
    rds_4 = {
      engine                 = "mysql"
      engine_version         = "8.0.35"
      db_name                = "db4"
      identifier             = "db4"
      allocated_storage      = 20
      username               = "khaled"
      password               = "12345678"
      instance_class         = "db.t3.micro"
      vpc_security_group_ids = module.secert.secuirty_group_id_public
    }
  }
  db_subnet_ids = [module.network.subnet_id["private_subnet_3"], module.network.subnet_id["private_subnet_4"]]
}


module "launch_template" {
  source = "./autoscaling"
  launch_template = {
    private_autoEc2_1 = {
      instance_ami                   = data.aws_ami.ubuntu.id
      instance_type                  = var.instance_type_t2_micro
      vpc_security_group_ids         = module.secert.secuirty_group_id_public
      aws_key_pair_deployer_key_name = module.secert.aws_key_pair_deployer_key_name
      target_group_arns              = module.lb.target_group["privateLb"].arn
      subnet_id                      = [module.network.subnet_id["private_subnet_1"], module.network.subnet_id["private_subnet_2"]]
    }
  }
  RDS = {
    rds_4 = {
      dbname     = module.RDS.RDS["rds_4"].db_name
      dbusername = module.RDS.RDS["rds_4"].username
      dbhost     = module.RDS.RDS["rds_4"].address
      dbpassword = module.RDS.RDS["rds_4"].password
    }
  }
  vpc_id = module.network.vpc_id
}

data "aws_availability_zones" "available" {
  state = "available"
}



data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical official

}
