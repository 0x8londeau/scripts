#!/bin/bash

# Function to check if input is IPv4
is_ipv4() {
  if [[ "$1" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    return 0  # True
  else
    return 1  # False
  fi
}

# Function to check if input is IPv6
is_ipv6() {
  if [[ "$1" =~ ^([a-fA-F0-9:]+:+)+[a-fA-F0-9]+$ ]]; then
    return 0  # True
  else
    return 1  # False
  fi
}

# Prompt user to enter subnet
read -p "Please enter the subnet to scan (e.g., 192.168.1 or 2001:db8::/64): " subnet

# Validate IPv4 or IPv6 format
if is_ipv4 "$subnet"; then
  echo "You entered an IPv4 subnet."
  subnet_type="IPv4"
elif is_ipv6 "$subnet"; then
  echo "You entered an IPv6 subnet."
  subnet_type="IPv6"
else
  echo "Invalid subnet format. Please enter a valid IPv4 or IPv6 subnet."
  exit 1
fi

# Initialize counter for live hosts
live_hosts=0

# Scan IPv4 network
if [[ "$subnet_type" == "IPv4" ]]; then
  # Loop through the possible host addresses (1-254)
  for ip in {1..254}; do
    # Ping each address once and wait for a response
    if ping -c 1 -W 1 "${subnet}.${ip}" > /dev/null 2>&1; then
      printf "Host %s.%d is live\n" "$subnet" "$ip"
      live_hosts=$((live_hosts + 1))
    fi
  done

# Scan IPv6 network
elif [[ "$subnet_type" == "IPv6" ]]; then
  # Use `ping6` to scan an IPv6 network (ping each IPv6 address once)
  for ip in $(seq 1 20); do  # Modify range as needed
    ip_address="${subnet}${ip}"  # Example: Append some numbers after the IPv6 subnet
    if ping6 -c 1 -W 1 "${ip_address}" > /dev/null 2>&1; then
      printf "Host %s is live\n" "$ip_address"
      live_hosts=$((live_hosts + 1))
    fi
  done
fi

# Print the number of live hosts
printf "Number of live hosts: %d\n" "$live_hosts"