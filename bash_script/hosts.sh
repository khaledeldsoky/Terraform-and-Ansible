cat  <<-OEF  > /mnt/linux/data/project/final-project/ansible/hosts
[bastion]
$1
$2
[private]
privateinstance1 ansible_host=$3 ansible_user=ubuntu ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p bastion"'
privateinstance2 ansible_host=$4 ansible_user=ubuntu ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p bastion"'
OEF