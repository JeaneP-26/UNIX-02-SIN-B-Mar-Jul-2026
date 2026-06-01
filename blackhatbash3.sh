#!/bin/bash
book="black hat bash"
echo "This book's name is ${book}"
bash -x blackhatbash3.sh #Run the script in debug mode
#Result:
#+ book='black hat bash'
#+ echo 'This book'\''s name is black hat bash'
#This book's name is black hat bash