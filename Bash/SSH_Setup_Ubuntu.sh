#!/bin/bash
echo "Do you need to setup an ssh key?(Y/N)"
read KEYSET
if [ $KEYSET -eq Y ]
then
    echo "What is your public key?"
    read KEY
    PUBLIC=$KEY
    sudo mkdir ~/.ssh
    sudo chmod 700 ~/.ssh
    sudo echo $PUBLIC > ~/.ssh/authorized_keys
    sudo chmod 600 ~/.ssh/authorized_keys
    sudo chown -R $(whoami):$(whoami) ~/.ssh/
    echo "SSH key done!"
else
    echo "skipping ssh key setup!"
fi

echo "Configurating SSH config files!"
echo "Backing up the config file!"
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
echo "Backup done! search for sshd_config.bak if you want to revert"
echo "Do you want to change the port?(Y/N)"
read PORT
if [ $PORT -eq "Y"]
then
    sudo awk -i inplace '{sub(/#Port 22/,"Port '$((RANDOM%65535+1026))'")}1' /etc/ssh/sshd_config
else
    echo "skipping port change!"
fi

sudo awk -i inplace '{sub(/PermitRootLogin yes/,"PermitRootLogin no")}1' /etc/ssh/sshd_config
sudo awk -i inplace '{sub(/#MaxAuthTries 6/,"MaxAuthTries 4")}1' /etc/ssh/sshd_config
sudo awk -i inplace '{sub(/#MaxSessions 10/,"MaxSessions 5")}1' /etc/ssh/sshd_config
sudo awk -i inplace '{sub(/PasswordAuthentication yes/,"PasswordAuthentication no")}1' /etc/ssh/sshd_config
sudo awk -i inplace '{sub(/X11Forwarding yes/,"X11Forwarding no")}1' /etc/ssh/sshd_config
echo "SSH config file has been modified!"

echo "is this system is Debian (Ubuntu) or RedHat?(D/R)"
read SYS
if [ $SYS -eq "R"]
then
    echo "Adding exception to semanage!"
    sudo awk 'NR==17{print}' /etc/ssh/sshd_config > .port.txt
    awk '{gsub("Port ", "");print}' .port.txt > .port1.txt
    FILE=".port1.txt"
    PORT=$(awk '{ print $1 }' $FILE)
    sudo semanage port -a -t ssh_port_t -p tcp "$PORT"
    echo "restarting SSH service"
    sudo systemctl reload sshd.service
    echo "SSH service restarted!"
    echo "Your SSH port is '$PORT'"
else
    echo "Setting up exception on Ubuntu"
fi
echo "Is the ubuntu system has a firewall up (UFW)? (Y/N)"
read FIRE
if [ $FIRE -eq "Y"]
then
    sudo ufw allow $PORT
else
    echo "Then everything should be setup for you!"
rm .port.txt
rm .port1.txt