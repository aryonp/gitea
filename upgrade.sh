#!/bin/bash
NEWEST=1.4.2
HDIR=/home/git
cd $HDIR/git
sudo service gitea stop
sudo mv gitea gitea.old
wget -c -O gitea https://dl.gitea.io/gitea/$NEWEST/gitea-$NEWEST-linux-amd64
sudo chown -R git:git $HDIR/
sudo chmod -R 0775 $HDIR/
sudo service gitea start
sudo service gitea status
sudo rm -rf gitea.old
