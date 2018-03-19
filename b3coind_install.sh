#!/usr/bin/env bash

#Firewall
ufw allow 5647
#Time
timedatectl set-timezone Etc/UTC

# Create user
useradd -m -s /bin/bash b3fn01

# Give Permissions
echo "b3fn01 ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Hitory
echo set +o history >> /etc/profile

# Update

apt-get update 
apt-get upgrade -y
apt-get install -y libssl-dev libdb++-dev libboost-all-dev libqrencode-dev unzip wget

# Install b3coind
wget https://github.com/amosin/b3coind_install/raw/master/b3coind-3.1.2.2.deb -O /var/cache/apt/archives/b3coind-3.1.2.2.deb

apt-get install /var/cache/apt/archives/b3coind-3.1.2.2.deb

# bring up after reboot
echo "@reboot b3fn01 b3coind" > /etc/cron.d/fundamentalnodes

#Crontab to clear up logs
crontab -l | { cat; echo "0 0 * * * echo "" > /home/b3fn01/.B3-CoinV2/debug.log"; } | crontab -

# Swap
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=2048
chmod 600 /var/swap.1
mkswap /var/swap.1
/sbin/swapon /var/swap.1
echo "/var/swap.1 swap swap defaults 0 0" >> /etc/fstab


su -c "mkdir ~/.B3-CoinV2" -s /bin/sh b3fn01
su -c "cat > ~/.B3-CoinV2/b3coin.conf << EOF
rpcuser=b3coinrpc
rpcpassword=`openssl rand -base64 32`
rpcallowip=127.0.0.1
rpcport=15647
daemon=1
server=1
listen=1
promode=1
staking=0
maxconnections=125
logtimestamps=1
#fundamentalnode=1
#fundamentalnodeprivkey=
#fundamentalnodeaddr=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`:5647
bind=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
externalip=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
EOF" -s /bin/sh b3fn01
#su -c "wget https://github.com/B3-Coin/B3-CoinV2/releases/download/v3.1.2.0/b3bootstrap.zip -O /home/b3fn01/.B3-CoinV2/b3bootstrap.zip" -s /bin/sh b3fn01
#su -c "unzip ~/.B3-CoinV2/b3bootstrap.zip -d ~/.B3-CoinV2/ && rm ~/.B3-CoinV2/b3bootstrap.zip" -s /bin/sh b3fn01
su -c "b3coind" -s /bin/sh b3fn01 &
su - b3fn01
sleep 1
echo "."
sleep 1
echo ".."
sleep 2
echo "..."
echo 'Running b3coind getblockcount... Compare with https://chainz.cryptoid.info/b3/'
su -c "b3coind getblockcount" -s /bin/sh b3fn01 &
