id # Check current user and group information
#Result:
#uid=0(root) gid=0(root) grupos=0(root)
id -gn # Show only the name of the main group
#Result:
#root
touch ~/test_grupo_heredado.txt #Create test file in home directory
ls -la ~/test_grupo_heredado.txt #Verify test file permissions
# Create file and check which group it inherits
#Result:
#-rw-r--r-- 1 root root 0 jun  1 22:12 /root/test_grupo_heredado.txt
# The group is the main group of the current user


id -gn # Show only the name of the main group
#Result:
#root
echo "Grupo actual: $(id -gn)" # Check the active group before switching
#Result:
#echo "Grupo actual: $(id -gn)"
#Grupo actual: root


touch ~/antes_de_newgrp.txt #Create test file in home directory
ls -la ~/antes_de_newgrp.txt  #Verify test file permissions
#Result:
#-rw-r--r-- 1 root root 0 jun  1 23:36 /root/antes_de_newgrp.txt

newgrp desarrolladores
# Error:
# Solution:
# apt install util-linux-extra
# groupadd desarrolladores
# usermod -aG desarrolladores root
# newgrp desarrolladores
id -gn # Show only the name of the main group
#Result:
#desarrolladores
echo "Nuevo grupo activo: $(id -gn)" # Verify that the active group has changed
#Result:
# Nuevo grupo activo: desarrolladores


touch ~/dentro_de_newgrp.txt #Create file inside newgrp session
ls -la ~/dentro_de_newgrp.txt #Verify newgrp file permissions
# Create a file inside the newgrp subshell
#Result:
#-rw-r--r-- 1 root desarrolladores 0 jun  1 22:42 /root/dentro_de_newgrp.txt
# The file group is now desarrolladores
mkdir -p ~/proyecto_dev/src #Create project directory structure
ls -la ~/ #List home folder
#Result:
#total 64
#drwx------ 1 root root             4096 jun  1 22:44 .
#drwxr-xr-x 1 root root             4096 jun  1 21:42 ..
#-rw-r--r-- 1 root root             5857 jun  1 21:42 .bashrc
#-rw-r--r-- 1 root root              607 may 31 04:02 .bashrc.original
#drwxr-xr-x 3 root root             4096 jun  1 21:42 .cache
#drwx------ 3 root root             4096 jun  1 21:42 .config
#-rw-r--r-- 1 root desarrolladores     0 jun  1 22:42 dentro_de_newgrp.txt
#lrwxrwxrwx 1 root root               47 jun  1 21:42 .docker -> /workspaces/.codespaces/.persistedshare/.docker
#drwxr-xr-x 3 root root             4096 jun  1 21:43 .dotnet
#drwx------ 4 root root             4096 jun  1 21:43 .local
#-rw-r--r-- 1 root root              132 may 15 11:37 .profile
#drwxr-xr-x 3 root desarrolladores  4096 jun  1 22:44 proyecto_dev
#drwx------ 2 root root             4096 jun  1 21:42 .ssh
#-rw-r--r-- 1 root root                0 jun  1 22:12 test_grupo_heredado.txt
#drwxr-xr-x 5 root root             4096 jun  1 21:42 .vscode-remote
#-rw-r--r-- 1 root root            10882 may 31 04:02 .zshrc
# proyecto_dev/ has the group desarrolladores


exit # Exit the newgrp subshell
id -gn # Verify we returned to the original group
#Result:
#root
echo "Grupo restaurado: $(id -gn)" # Confirm the group has been restored
#Result:
#Grupo restaurado: root


ls -la ~/antes_de_newgrp.txt ~/dentro_de_newgrp.txt  #Compare files created before and inside newgrp
#Result:
#-rw-r--r-- 1 root root            0 jun  1 23:36 /root/antes_de_newgrp.txt
#-rw-r--r-- 1 root desarrolladores 0 jun  1 22:42 /root/dentro_de_newgrp.txt