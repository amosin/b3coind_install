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
apt-get install -y build-essential libssl-dev libdb++-dev libboost-all-dev libqrencode-dev unzip wget

# Install b3coind
wget https://github.com/amosin/b3coind_install/raw/master/b3coind-3.1.1.2.deb -O /var/cache/apt/archives/b3coind-3.1.1.2.deb

apt-get install /var/cache/apt/archives/b3coind-3.1.1.2.deb


# Swap
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
chmod 600 /var/swap.1
/sbin/swapon /var/swap.1
echo "/var/swap.1 swap swap defaults 0 0" >> /etc/fstab


su -c "mkdir ~/.B3-CoinV2" -s /bin/sh b3fn01
su -c "cat > ~/.B3-CoinV2/b3coin.conf << EOF
rpcuser=b3coinrpc
rpcpassword=`openssl rand -base64 32`
EOF" -s /bin/sh b3fn01
su -c "wget https://github.com/B3-Coin/B3-CoinV2/releases/download/v3.1.1.2/b3bootstrap.zip -O /home/b3fn01/.B3-CoinV2/b3bootstrap.zip" -s /bin/sh b3fn01
su -c "unzip ~/.B3-CoinV2/b3bootstrap.zip -d ~/.B3-CoinV2/ && rm ~/.B3-CoinV2/b3bootstrap.zip" -s /bin/sh b3fn01
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
