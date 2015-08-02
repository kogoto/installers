#!/usr/bin/env bash

systemctl stop nginx.service
systemctl disable nginx.service
rm -rf /usr/lib/systemd/system/nginx.service

INSTALL_DIRS=( /etc/nginx /var/log/nginx /usr/sbin/nginx /var/cache/nginx )

for dir in ${INSTALL_DIRS[@]}
do
  [ -e $dir ] && rm -rf $dir
done

userdel nginx
