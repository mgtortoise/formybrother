apt install dropbear -y
apt install cmake -y
apt install unzip -y
apt install screen -y
apt install wget -y
apt install python -y
apt install stunnel4 -y
wget https://github.com/ambrop72/badvpn/archive/master.zip
unzip master.zip
cd badvpn-master
mkdir build
cd build
cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_TUN2SOCKS=1 -DBUILD_UDPGW=1;make install;
wget https://raw.githubusercontent.com/mgtortoise/bashMe/main/dropbear
wget https://raw.githubusercontent.com/mgtortoise/pdme/main/main.py
wget https://github.com/mgtortoise/pdme/blob/main/websocket.service
wget https://raw.githubusercontent.com/mgtortoise/hellogithub/master/stunnel.conf
wget https://raw.githubusercontent.com/mgtortoise/hellogithub/master/stunnel4
mv main.py websocket.service /etc/systemd/system/
rm -rf /etc/default/dropbear
mv dropbear /etc/default/dropbear
/etc/init.d/dropbear restart
rm -rf /etc/stunnel/stunnel.conf
mv stunnel.conf /etc/stunnel/stunnel.conf
rm -rf /etc/default/stunnel4
mv stunnel4 /etc/default/stunnel4
mkdir ssl_cert
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem>> /etc/stunnel/stunnel.pem
sudo /etc/init.d/stunnel4 restart
systemctl restart websocket.service
systemctl enable websocket.service
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300
