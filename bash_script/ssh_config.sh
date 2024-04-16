cat <<EOF > ~/.ssh/config 
host bastion
   HostName $1
   User ubuntu
   IdentityFile /mnt/linux/data/project/final-project/terraform/khaled-key.pem
   StrictHostKeyChecking=no

host privateinstance1
   HostName  $2
   user  ubuntu
   IdentityFile /mnt/linux/data/project/final-project/terraform/khaled-key.pem
   ProxyCommand ssh -q -W %h:%p  bastion
   StrictHostKeyChecking=no

host privateinstance2
   HostName  $3
   user  ubuntu
   IdentityFile /mnt/linux/data/project/final-project/terraform/khaled-key.pem
   ProxyCommand ssh -q -W %h:%p  bastion
   StrictHostKeyChecking=no

EOF
