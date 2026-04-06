cd #Changes the current directory to your home directory
cd /home/codespace #hanges the current directory to the specific path /home/codespace.
cd ~ #The ~ symbol represents the home directory of the current user
cd $HOME #$HOME is an environment variable that stores the path to your home directory.


mkdir proyecto #Create the directory "Proyecto"
cd proyecto/ #Change to directory "Proyecto"
ls -lai #Lists all files and directories in the current directory with detailed information
#Result of the list:
#total 12
#925546 drwxr-xr-x 2 codespace codespace 4096 Apr  6 12:34 .
#918515 drwxr-x--- 1 codespace codespace 4096 Apr  6 12:34 ..


stat . #Displays detailed information about the current directory (".")
#Shows metadata such as size, permissions, inode number, timestamps (access, modify, change), and more.
#Size: 4096
# The size of the directory in bytes.
# For directories, this usually represents the space used to store its entries.
#Blocks: 8
# Number of disk blocks allocated to this directory.
#Device: 0,45
# Identifies the storage device where this directory is located.


mkdir -p /tmp/prueba/sub1 /tmp/prueba/sub2 # Creates directories in the specified paths
# -p : Creates parent directories if they don’t exist
stat /tmp/prueba # Displays detailed information about the directory /tmp/prueba
# Shows metadata like size, permissions, inode, timestamps, etc.
man mkdir -p /tmp/prueba/sub1 /tmp/prueba/sub2 # Opens the manual (help page) for the mkdir command


pwd #Where am I
whoami #Who am I
ls #List
ls -l #Lists files and directories in the current directory using long format
ls -la #Combine the commands: ls -l / ls -a, Shows the type of file and the permissions
ls -lh  #Combine the commands: ls -l / ls -h, Lists files and directories in long format with human-readable sizes
ls -lt #When each file was modified, Lists files and directories in long format, sorted by modification time
ls / #What are in the system root
ls /etc | head -20 #Explore the system directories
ls /dev | head -20 #Explore the system directories