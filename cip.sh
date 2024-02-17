#!/bin/bash

# MIT License

# Copyright (c) 2024 Mukund

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

tput clear

ANONTOR="
   _               _____        
  /_\  _ _  ___ _ |_   _|__ _ _ 
 / _ \| ' \/ _ \ ' \| |/ _ \ '_|
/_/ \_\_||_\___/_||_|_|\___/_|

By Mukund

Telegram :- @itzMukund
"

# Function to check if lolcat is installed
check_lolcat() {
    if command -v lolcat &> /dev/null; then
        echo "$ANONTOR" | lolcat
    else
        sudo apt-get install lolcat
        echo "$ANONTOR" | lolcat
    fi
}

# Check if lolcat is installed
check_lolcat

# Function to handle Ctrl+C signal
goodbye() {
    echo -e "\n\n \t\tGoodbye! Thanks for using AnonTor IP Changer." | lolcat
    exit 0
}

# Trap Ctrl+C signal to call the goodbye function
trap goodbye SIGINT

echo -e "\n \tChange your  SOCKES to 127.0.0.1:9050\n\n" | lolcat

# Function to prompt user for the interval
prompt_interval() {
    read -p "Enter the interval in seconds for changing IP address: " SECONDS_TO_WAIT 
}

# Function to prompt user for the number of times to change the IP address
prompt_change_count() {
    read -p "Enter the number of times to change the IP address (0 for continuous): " CHANGE_COUNT
}

# Function to change the IP address
change_ip() {
    # Generate a random IP address (replace this with your logic)
    NEW_IP="192.168.$((RANDOM % 256)).$((RANDOM % 256))"

    # Change the IP address using ifconfig (replace ifconfig with ip if using modern Linux systems)
    sudo ifconfig $INTERFACE $NEW_IP

    # Display the new IP address with lolcat
    echo "Changed IP address of $INTERFACE to: $NEW_IP" | lolcat
}

# List all network interfaces and prompt the user to choose one
echo -e "Available network interfaces to choose type the number of the network interface :\n" | lolcat
select INTERFACE in $(ls /sys/class/net/); do
    if [ -n "$INTERFACE" ]; then
        break
    else
        echo "Invalid selection. Please choose a network interface."
    fi
done

# Prompt user for the interval
prompt_interval

# Prompt user for the number of times he or she has to change ip
prompt_change_count

# Loop to change the IP address continuously
while true; do
    if [ "$CHANGE_COUNT" -gt 0 ]; then
        for ((i = 1; i <= CHANGE_COUNT; i++)); do
            change_ip
            sleep "$SECONDS_TO_WAIT"
        done
        break
    else
        change_ip
        sleep "$SECONDS_TO_WAIT"
    fi
done

echo "Using last IP address for $INTERFACE: $NEW_IP" | lolcat

# After the specified number of changes, use the last IP address until the script is closed
while true; do
    # Change the IP address using the last used IP
    sudo ifconfig $INTERFACE $NEW_IP
done
