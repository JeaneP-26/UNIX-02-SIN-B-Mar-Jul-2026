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
