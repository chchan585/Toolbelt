## Reload systemd manager configuration. 
## This step is necessary when you add a new service
sudo systemctl daemon-reload

## register and enable the start-code-server service
## after this, the instance will start this service on boot
sudo systemctl enable /home/dev/code-server-install/start-code-server.service

## start the service
sudo systemctl start start-code-server