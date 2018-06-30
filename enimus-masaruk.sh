#!/bin/bash -ex 
 
sudo apt update -y 
 
cd /home/ubuntu 
 
sudo chmod +x enimus-update.sh 
 
sudo sh /home/ubuntu/xmr-stak/enimus-update.sh 
 
sudo git clone https://github.com/Enimus/xmr-stak.git 
  
 cd /home/ubuntu/xmr-stak 
 
sudo cmake -DCUDA_ENABLE=OFF -DHWLOC_ENABLE=OFF -DOpenCL_ENABLE=OFF 
 
make install 
 
cd /home/ubuntu/xmr-stak/bin/ 
 
sudo chmod +x xmr-stak 
 
sudo chown -R ubuntu:ubuntu /home/ubuntu/* 
 
sudo sysctl -w vm.nr_hugepages=128 
 
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
 
sudo systemctl daemon-reload 
 
sudo systemctl enable masaruk-neborak.service 
 
sudo systemctl start masaruk-neborak.service 
 
sudo systemctl stop masaruk-neborak.service 
 
sudo systemctl restart masaruk-neborak.service 
 
 
 





