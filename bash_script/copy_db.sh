cat <<EOF > /mnt/linux/data/project/final-project/bash_script/web_app.sh
#!/bin/bash
sudo apt update
sudo apt install -y python3-pip > /dev/null 2>&1
sudo apt install python3-dev default-libmysqlclient-dev build-essential pkg-config -y > /dev/null 2>&1
git clone https://github.com/khaledeldsoky/SimpleDjangoApp.git /home/ubuntu/project
cd /home/ubuntu/project/
sudo pip3 install -r requirements.txt
sed -i "s/database_name/$1/g" config/settings.py
sed -i "s/database_username/$2/g" config/settings.py
sed -i "s/database_password/$3/g" config/settings.py
sed -i "s/database_host/$4/g" config/settings.py
sudo python3 manage.py migrate
sudo nohup python3 manage.py runserver 0.0.0.0:80 
EOF
