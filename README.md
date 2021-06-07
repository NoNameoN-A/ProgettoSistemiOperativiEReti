# ProgettoSistemiOperativiEReti
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FNoNameoN-A%2FProgettoSistemiOperativiEReti&count_bg=%231C1C1C&title_bg=%231C1C1C&icon=internetexplorer.svg&icon_color=%23E7E7E7&title=Views+Count&edge_flat=false)](https://github.com/NoNameoN-A/ProgettoSistemiOperativiEReti)

Creazione di una infrastruttura di rete con configurazione di:
- Interfaccia di rete tap0 per collegamento a internet PREROUTING
- Firewall secondo direttive della traccia
- Subnet e calcolo di Network-Netmask-Broadcast a mano per tutte le aree, server e alcuni dispositivi utente
- Configurazione dei router 
- DNATting POSTROUTING

Software usati:
- GNS3 per gestire l'infrastruttura anche visivamente
- VirtualBox per caricare le macchine virtuali

File gestiti:
- Interfaccia della macchina /etc/network/interfaces
- File host per il collegamento manuale ad uno o più dns /etc/host
- Creazione di uno script firewall.sh con comandi prevalentemente di tipo iptables

La Macchina Virtuale usata mi è stata fornita dal docente e per tanto non è stata pubblicata nel progetto.


## Traccia
![Topologia](https://github.com/NoNameoN-A/ProgettoSistemiOperativiEReti/blob/main/topologia/%5BTraccia%5D%20Topologia.png)

## Topologia GNS3
![Topologia](https://github.com/NoNameoN-A/ProgettoSistemiOperativiEReti/blob/main/topologia/%5BGNS3%5D%20Topologia.png)

