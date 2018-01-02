#!/bin/bash
Â# Updates the plexmediaserver service with thegiven .rpm package

sudo service plexmediaserver stop
sudo yum localupdate -y $1
sudo service plexmediaserver start

echo "Installation complete"
