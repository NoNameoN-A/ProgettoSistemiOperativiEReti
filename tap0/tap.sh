#!/bin/sh

# Creazione interfaccia di rete
tunctl -g netdev -t tap0
ifconfig tap0 10.0.11.13
ifconfig tap0 netmask 255.255.255.252
ifconfig tap0 broadcast 10.0.7.15
ifconfig tap0 up

# Regole di Firewalling
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t nat -A POSTROUTING -o wlp59s0 -j MASQUERADE
iptables -A FORWARD -i tap0 -j ACCEPT

# Abilito il forwarding su computer/host locale
sysctl -w net.ipv4.ip_forward=1

# Aggiungere le rotte

# Rotta TOTALE - Insicura
# route add -net 10.0.0.0/8 gw 10.0.11.14 dev tap0

# Rotta RED
route add -net 10.0.0.0/21 gw 10.0.11.14 dev tap0
# Rotta DMZ
route add -net 10.0.8.0/23 gw 10.0.11.14 dev tap0
# Rotta GREEN
route add -net 10.0.10.0/24 gw 10.0.11.14 dev tap0
# Rotta CD2
route add -net 10.0.11.0/30 gw 10.0.11.14 dev tap0
# Rotta CD4
route add -net 10.0.11.4/30 gw 10.0.11.14 dev tap0
# Rotta CD5
route add -net 10.0.11.8/30 gw 10.0.11.14 dev tap0
# Rotta INET - Diretta
# route add -net 10.0.11.12/30 gw 10.0.11.14 dev tap0