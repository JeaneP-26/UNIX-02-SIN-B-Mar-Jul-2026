#!/bin/bash
# All this script does is create a directory, create a file within the directory, and then list the contents of the directory.
set -x
mkdir mydirectory
touch mydirectory/myfile
ls -l mydirectory
set +x

#Results:
bash -n blackhatbash2.sh  # Validate the script's syntax without running it; if there is no output, it means there are no errors.
bash -x blackhatbash2.sh # Run the script in debug mode; display each command with "+" before executing it and its result
#Result
#+ mkdir mydirectory
#+ touch mydirectory/myfile
#+ ls -l mydirectory
#total 0
#-rw-rw-rw- 1 root root 0 jun  1 13:21 myfile
bash -x blackhatbash2.sh # Set -x and set +x were added to the script to enable and disable debug mode from within
#Result:
#+ set -x
#+ mkdir mydirectory
#mkdir: cannot create directory ‘mydirectory’: El fichero ya existe
#+ touch mydirectory/myfile
#+ ls -l mydirectory
#total 0
#-rw-rw-rw- 1 root root 0 jun  1 13:21 myfile
#+ set +x