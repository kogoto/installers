#!/usr/bin/env bash

yum -y install httpd

firewall-cmd --add-service=http --zone=public
