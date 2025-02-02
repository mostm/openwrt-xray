#!/bin/sh
opkg update

opkg install xray-core
# i don't actually know which ones are required for nftables cmds to work...
opkg install iptables-mod-conntrack-extra
opkg install iptables-mod-ipopt
opkg install iptables-mod-socket
opkg install iptables-mod-tproxy
opkg install iptables-zz-legacy
opkg install kmod-ipt-compat-xtables
opkg install kmod-ipt-conntrack
opkg install kmod-ipt-conntrack-extra
opkg install kmod-ipt-core
opkg install kmod-ipt-ipopt
opkg install kmod-ipt-socket
opkg install kmod-ipt-tproxy
opkg install kmod-nf-conncount
opkg install kmod-nf-conntrack
opkg install kmod-nf-conntrack6
opkg install kmod-nf-flow
opkg install kmod-nf-ipt
opkg install kmod-nf-ipt6
opkg install kmod-nf-log
opkg install kmod-nf-log6
opkg install kmod-nf-nat
opkg install kmod-nf-reject
opkg install kmod-nf-reject6
opkg install kmod-nf-socket
opkg install kmod-nf-tproxy
opkg install kmod-nfnetlink
opkg install kmod-nft-core
opkg install kmod-nft-fib
opkg install kmod-nft-nat
opkg install kmod-nft-offload
opkg install kmod-nft-tproxy

chmod +x /etc/xray/fwd_functions.sh
chmod +x /etc/xray/startup.sh
chmod +x /etc/init.d/xray
chmod +x /root/restart_xray.sh
chmod +x /root/fwd_manual.sh