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
wget -O /home/dev/code-server-install/start-code-server.sh https://raw.githubusercontent.com/chchan585/Toolbelt/main/EC2/vscode-tunnel/start-code-server.sh
chmod 745 /home/dev/code-server-install/start-code-server.sh

## create start-code-server.service
wget -O /home/dev/code-server-install/start-code-server.service https://raw.githubusercontent.com/chchan585/Toolbelt/main/EC2/vscode-tunnel/start-code-server.service
chmod 664 /home/dev/code-server-install/start-code-server.service

## get enable-code-server-service.sh from github
wget -O /home/dev/code-server-install/enable-code-server-service.sh https://raw.githubusercontent.com/chchan585/Toolbelt/main/EC2/vscode-tunnel/enable-code-server-service.sh
chmod 745 /home/dev/code-server-install/enable-code-server-service.sh

## change back the ownweship to dev
chown -R dev /home/dev/code-server-install
chown -R dev /home/dev/log

## setup guide:
## 0. Set this in user data field or manually execute: "wget -O- https://raw.githubusercontent.com/chchan585/Toolbelt/main/EC2/vscode-tunnel/user_data.sh | sh"
## 1. run "sudo -i -u dev code-server --accept-server-license-terms", do the initial work then quit
## 2. "sudo -i -u dev /home/dev/code-server-install/enable-code-server-service.sh"


