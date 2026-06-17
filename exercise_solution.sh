#!/bin/bash
# This line tells the system to run this file using bash

#ARGUMENT VALIDATION
# $# is a special variable that holds the number of arguments the user passed
# -ne means "not equal", so this checks: did the user NOT give exactly 2 arguments?
if [ $# -ne 2 ]; then
    # If arguments are missing, show an error message to the user
    echo "Error: you must provide two arguments: <name> <domain>"
    # Show an example of how to use the script correctly
    echo "Example: ./exercise2.sh mysite nostarch.com"
    # exit 1 means: stop the script and report that something went wrong
    # (exit 0 = success, exit 1 = error — this is the "right exit code" the exercise asks for)
    exit 1
# Close the if block
fi




#SAVE ARGUMENTS INTO VARIABLES
# $1 is the first argument the user typed (the name, for example: mysite)
NAME=$1
# $2 is the second argument the user typed (the domain, for example: nostarch.com)
DOMAIN=$2



#PING THE DOMAIN
# ping sends a network packet to the domain to check if it responds
# -c 1 means: send only 1 packet (instead of pinging forever)
# > /dev/null sends the normal output to trash (we don't want to print it)
# 2>&1 also sends error messages to trash
ping -c 1 "$DOMAIN" > /dev/null 2>&1




#CHECK IF PING WORKED
# $? holds the exit code of the LAST command that ran (in this case, ping)
# If ping worked, $? will be 0 (success)
# If ping failed, $? will be something other than 0 (error)
if [ $? -eq 0 ]; then
    # Ping was successful, so we save the word "success" in the RESULT variable
    RESULT="success"
# else means: if the condition above was NOT true
else
    # Ping failed, so we save the word "failure" in the RESULT variable
    RESULT="failure"
# Close the if/else block
fi



#GET CURRENT DATE AND TIME
# date is a command that returns the current date and time
# "+%Y-%m-%d %H:%M:%S" is the format: Year-Month-Day Hour:Minute:Second
# $(...) runs the command and saves the result into the DATETIME variable
DATETIME=$(date "+%Y-%m-%d %H:%M:%S")



# WRITE RESULTS TO CSV FILE
# echo prints text to the screen (or in this case, to a file)
# The CSV line has 4 columns separated by commas: name, domain, result, date
# >> means: APPEND to the file (add a new line without deleting old ones)
# results.csv is the file where all results will be saved
echo "$NAME,$DOMAIN,$RESULT,$DATETIME" >> results.csv



# SHOW RESULT ON SCREEN 
# Tell the user what happened with the ping
echo "Done! Result for $DOMAIN: $RESULT"
# Remind the user where the result was saved
echo "Saved to results.csv"