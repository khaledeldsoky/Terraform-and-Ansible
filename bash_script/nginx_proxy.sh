cat <<OEF > /mnt/linux/data/project/final-project/ansible/nginx_proxy/templates/nginx_proxy.conf
server {
    listen 80;
    location / {
        proxy_pass http://$1;
    }
}
OEF