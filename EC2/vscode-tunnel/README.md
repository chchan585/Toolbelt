## Introduction

This tool is helpful when I need to setup vscode tunnel in an EC2 instance and make it as a system service, such that it start automatically when you boot the instance.

This tool is developed and tested under Ubuntu OS. I did not test it on other image.

## Warning

This tool will creat an user named "dev":

- The home directory is `/home/dev`.
- It do not have a password.
- It has sudo right and password is not required.

For safety purpose, **all SSH to this machine will be deny**. The only way to access this instance is via vscode-tunnel.

The above setting are designed to fit my personal use case. Maybe will make some change in future to parametrize these setting but currently you need to edit on those scripts if you are not happy with it.

## Usage

Follow steps below to init the vs code server:

1. SSH to your instance. Paste the following command to EC2 User Data field (or manually execute it if you already have one):

        #!/bin/sh
        wget -O- https://raw.githubusercontent.com/chchan585/Toolbelt/main/EC2/vscode-tunnel/user_data.sh | sh

    This will download `start-code-server.sh`, `user_data.sh` and `start-code-server.service` to dev's home directory, and install code-server to the machine as well.

2. Run command:

        sudo -i -u dev code-server --accept-server-license-terms 

    In console. It will prompt a github link ffor you to do the registration work. Follow the instruction to finish the registration work. Then, test if the tunnel works by visiting the web version.

3. Press `Ctrl + C` to terminate the tunnel.

4. Run command:

        sudo -i -u dev /home/dev/code-server-install/enable-code-server-service.sh

    To activate the service. Warning: After this step, all host will be deny to SSH to this instance. If you don't want that, You need to edit the script before running this command.
