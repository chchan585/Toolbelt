#!/bin/sh

## create user 'dev' with home directory = /home/dev, give sudo right
useradd --shell /bin/bash -m dev 
usermod -aG sudo dev
echo 'dev ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo # if you concern about security, you can setup a password here instead of granting NOPASSWD to dev account

## create vscode install folder path
mkdir /home/dev/code-server-install
chmod 707 /home/dev/code-server-install

## create log folder
mkdir /home/dev/log
chmod 707 /home/dev/log

## install vscode-cli
wget -O- https://aka.ms/install-vscode-server/setup.sh | sh

## create start-code-server.sh
echo '#!/bin/sh' >> /home/dev/code-server-install/start-code-server.sh
echo 'nohup code-server --accept-server-license-terms >> /home/dev/log/code-server.log 2>&1 &' >> /home/dev/code-server-install/start-code-server.sh
chmod 745 /home/dev/code-server-install/start-code-server.sh

## create start-code-server.service
echo '[Unit] ' >> /home/dev/code-server-install/start-code-server.service 
echo 'After=network.target ' >> /home/dev/code-server-install/start-code-server.service 
echo '' >> /home/dev/code-server-install/start-code-server.service 
echo '[Service] ' >> /home/dev/code-server-install/start-code-server.service 
echo 'ExecStart=/home/dev/code-server-install/start-code-server.sh ' >> /home/dev/code-server-install/start-code-server.service 
echo 'Type=forking ' >> /home/dev/code-server-install/start-code-server.service 
echo 'User=dev ' >> /home/dev/code-server-install/start-code-server.service 
echo '' >> /home/dev/code-server-install/start-code-server.service 
echo '[Install] ' >> /home/dev/code-server-install/start-code-server.service 
echo 'WantedBy=default.target' >> /home/dev/code-server-install/start-code-server.service 
chmod 664 /home/dev/code-server-install/start-code-server.service

## create enable-code-server-service.sh
echo "sudo systemctl daemon-reload"  >> /home/dev/code-server-install/enable-code-server-service.sh
echo "sudo systemctl enable /home/dev/code-server-install/start-code-server.service"  >> /home/dev/code-server-install/enable-code-server-service.sh
echo "sudo systemctl start start-code-server"  >> /home/dev/code-server-install/enable-code-server-service.sh
chmod 745 /home/dev/code-server-install/enable-code-server-service.sh  

## change back the ownweship to dev
chown -R dev /home/dev/code-server-install
chown -R dev /home/dev/log

## setup guide:
## 1. run "sudo -i -u dev code-server --accept-server-license-terms", do the initial work then quit
## 2. "sudo -i -u dev /home/dev/code-server-install/enable-code-server-service.sh"
