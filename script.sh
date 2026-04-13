ls -a #Short option
ls --all #Large Option

ls -a /
#Command,Option,Arguments
#Command: (ls) displays the contents of a directory
#Option: (-a) includes all hidden files
#Arguments: (/) specifies the root directory of the system


ls -l # List files in long format (details like permissions, size, date)
ls -h # Show sizes in human-readable format (KB, MB, GB)


#Command,Option,Arguments
ls -l -a -h
#Command (ls): lists files and directories
#Option (-l): shows details such as permissions, owner, size, and date
#Option (-a): includes hidden files
#Option (-h): displays sizes in a human-readable format (KB, MB, etc.)
ls -l -ah #Large Option
ls -lah #Short Option


mkdir -- -rf
# Create a directory literally named "-rf".
# -- : stops option parsing, so "-rf" is treated as a name, not options.
rmdir -- -rf
# Remove the directory named "-rf".
# -- : ensures "-rf" is not interpreted as options.

ls --help #Short Option,show a short help message with options for ls
man ls #Large Option, open the manual page for the ls command
#/palabra: search for a word (e.g., /size)
#n: go to the next search result
#N: go back to the previous result
#q: quit the manual

man git-clone
/depth
#Results:
#--depth <depth>
    #Create a shallow clone with a history truncated to the specified number of commits. Implies --single-branch
    #unless --no-single-branch is given to fetch the histories near the tips of all branches. If you want to
    #clone submodules shallowly, also pass --shallow-submodules.


chmod +x script.sh # Add execute permission to all users
ls -l #Results: -rwx--x--x 1 codespace codespace  1770 Apr 13 13:12 script.sh
chmod u+x script.sh # Add execute permission to the owner (user)
ls -l #Results: -rwx--x--x 1 codespace codespace  1856 Apr 13 13:14 script.sh
chmod o-r script.sh # Remove read permission from others
ls -l #Results: -rwx--x--x 1 codespace codespace  1934 Apr 13 13:14 script.sh
chmod u+rw,go-rwx script.sh 
# Owner: read and write.
# Group & others: no permissions
ls -l #Results: -rwx------ 1 codespace codespace  2012 Apr 13 13:15 script.sh


