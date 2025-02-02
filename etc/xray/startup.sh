#!/bin/sh

# Ensure this script runs only once per boot
if [ -f /tmp/xray_startup_executed ]; then
  # The file exists, so do not run the script
  echo "This script was executed already. To revert the results, reboot the device"
  exit 0
fi

# Source the function definitions
. /etc/xray/fwd_functions.sh

# create chain
ip rule add fwmark 1 table 100
ip route add local 0.0.0.0/0 dev lo table 100
iptables -t mangle -N XRAY

# exclude private ipv4
iptables -t mangle -A XRAY -d 255.255.255.255/32 -j RETURN
iptables -t mangle -A XRAY -d 0.0.0.0/8 -j RETURN
iptables -t mangle -A XRAY -d 10.0.0.0/8 -j RETURN
iptables -t mangle -A XRAY -d 100.64.0.0/10 -j RETURN
iptables -t mangle -A XRAY -d 127.0.0.0/8 -j RETURN
iptables -t mangle -A XRAY -d 169.254.0.0/16 -j RETURN
iptables -t mangle -A XRAY -d 172.16.0.0/12 -j RETURN
iptables -t mangle -A XRAY -d 192.0.0.0/24 -j RETURN
iptables -t mangle -A XRAY -d 192.0.2.0/24 -j RETURN
iptables -t mangle -A XRAY -d 192.168.0.0/16 -j RETURN
iptables -t mangle -A XRAY -d 198.18.0.0/15 -j RETURN
iptables -t mangle -A XRAY -d 198.51.100.0/24 -j RETURN
iptables -t mangle -A XRAY -d 203.0.113.0/24 -j RETURN
iptables -t mangle -A XRAY -d 224.0.0.0/4 -j RETURN
iptables -t mangle -A XRAY -d 240.0.0.0/4 -j RETURN


# !!! PROVIDE YOUR OWN IP HERE !!!
iptables -t mangle -A XRAY -d 1.1.1.1 -j RETURN



# exclude from Xray the following:
# SAMPLE - you can test the rules using /root/fwd_manual.sh script
# traefik HTTP+HTTPS
#direct_port_range_for_ip "10.241.1.165" 80 443



# add forwarding rule
iptables -t mangle -A XRAY -p tcp -j TPROXY --on-port 61219 --tproxy-mark 1
iptables -t mangle -A XRAY -p udp -j TPROXY --on-port 61219 --tproxy-mark 1
iptables -t mangle -A PREROUTING -j XRAY

# required for check above
touch /tmp/xray_startup_executed