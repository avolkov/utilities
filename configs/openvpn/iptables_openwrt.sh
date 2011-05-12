#Allow Incoming connections on WAN interface (Needed for port forwaring)
/usr/sbin/iptables -D zone_wan_forward 1
/usr/sbin/iptables -D zone_wan_forward 1
#Allow  Tunnels Created by OpenVPN
/usr/sbin/iptables -I INPUT -i tun+ -j ACCEPT
/usr/sbin/iptables -I FORWARD -i tun+ -j ACCEPT
/usr/sbin/iptables -I OUTPUT -o tun+ -j ACCEPT
/usr/sbin/iptables -I FORWARD -o tun+ -j ACCEPT
#Map current network to 10.52.12.0/24
#NOTE: rule requires kmod-ipt-nat-extra & iptables-mod-nat-extra to be installed
/usr/sbin/iptables -t nat -i tun1 -A PREROUTING --destination 10.52.12.0/24 -j NETMAP --to 192.168.1.0/24
/usr/sbin/iptables -t nat -o tun1 -A POSTROUTING --source 192.168.1.0/24 -j NETMAP --to 10.52.12.0/24
# UPDATED: Allow access to 10.52.12.0/24 from internal network 192.168.10.0/24
# Same as the set of rules above the following require kmod-ipt-nat-extra & iptables-mod-nat-extra to be installed
/usr/sbin/iptables -I FORWARD -i br-lan -j ACCEPT
/usr/sbin/iptables -t nat -i br-lan -A PREROUTING --destination 10.52.12.0/24 -j NETMAP --to 192.168.1.0/24
/usr/sbin/iptables -t nat -o br-lan -A POSTROUTING --source 192.168.1.0/24 -j NETMAP --to 10.52.12.0/24
