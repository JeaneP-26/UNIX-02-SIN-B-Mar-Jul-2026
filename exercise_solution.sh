#!/bin/bash
# my script for exercise 2 - ping a domain and save results to a CSV

# if the user didn't give exactly 2 arguments, show an error and stop
if [ $# -ne 2 ]; then
    # tell the user what went wrong
    echo "Error: you must provide two arguments: <name> <domain>"
    # show an example so they know how to use it
    echo "Example: ./exercise_solution.sh mysite nostarch.com"
    # exit 1 = the script stopped because of an error
    exit 1
fi

# $1 is the first argument the user typed (the name)
NAME=$1
# $2 is the second argument the user typed (the domain)
DOMAIN=$2

# curl tries to connect to the domain like a browser would
# -s hides the progress bar
# --max-time 5 waits max 5 seconds before giving up
# -o /dev/null throws away the page content, we don't need it
curl -s --max-time 5 -o /dev/null "http://$DOMAIN"

# $? is the exit code of curl (0 = connected, anything else = failed)
if [ $? -eq 0 ]; then
    # curl connected successfully
    RESULT="success"
else
    # curl couldn't reach the domain
    RESULT="failure"
fi

# get the current date and time and save it in a variable
DATETIME=$(date "+%Y-%m-%d %H:%M:%S")

# write one line to the CSV with all 4 fields separated by commas
# >> means add to the file without deleting what's already there
echo "$NAME,$DOMAIN,$RESULT,$DATETIME" >> results.csv

# show the result on screen so the user knows what happened
echo "Done! Result for $DOMAIN: $RESULT"
echo "Saved to results.csv"