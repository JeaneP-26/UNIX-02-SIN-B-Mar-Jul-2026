#!/bin/bash

#!/bin/bash -x 
# Run the script in debug mode, displaying each command before executing it
bash --version
env
echo ${SHELL}
echo ${RANDOM}
echo ${UID}
echo ${OSTYPE}
ps -e -f
ps -ef
df --human-readable
bash -r blackhatbash1.sh 
# Run the script in restricted mode, limiting dangerous commands such as cd or redirects
bash -n blackhatbash1.sh # Check the script syntax without running it