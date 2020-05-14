#!/bin/bash
if [[ ! $(sudo iptables -nvL | grep 6443) ]];then
  sudo iptables -A INPUT -p tcp -m tcp --dport 6443 -j ACCEPT
fi
