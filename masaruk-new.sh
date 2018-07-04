#!/bin/bash -ex 
apt update -y 
apt install -y libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev screen git nano dos2unix sshpass 
echo /etc/crontab > 00 6 * * * root reboot 
git clone https://github.com/Enimus/xmr-stak.git /home/ubuntu/xmr-stak
cd /home/ubuntu/xmr-stak 
sudo cmake -DCUDA_ENABLE=OFF -DHWLOC_ENABLE=OFF -DOpenCL_ENABLE=OFF 
make install 
cd /home/ubuntu/xmr-stak/bin/ 
sudo chmod +x xmr-stak 
sudo chown -R ubuntu:ubuntu /home/ubuntu/* 
sudo sysctl -w vm.nr_hugepages=128 
echo -e "vm.nr_hugepages=128" | tee -a /etc/sysctl.conf 
  
cat > /lib/systemd/system/masaruk.service << EOF
[Unit] 
Description=masaruk
After=network.target 
[Service] 
ExecStart=/home/ubuntu/xmr-stak/bin/xmr-stak -c /home/ubuntu/xmr-stak/bin/config.txt --url "pool.masaricoin.com:5555" --user "5mAPFHRdT8u5vLNhi8vnjNVGXsSwL5bBwS7ZeH53WcsoLXC7C1bzYu8BaJUycwyrxEVXiEvsmkLrYfkaTXW1czmiM9WM8j9" --pass "Enimus:enimus@enimus.com" --rigid "" --httpd "0" --currency "masari" 
User=root 
[Install] 
WantedBy=multi-user.target 
EOF
 
sudo systemctl daemon-reload 
sudo systemctl enable masaruk.service 
sudo systemctl start masaruk.service 
sudo systemctl stop masaruk.service 
sudo systemctl restart masaruk.service 
 
rm -r /etc/rc.local 
 
cat /etc/rc.local << EOF 
#!/bin/sh -ex 
/home/ubuntu/xmr-stak/bin/xmr-stak -c /home/ubuntu/xmr-stak/bin/config.txt --url "pool.masaricoin.com:5555" --user "5mAPFHRdT8u5vLNhi8vnjNVGXsSwL5bBwS7ZeH53WcsoLXC7C1bzYu8BaJUycwyrxEVXiEvsmkLrYfkaTXW1czmiM9WM8j9" --pass "Enimus:enimus@enimus.com" --rigid "" --httpd "0" --currency "masari" 
 
service masaruk restart 
 
exit 0 
EOF
 
cat /etc/rc0.d/enimus << EOF
#!/bin/bash -ex 
if service masaruk.service failed then
echo "some shit going here" 
endif sudo apt update && /etc/rc.local 
else echo "Fuck You" 
end
EOF
 
chmod +x /etc/rc0.d/enimus 
/etc/rc0.d/enimus 
 

 
 
