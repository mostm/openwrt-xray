#!/bin/sh

# Function to add iptables rules for a specific IP and port
direct_port_for_ip() {
    ip=$1
    port=$2

    iptables -t mangle -A XRAY -d "$ip"/32 -p tcp --dport "$port" -j RETURN
    iptables -t mangle -A XRAY -d "$ip"/32 -p udp --dport "$port" -j RETURN
    iptables -t mangle -A XRAY -s "$ip"/32 -p tcp --sport "$port" -j RETURN
    iptables -t mangle -A XRAY -s "$ip"/32 -p udp --sport "$port" -j RETURN
}

# Function to add iptables rules for a single port without specifying IP
direct_port() {
    port=$1

    iptables -t mangle -A XRAY -p tcp --dport "$port" -j RETURN
    iptables -t mangle -A XRAY -p udp --dport "$port" -j RETURN
    iptables -t mangle -A XRAY -p tcp --sport "$port" -j RETURN
    iptables -t mangle -A XRAY -p udp --sport "$port" -j RETURN
}

# Function to add iptables rules for a range of ports for a specific IP
direct_port_range_for_ip() {
    ip=$1
    start_port=$2
    end_port=$3

    port=$start_port
    while [ "$port" -le "$end_port" ]; do
        direct_port_for_ip "$ip" "$port"
        port=$((port + 1))
    done
}

# Function to add iptables rules for a range of ports without specifying IP
direct_port_range() {
    start_port=$1
    end_port=$2

    port=$start_port
    while [ "$port" -le "$end_port" ]; do
        direct_port "$port"
        port=$((port + 1))
    done
}

# Function to add iptables rules for an IP without specifying ports
direct_ip() {
    ip=$1

    iptables -t mangle -A XRAY -d "$ip"/32 -j RETURN
    iptables -t mangle -A XRAY -s "$ip"/32 -j RETURN
}

# Function to add iptables rules for blocking IP
block_ip() {
    ip=$1

    iptables -I FORWARD 1 -d "$ip"/32 -j DROP
    iptables -I FORWARD 1 -s "$ip"/32 -j DROP
}
