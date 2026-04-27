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


sudo echo "Hola">/etc/archivo_protegido
#Result:
#bash: /etc/archivo_protegido: Permission denied
#The issue is that sudo only applies to the echo command, while the redirection (>) is handled by the shell using your normal user permissions. 
#Because of this, when it tries to write to a protected file, you’ll get a permission error.

echo "Hola"|sudo tee /etc/archivo_protegido > /dev/null
#echo "Hola" → generates the text you want to save.
#| (pipe) → sends that text as input to the next command.
#sudo tee /etc/archivo_protegido → tee receives the text and writes it to the file with administrator privileges.
#/dev/null → The text is generated, but nothing appears on the screen because it is sent to /dev/null.
cat /etc/archivo_protegido
#Result:
# Hola


echo "Hola"|sudo tee /etc/archivo_protegido
#Result:
# Hola
#echo "Hola" → generates the text
#| → sends it to the next command
#sudo tee /etc/archivo_protegido → writes that text into the file with administrator privileges


sudo sh -c 'echo "chao" >> /etc/archivo_protegido'
#sudo sh -c '...' → runs the entire command inside the quotes as administrator (root)
#echo "chao" → generates the text
#>> /etc/archivo_protegido → appends the text to the end of the file (does not overwrite it)
cat /etc/archivo_protegido
#Results:
#Hola
#chao

sudo su - #switch to the root (administrator) user and start a full session logged in directly as root
#Results:
#root ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 $ exit
#logout

echo "$HOME"
#Double quotes ("") allow variable expansion.
#$HOME is replaced with its actual value.
#Result: /home/codespace
echo '$HOME'
#Single quotes ('') do NOT expand variables.
#Everything is treated as literal text.
#Result: $HOME

umask #Defect Mask
#It defines which permissions are removed when creating new files/directories
#Result: 0022

touch archivo1  # Create an empty file named "archivo1"
mkdir directorio1  # Create a directory named "directorio1"
ls -l  # List files and directories with details
#Result:
#total 60
#-rw-rw-rw-  1 codespace codespace  1788 Apr 15 13:27 Ejercicio1.sh
#-rw-rw-rw-  1 codespace codespace   595 Apr 15 13:37 Ejercicio2.sh
#-rw-rw-rw-  1 codespace root      34523 Apr 13 12:16 LICENSE
#-rw-rw-rw-  1 codespace root          0 Apr 13 12:19 README.md
#-rw-rw-rw-  1 codespace codespace     0 Apr 27 12:33 archivo1
#drwxrwxrwx+ 2 codespace codespace  4096 Apr 27 12:33 directorio1
#-rwxrwxrwx  1 codespace codespace    44 Apr 15 13:04 hola.sh
#-rwxr-xr-x  1 codespace codespace     0 Apr 15 13:34 prueba.txt
#-rwx------  1 codespace codespace  3979 Apr 27 12:33 script.sh
#-rwxrwxrwx  1 codespace codespace   112 Apr 15 13:17 test.sh

umask 027 # Set default mask: remove write for group, and all permissions for others
touch archivo2 # Create file "archivo2" (permissions affected by umask)
mkdir directorio2 # Create directory "dircetorio2" (permissions affected by umask)
ls -l # List files and directories with details
#total 68
#-rw-rw-rw-  1 codespace codespace  1788 Apr 15 13:27 Ejercicio1.sh
#-rw-rw-rw-  1 codespace codespace   595 Apr 15 13:37 Ejercicio2.sh
#-rw-rw-rw-  1 codespace root      34523 Apr 13 12:16 LICENSE
#-rw-rw-rw-  1 codespace root          0 Apr 13 12:19 README.md
#-rw-rw-rw-  1 codespace codespace     0 Apr 27 12:33 archivo1
#-rw-rw-rw-  1 codespace codespace     0 Apr 27 12:36 archivo2
#drwxrwxrwx+ 2 codespace codespace  4096 Apr 27 12:36 dircetorio2
#drwxrwxrwx+ 2 codespace codespace  4096 Apr 27 12:33 directorio1
#-rwxrwxrwx  1 codespace codespace    44 Apr 15 13:04 hola.sh
#-rwxr-xr-x  1 codespace codespace     0 Apr 15 13:34 prueba.txt
#-rwx------  1 codespace codespace  4817 Apr 27 12:36 script.sh
#-rwxrwxrwx  1 codespace codespace   112 Apr 15 13:17 test.sh

# No change in umask was applied because the user does not have the required permissions


sudo apt-get update # Update package list
sudo apt upgrade # Upgrade installed packages
sudo apt-get install acl # Install ACL support
sudo chown -R $(whoami) . # Change ownership of current directory to current user
sudo setfacl -bnR . # Remove all ACLs recursively

umask 077 # Set restrictive mask (only owner has permissions)
touch secreto.txt # Create file (only owner can read/write)
mkdir privado # Create directory (only owner has access)
ls -l # List files and directories with details
#Result
#total 72
#-rw-rw-rw- 1 codespace codespace  1788 Apr 15 13:27 Ejercicio1.sh
#-rw-rw-rw- 1 codespace codespace   595 Apr 15 13:37 Ejercicio2.sh
#-rw-rw-rw- 1 codespace root      34523 Apr 13 12:16 LICENSE
#-rw-rw-rw- 1 codespace root          0 Apr 13 12:19 README.md
#-rw-rw-rw- 1 codespace codespace     0 Apr 27 12:33 archivo1
#-rw-rw-rw- 1 codespace codespace     0 Apr 27 12:36 archivo2
#drwxrwxrwx 2 codespace codespace  4096 Apr 27 12:33 directorio1
#drwxrwxrwx 2 codespace codespace  4096 Apr 27 12:36 directorio2
#-rwxrwxrwx 1 codespace codespace    44 Apr 15 13:04 hola.sh
#drwx------ 2 codespace codespace  4096 Apr 27 13:06 privado
#-rwxr-xr-x 1 codespace codespace     0 Apr 15 13:34 prueba.txt
#-rwx------ 1 codespace codespace  5979 Apr 27 13:06 script.sh
#-rw------- 1 codespace codespace     0 Apr 27 13:06 secreto.txt
#-rwxrwxrwx 1 codespace codespace   112 Apr 15 13:17 test.sh

umask 022 # Set default mask (others can read, not write)
whoami  # Show current user
echo "Hola"> mi_archivo # Create file "mi_archivo" with content "Hola"
ls -l mi_archivo # Show details of "mi_archivo"
#Result:
#-rw-r--r-- 1 codespace codespace 5 Apr 27 13:14 mi_archivo
umask # Show the current permission mask
#Result:
#0022

sudo useradd -m -s /usr/bin/zsh luna  # Create user "luna" with home directory and zsh shell
sudo chown luna mi_archivo  # Change owner of "mi_archivo" to user "luna"

ls -l mi_archivo # Show detailed info of "mi_archivo" (permissions, owner, size, date)
#Result:
#-rw-r--r-- 1 luna codespace 5 Apr 27 13:14 mi_archivo
