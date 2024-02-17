#!/bin/bash

# Function to check if lolcat is installed
check_lolcat() {
    if command -v lolcat &> /dev/null; then
        tput clear
        echo -e "Opening the installation menu\n\n" | lolcat
    else
        sudo apt-get install lolcat
    fi
}
check_lolcat

# Function to handle Ctrl+C signal
goodbye() {
    echo -e "\n\nGoodbye! Thanks for using AnonTor installation script." | lolcat
    exit 0
}

# Trap Ctrl+C signal to call the goodbye function
trap goodbye SIGINT

echo -n "To install, press (Y). To uninstall, press (N): " | lolcat
read -r choice

run() {
    # Function to run commands
    eval "$1"
}

if [ "$choice" == "Y" ] || [ "$choice" == "y" ]; then
    run "chmod +x cip.sh"
    run "mkdir -p /usr/share/ant"
    run "cp cip.sh /usr/share/ant/cip.sh"

    cmnd='#!/bin/sh\nexec bash /usr/share/ant/cip.sh "$@"'
    echo -e "$cmnd" > "/usr/bin/ant"
    run "chmod +x /usr/bin/ant && chmod +x /usr/share/ant/cip.sh"
    echo -e "\n\nCongratulations! AnonTor IP Changer is installed successfully.\nFrom now on, just type 'ant' in the terminal." | lolcat
    goodbye
elif [ "$choice" == "N" ] || [ "$choice" == "n" ]; then
    run "rm -r /usr/share/ant"
    run "rm /usr/bin/ant"
    echo -e "\n\nAnonTor IP Changer has been removed successfully." | lolcat
    goodbye
else
    echo "Invalid choice. Exiting." | lolcat
    goodbye
fi