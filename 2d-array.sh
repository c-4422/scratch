#!/bin/bash

RED="\\033[0;31m"
GREEN="\\033[0;32m"
ENDCOLOR="\\x1b[0m"

echo "hello world"
    numEnabledSecurityParams=0

    sysParams="test.txt"

    sysctlSecurity=(
"net.ipv4.conf.default.rp_filter" "1"
"net.ipv4.conf.all.rp_filter" "1"
"net.ipv4.conf.all.accept_redirects" "0"
"net.ipv6.conf.all.accept_redirects" "0"
"net.ipv4.conf.all.send_redirects" "0"
"net.ipv4.conf.all.accept_source_route" "0"
"net.ipv6.conf.all.accept_source_route" "0"
"net.ipv4.conf.all.log_martians" "1"
"net.ipv4.conf.all.arp_notify" "1")

    basicKernelParam="################################################
# Server Kernel Parameter File
# 
# by C-4422
#
# Basic kernel parameters for rootless podman
# and security if enabled. Parameters used for
# security, specifically preventing man in the 
# middle attacks, can potentially mess with 
# networking tasks e.g. if you plan on using 
# your server for network routing. Hopefully 
# you won't need to edit this file yourself.
#
# auto-generated from server-setup.sh
################################################

# Unprivileged port start at 80 is necessary for 
# rootless podman this parameter shouldn't be changed
net.ipv4.ip_unprivileged_port_start=80

# The following parameters are meant for added security
# and can be commented out if needed

# Uncomment the next two lines to enable Spoof protection (reverse-path filter)
# Turn on Source Address Verification in all interfaces to
# prevent some spoofing attacks
#net.ipv4.conf.default.rp_filter=1
#net.ipv4.conf.all.rp_filter=1

# Do not accept ICMP redirects (prevent MITM attacks)
#net.ipv4.conf.all.accept_redirects=0
#net.ipv6.conf.all.accept_redirects=0

# Do not send ICMP redirects (we are not a router)
#net.ipv4.conf.all.send_redirects=0

# Do not accept IP source route packets (we are not a router)
#net.ipv4.conf.all.accept_source_route=0
#net.ipv6.conf.all.accept_source_route=0

# Log Martian Packets
#net.ipv4.conf.all.log_martians=1

# Send gratitous ARP when device change
#net.ipv4.conf.all.arp_notify=1"

    if [ -f $sysParams ]; then
        echo "$sysParams file exists."
    else
        echo "Create $sysParams"
        echo "Set unprivileged port start to 80"
        sudo /bin/su -c "echo '$basicKernelParam' >> $sysParams"
    fi
    
    for (( i=0; i<${#sysctlSecurity[@]}; i=i+2 ))
    do
        if grep -q "^${sysctlSecurity[$i]}=${sysctlSecurity[$i+1]}" $sysParams; then
            numEnabledSecurityParams=$(($numEnabledSecurityParams+1))
        fi
    done

    securityStatus="disabled"
    # Check to see if number of enabled security parameters equals the
    # total number of stored security parameters
    totalSecurityParams=$((${#sysctlSecurity[@]}/2))

    if [[ $numEnabledSecurityParams -eq $totalSecurityParams ]]; then
        securityStatus="enabled"
    elif [[ $numEnabledSecurityParams -gt 0 ]]; then
        securityStatus="partially enabled"
    fi

    printf "\n"
    echo "Currently additional security measures are $securityStatus."
    echo "Additional security is used for mitigating / preventing"
    echo "man in the middle network attacks. These security measures"
    echo "are not strictly required."
    printf "${RED}NOTE: If you plan on running Pi-hole or a DNS server do\n${ENDCOLOR}"
    printf "${RED}      not enable additional security parameters, it will\n${ENDCOLOR}"
    printf "${RED}      cause said applications to not work.\n${ENDCOLOR}"
    printf "Select to enable disable or leave as is (Current status: ${RED}$securityStatus${ENDCOLOR})\n"
    read -r -p " [Enable=e, Disable=d, default (leave as is)=l]:" selection

    case "$selection" in
    "e")
        for (( i=0; i<${#sysctlSecurity[@]}; i=i+2 ))
        do
            if grep -q ${sysctlSecurity[$i]} $sysParams; then
                # Look for security parameters and enable them
                sudo /bin/su -c "sed -i '/${sysctlSecurity[$i]}/c\\${sysctlSecurity[$i]}=${sysctlSecurity[$i+1]}' $sysParams"
            else
                sudo /bin/su -c "echo '${sysctlSecurity[$i]}=${sysctlSecurity[$i+1]}' >> $sysParams"
            fi
        done
        ;;
    "d")
        for (( i=0; i<${#sysctlSecurity[@]}; i=i+2 ))
        do
            sudo /bin/su -c "sed -i '/${sysctlSecurity[$i]}/c\\#${sysctlSecurity[$i]}=${sysctlSecurity[$i+1]}' $sysParams"
        done
        ;;
    *)
        ;;
    esac

    printf "${GREEN}Completed Step 1\n\n${ENDCOLOR}"
