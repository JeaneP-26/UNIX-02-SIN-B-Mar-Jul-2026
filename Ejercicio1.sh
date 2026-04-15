echo '#!bin/sh' > hola.sh
#echo '#!bin/sh' → writes literally #!bin/sh
#> → creates the file hola.sh or overwrites its content
#Result:
#cat hola.sh
# #!bin/sh

echo 'echo "Hola desde mi primer script"' >> hola.sh
#echo 'echo "Hola desde mi primer script"' → writes that line of code exactly as it is
#>> hola.sh → appends that line to the end of the hola.sh file
cat hola.sh
#Result:
# !bin/sh
# echo "Hola desde mi primer script"

./hola.sh 
#It executes the hola.sh script located in the current directory.
#Result:
#bash: ./hola.sh: Permission denied

ls -l hola.sh # Shows file permissions and details
#Result: -rw-rw-rw- 1 codespace codespace 44 Apr 15 13:04 hola.sh
chmod +x hola.sh # Adds execute permission
ls -l hola.sh
#Result: -rwxrwxrwx 1 codespace codespace 44 Apr 15 13:04 hola.sh
./hola.sh # Runs the script


ls /etc # Lists all files and directories inside /etc
touch /etc/prueba.txt
# Tries to create a file inside /etc
# Fails with "Permission denied" because /etc is a protected directory
# Regular users cannot write here
#Result: touch: cannot touch '/etc/prueba.txt': Permission denied
mkdir ~/mi_carpeta # Creates a folder in the home directory (~)
apt install cowsay
# Installs the cowsay package
# Requires sudo because it modifies system files
#Result:
#E: Could not open lock file /var/lib/dpkg/lock-frontend - open (13: Permission denied)
#E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), are you root?

sudo touch /etc/prueba.txt
# Uses admin privileges (root)
# Allows creating the file in a protected directory
sudo apt install cowsay
# Installs cowsay with admin privileges
#Result:
#Reading package lists... Done
#Building dependency tree... Done
#Reading state information... Done
#E: Unable to locate package cowsay

