#!/bin/bash
# This function checks if the current user ID equals zero.
check_if_root(){
    # EUID (Effective User ID) is 0 when the script is run as root or with sudo
    if [[ "${EUID}" -eq "0" ]]; then
        # Return 0 (success) if the effective user ID is root
        return 0
    else
        # Return 1 (failure) if the effective user ID is a regular user
        return 1
    fi
}

# Call the function and use its return value as the if condition
if check_if_root; then
    # Print message if the user is root
    echo "User is root!"
else
    # Print message if the user is not root
    echo "User is not root!"
fi




# Create a new user called testuser
#useradd testuser
# Switch to testuser to run the script as a non-root user
#su - testuser
# Run the script as testuser (should print "User is not root!")
#bash check_root_function.sh   
#Result:          
#User is not root!
# Exit back to root
#exit