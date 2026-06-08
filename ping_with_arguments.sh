#!/bin/bash
# This script will ping any address provided as an argument.
SCRIPT_NAME="${0}"
TARGET="${1}"
echo "Running the script ${SCRIPT_NAME}..."
echo "Pinging the target: ${TARGET}..."
ping -c 3 "${TARGET}"  # Send only 3 ping packets to the target using the -c flag
#Result:
#Running the script /usr/bin/bash...
#Pinging the target: ...
#ping: : Nombre o servicio desconocido

#chmod u+x ping_with_arguments.sh # Grant execute permission to the owner of the ping_with_arguments.sh script
#./ping_with_arguments.sh nostarch.com # Execute the ping_with_arguments.sh script with nostarch.com as the argument

echo "The arguments are: $@" #Print all arguments passed to the script
echo "The total number of arguments is: $#" #Print the total number of arguments passed to the script

# Loop through all arguments and print each one on a separate line
for args in "$@"; do
 echo "${args}"
done
