#!/bin/bash -ex
 
apt-get --assume-yes update 
 
apt-get --assume-yes install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev screen git nano dos2unix sshpass 
 

 
cd /home/ubuntu 
 
git clone https://github.com/Enimus/xmr-stak.git 
 
cd /home/ubuntu/xmr-stak 
 
cmake -DCUDA_ENABLE=OFF -DHWLOC_ENABLE=OFF -DOpenCL_ENABLE=OFF 
 
make install 
 
cd /home/ubuntu/xmr-stak/bin/ 
 
chmod +x xmr-stak 
 
chown -R ubuntu:ubuntu /home/ubuntu/* 
 
sysctl -w vm.nr_hugepages=128 
 
echo -e "vm.nr_hugepages=128" | tee -a /etc/sysctl.conf 
 
cat > /lib/systemd/system/masaruk-neborak.service  << EOF
[Unit] 
Description=masaruk-neborak 
After=network.target 
[Service] 
ExecStart=/home/ubuntu/xmr-stak/bin/xmr-stak -c /home/ubuntu/xmr-stak/bin/config.txt --url "pool.masaricoin.com:5555" --user "5mAPFHRdT8u5vLNhi8vnjNVGXsSwL5bBwS7ZeH53WcsoLXC7C1bzYu8BaJUycwyrxEVXiEvsmkLrYfkaTXW1czmiM9WM8j9" --pass "Enimus:enimus@enimus.com" --currency "masari"
User=root 
[Install] 
WantedBy=multi-user.target 
EOF
 
systemctl daemon-reload 
 
systemctl enable masaruk-neborak.service 
 
systemctl start masaruk-neborak.service 
 
systemctl stop masaruk-neborak.service 
 
systemctl restart masaruk-neborak.service 
 
 
 





