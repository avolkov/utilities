#####log to a separate file in /etc/syslog.conf or /etc/rsyslog.conf add:

kern.* -/var/log/firewall

######
iptables -A INPUT -p tcp --dport 80 -j LOG --log-level=7 --log-prefix "HTTP connection:"


iptables -A INPUT -p tcp --dport 80 -m state --state NEW -m iprange ! --src-range 127.0.0.1-127.255.255.255 -j LOG --log-level=7 --log-prefix="HTTP Conn:"

iptables -A INPUT -p tcp --dport 80 -m state --state NEW -j LOG --log-level=7 --log-prefix="HTTP new:"

iptables -A INPUT -p tcp -m state --state NEW -j LOG --log-level=7 --log-prefix="HTTP new1:"


iptables -A OUTPUT -p tcp -m state --state NEW -j LOG --log-level=7 --log-prefix="HTTP new2:"

##forward table the one that produces output on that machine
iptables -I FORWARD 1 -p tcp --dport 80 -m state --state NEW -j LOG --log-level=7 --log-prefix="HTTP test forward:"

iptables -I FORWARD 1 -m state --state NEW --src 192.168.1.91 -j LOG --log-level=7 --log-prefix="Machine_x: "

iptables -I FORWARD 1 -m state --state NEW -m iprange --dst-range 69.22.138.0-69.22.138.255 -j LOG --log-level=7 --log-prefix="AKAMAI:"
iptables -I FORWARD 1 -m state --state NEW -m iprange --dst-range 216.34.181.0-216.34.181.255 -j LOG --log-level=7 --log-prefix="SourceForge:"



####Check to whom ip block belongs

##IP Block
for k in $(grep -o "DST=[0-9]\+[.][0-9]\+[.][0-9]\+[.][0-9]\+" firewall | sed 's/DST=//' | sort |uniq); do echo -n "$k --- "; whois $k | grep -i netname  ; done
##IP Only
grep -o "DST=[0-9]\+[.][0-9]\+[.][0-9]\+[.][0-9]\+" firewall | sed 's/DST=//' | sort |uniq
#hostnames
for k in $(grep -o "DST=[0-9]\+[.][0-9]\+[.][0-9]\+[.][0-9]\+" firewall | sed 's/DST=//' | sort |uniq); do echo -ne "$k\t"; host $k  ; done