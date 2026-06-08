#!/bin/bash
# Sets an array
set -x
IP_ADDRESSES=(192.168.1.1 192.168.1.2 192.168.1.3)
# Prints all elements in the array
echo "${IP_ADDRESSES[*]}"
# Prints only the first element in the array
echo "${IP_ADDRESSES[0]}"
unset IP_ADDRESSES[1]  # Remove the second element (index 1) from the IP_ADDRESSES array
echo "${IP_ADDRESSES[*]}" # Print all remaining elements in the array
IP_ADDRESSES[0]="192.168.1.10" # Update the first element (index 0) of the IP_ADDRESSES array with a new IP
echo "${IP_ADDRESSES[*]}" # Print all elements in the array after the update
set +x