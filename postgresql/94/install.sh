#!/usr/bin/env bash

RPM=pgdg-centos94-9.4-1.noarch.rpm
REPO=http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/$RPM

if [ ! -e $RPM ]; then
  wget $REPO
fi

rpm -ivh $REPO

yum -y install postgresql94
yum -y install pgpool-II-94
