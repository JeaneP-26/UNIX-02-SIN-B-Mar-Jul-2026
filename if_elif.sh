#!/bin/bash 
# Store the first argument provided by the user into a variable
USER_INPUT="${1}" # Check if USER_INPUT is null (no argument was provided)
if [[ -z "${USER_INPUT}" ]]; then 
 # Notify the user that an argument is required and exit with error code
 echo "You must provide an argument!"
 exit 1
fi

# Check if the input is a file using the file test operator
if [[ -f "${USER_INPUT}" ]]; then
 # Print message if the argument is a file
 echo "${USER_INPUT} is a file."
 # Check if the input is a directory only if the file test failed
elif [[ -d "${USER_INPUT}" ]]; then
# Print message if the argument is a directory
 echo "${USER_INPUT} is a directory."
else
# Print message if the argument is neither a file nor a directory
echo "${USER_INPUT} is not a file or a directory."
fi


# Note: running the script without arguments triggers the -z check and exits with code 1
# The terminal may show exit code 0 on the first run due to prompt display behavior
# On the second run the exit code 1 is correctly shown confirming the early exit works
# To test the file and directory checks run: bash if_elif.sh <filename_or_directory>


#Results:
#[Jeanella-Paredes] UNIX-02-SIN-B-Mar-Jul-2026 ✗ 1 $ bash if_elif.sh 
#You must provide an argument!
#[Jeanella-Paredes] UNIX-02-SIN-B-Mar-Jul-2026 ✗ 1 $ bash if_elif.sh file.txt
#file.txt is a file.
#[Jeanella-Paredes] UNIX-02-SIN-B-Mar-Jul-2026 e[32m✓ $ bash if_elif.sh dir_test
#dir_test is a directory.