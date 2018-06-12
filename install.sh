#!/bin/bash

NEWEST=1.4.2
HNAME=
HDIR=/home/git
IDIR=$HDIR/gitea-install

#create the user
sudo adduser git

#change dir
cd $HDIR/

#create dir
sudo mkdir $HDIR/git
sudo mkdir $HDIR/git/custom/https

#download the gitea
sudo wget -c -O $HDIR/git/gitea https://dl.gitea.io/gitea/$NEWEST/gitea-$NEWEST-linux-amd64

#change to executable
sudo chmod +x $HDIR/git/gitea

#create service
sudo cp $IDIR/gitea.service /etc/systemd/system/gitea.service
sudo systemctl enable gitea
sudo systemctl start gitea

#add ssl
cd $HDIR/git
./gitea cert -ca=true -duration=8760h0m0s -host=$HNAME
sudo mv *.pem $HDIR/git/custom/https/

#copy config file
sudo cp $IDIR/app.ini $HDIR/git/custom/conf/app.ini

#change all files ownership
sudo chown -R git:git $HDIR/
sudo chmod -R 0775 $HDIR/

#delete install file
sudo rm -rf $HDIR/gitea-install.tar.gz
