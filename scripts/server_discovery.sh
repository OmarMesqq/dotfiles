#!/bin/bash 

# Wait for user input
echo -n "Enter domain name: (example.com)"
read var

# Color and escape sequence definition (thanks StackOverflow)
CYN='\e[36m'
END='\e[0m'

# Function for the "..." effect
points() {
	for i in {0..4}
	do 
		echo -e -n "${CYN}.${END}"
		sleep 0.1s
	done
	echo ""
}

# Colored text output
col() { 
	echo -e -n "${CYN}$1${END}"
}


scan() {
	col "Starting Nmap scan"
	points
	nmap $1
	
	col "Starting wget scan"
	points	
	wget --server-response --spider $1

	col "Starting curl scan"
	points
	curl --head $1 
}

scan $var

