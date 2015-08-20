#!/usr/bin/env bash

APPS=( chrony git mlocate tree zsh)
DAEMONS=( chronyd )

# Set locale.
localectl set-locale LANG=ja_JP.UTF-8
localectl set-keymap jp106

# Set timezone.
timedatectl set-timezone Asia/Tokyo
cp /usr/share/zoneinfo/Japan /etc/localtime

# Update system.
yum -y update

# Install Development tools.
yum -y groupinstall "Development Tools"

# Install essential apps.
# - chrony  ... NTP Server
# - git     ... Version Control System
# - mlocate ... Find files by name quickly.
# - tree    --- List contents of directories in a tree-like format.
# - zsh     ... the Z shell (optional)
yum install -y $packages ${APPS[@]}

# Configure git.
git config --global color.ui true

# Update mlocate databse.
updatedb

# Enable and start daemons.
for daemon in ${DAEMONS[@]}
do
  systemctl enable ${daemon} 
  systemctl start ${daemon}
done
