#!/bin/sh
# Depends on: ipcalc ip nmap


# Prints default gateway as a string by getting the route to Quad9 DNS server
get_gateway() {
	echo $(ip route get 9.9.9.9 | awk '{print $3}') 
}
gateway=$(get_gateway) 


# Filters IPCalc output to locate the subnet mask
get_subnet_mask() {
	ipcalc $gateway | grep Netmask | awk '{print$4}'
}
subnet=$(get_subnet_mask)


# Discover local hosts
nmap $gateway/$subnet

