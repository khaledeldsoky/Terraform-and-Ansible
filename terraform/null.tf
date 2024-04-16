resource "null_resource" "bash_script" {

    triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = <<-EOF
   ../bash_script/hosts.sh ${module.ec2.ec2["public_ec2_1"].public_ip} ${module.ec2.ec2["public_ec2_2"].public_ip}  ${module.ec2.type_private_ips[0]} ${module.ec2.type_private_ips[1]} 
   ../bash_script/ssh_config.sh ${module.ec2.ec2["public_ec2_1"].public_ip}  ${module.ec2.type_private_ips[0]} ${module.ec2.type_private_ips[1]} 
   ../bash_script/nginx_proxy.sh ${module.lb.my_load_balancer_dns_name_private}
    ../bash_script/copy_db.sh  ${module.RDS.rds_db_name}  ${module.RDS.rds_username}  ${module.RDS.rds_password} ${module.RDS.rds_address}
    EOF
  }

  depends_on = [
    module.ec2,
    module.lb,
    module.launch_template
  ]
}


resource "null_resource" "ansible" {
  depends_on = [ null_resource.bash_script ]
  provisioner "local-exec" {
    command = <<-EOF
     cd ../ansible
     ansible-playbook -i hosts playbook.yaml 
    EOF
  }
}



