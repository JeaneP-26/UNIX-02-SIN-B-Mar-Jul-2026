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