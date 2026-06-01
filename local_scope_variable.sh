#!/bin/bash
PUBLISHER="No Starch Press"
print_name(){
 local name
 name="Black Hat Bash"
 echo "${name} by ${PUBLISHER}"
}
print_name
echo "Variable ${name} will not be printed because it is a local variable."

# PUBLISHER is a global variable, accessible from anywhere in the script
# 'name' is a local variable; it only exists inside print_name()
# The function is called with print_name, without parentheses
# Outside the function, $name is empty because its scope is local