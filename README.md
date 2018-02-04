# b3coind_install

This script automates the installation of the **B3Coin** wallet application for Linux to be used on a **Fundamental Node** deployment.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Ubuntu 16.04

If you are running a Ubuntu 16.04 docker containier you will need to install the following packages.

```
apt-get update
apt-get -y install curl ufw
```

### Installing

```
curl https://raw.githubusercontent.com/amosin/b3coind_install/master/b3coind_install.sh | sh
```

## Running the tests

After the script finishes running you should verify if your wallet has caught up with the blockchain.

Login as b3fn01 user:
```
su - b3fn01
```

Check which block the wallet is at:
```
b3coind getblockcount
```

Compare the above output with the latest block on: https://chainz.cryptoid.info/b3/

## Versioning

02/04/2018 - This script will install the current version of the B3Coin wallet 3.1.1.2.

## Authors

* **Monerador** - *Initial work* - [amosin](https://github.com/amosin)

## Donations:

My B3Coin Wallet Address: SYLjy5hzCGwcppLjhtudGy5You1NZuEnqf
