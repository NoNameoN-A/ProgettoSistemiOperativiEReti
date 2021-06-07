#!/bin/sh

# Flush ed eliminazione
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Setting policy default
#iptables -P(Policy) INPUT(Su cosa va monitorato) DROP(Azione)
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Regole per ristabilire le connessioni ssh
iptables -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT
#iptables -A(Tipo di connessione) OUTPUT -o eth0(-o output su interfaccia ethx) -p tcp(Protocollo usato)$
iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED,RELATED -j ACCEPT

# Catene
#iptables -N(Nuova) GreenAll(Nome catena)
iptables -N GreenAll
iptables -N AllGreen

# Aggancio delle sottocatene alle catene di default
#iptables -A FORWARD -i eth1 -j GreenAll
# Tutti i pacchetti sottorete che devono transitare per eth1 in mod. input allora verranno gestiti da Gr$
iptables -A FORWARD -i eth1 -j GreenAll
iptables -A FORWARD -o eth1 -j AllGreen

# GreenAll && AllGreen
iptables -A GreenAll -j ACCEPT
iptables -A AllGreen -m state --state ESTABLISHED,RELATED -j ACCEPT

# Abilito ssh su F2
iptables -A FORWARD -i eth0 -o eth2 -p tcp -d 10.0.11.6 --dport 22 -j ACCEPT
iptables -A FORWARD -i eth2 -o eth0 -p tcp -s 10.0.11.6 --sport 22 -j ACCEPT

# Abilito PC3 ad andare su Internet
iptables -A FORWARD -i eth2 -o eth0 -s 10.0.0.2 -j ACCEPT
iptables -A FORWARD -i eth0 -o eth2 -d 10.0.0.2 -m state --state ESTABLISHED,RELATED -j ACCEPT

# DNatto smtp su porta 25 verso 10.0.9.2
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 25 -j DNAT --to-destination 10.0.9.2
# DNatto dns su porta 53 verso xx.x.x.x
#iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 53 -j DNAT --to-destination xx.x.x.x
# DNatto ftp su porta 21 verso xx.x.x.x
#iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 21 -j DNAT --to-destination xx.x.x.x