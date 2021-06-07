#!/bin/sh

iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -N DmzRed
iptables -N RedDmz
iptables -N DmzAll
iptables -N AllDmz
iptables -N GreenDmz
iptables -N DmzGreen

iptables -A FORWARD -i eth1 -d 10.0.0.0/21 -j DmzRed
iptables -A FORWARD -i eth0 -m state --state ESTABLISHED,RELATED -j RedDmz
iptables -A FORWARD -i eth1 -p tcp --match multiport --sports 53,25,21 -j DmzAll
iptables -A FORWARD -i eth0 -p tcp --match multiport --dports 53,25,21 -j AllDmz
iptables -A FORWARD -i eth0 -s 10.0.10.0/24 -j GreenDmz
iptables -A FORWARD -i eth1 -o eth0 -d 10.0.10.0/24 -m state --state ESTABLISHED,RELATED -j DmzGreen

iptables -A DmzRed -j ACCEPT
iptables -A RedDmz -j ACCEPT
iptables -A DmzAll -j ACCEPT
iptables -A AllDmz -j ACCEPT
iptables -A GreenDmz -j ACCEPT
iptables -A DmzGreen -j ACCEPT

# Rendo accessibile il servizio smtp su porta 25 da qualsiasi host
iptables -N AllSmtp
iptables -N SmtpAll
iptables -A FORWARD -i eth0 -o eth1 -p tcp -d 10.0.9.2 --dport 25 -j AllSmtp
iptables -A FORWARD -i eth1 -o eth0 -p tcp -s 10.0.9.2 --sport 25 -m state --state ESTABLISHED,RELATED -j SmtpAll
iptables -A AllSmtp -j ACCEPT
iptables -A SmtpAll -j ACCEPT

# Rendo accessibile il servizio HTTPS su porta 443 da qualsiasi host
iptables -N AllHttps
iptables -N HttpsAll
iptables -A FORWARD -i eth0 -o eth1 -p tcp -d 10.0.8.2 --dport 443 -j AllHttps
iptables -A FORWARD -i eth1 -o eth0 -p tcp -s 10.0.8.2 --sport 443 -m state --state ESTABLISHED,RELATED -j HttpsAll
iptables -A AllHttps -j ACCEPT
iptables -A HttpsAll -j ACCEPT
