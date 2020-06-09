#!/bin/bash
sudo apt install nfs-kernel-server
PUBLIC='ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhB1D/ATcatBF+8L/qrN4PPd7ctJ98rqMbOrsaVnCWep7trocQrkEX2veVxp8ivchfO1irAH2I++jxl9TEdShkW3F7yhMjkldLR2omCG4gKMI+5Vo5OBDCWjiH6CpboSD51359yCaTGPprckJU4rxfNHmmO3ukpDgK94rLOkDi1yOZ3RRjckoRPFfSMgZufgBnIn4sxnJl1liCFbaB/9HDMaCk55Do+orCQqLE90b0PAuJpn0nCxWl9NWH1y35R1UU5m50QVYcZPF16Cx7he27Cmvlld5/NbC7ADQlVqmquqj1yONvZkZl4sXuOPuOdxupXNOW9oCnakskjqj3iQgZQ== ts3'
echo "Starting SSH setup!"
sudo mkdir ~/.ssh
sudo chmod 700 ~/.ssh
sudo echo $PUBLIC > ~/.ssh/authorized_keys
sudo chmod 600 ~/.ssh/authorized_keys
sudo chown -R $(whoami):$(whoami) ~/.ssh/
echo "SSH key done!"

echo "Configurating SSH config files!"
sudo awk -i inplace '{sub(/#Port 22/,"Port '$((RANDOM%65535+1026))'")}1' /etc/ssh/sshd_config
sudo awk -i inplace '{sub(/PermitRootLogin yes/,"PermitRootLogin no")}1' /etc/ssh/sshd_config
sudo awk -i inplace '{sub(/#MaxAuthTries 6/,"MaxAuthTries 4")}1' /etc/ssh/sshd_config
sudo awk -i inplace '{sub(/#MaxSessions 10/,"MaxSessions 5")}1' /etc/ssh/sshd_config
sudo awk -i inplace '{sub(/PasswordAuthentication yes/,"PasswordAuthentication no")}1' /etc/ssh/sshd_config
sudo awk -i inplace '{sub(/X11Forwarding yes/,"X11Forwarding no")}1' /etc/ssh/sshd_config
echo "SSH config file has been modified!"

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
rm .port.txt
rm .port1.txt