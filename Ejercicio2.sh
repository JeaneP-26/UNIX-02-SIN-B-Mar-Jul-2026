touch prueba.txt # Creates an empty file named prueba.txt
chmod 600 prueba.txt 
# Sets permissions to 600
# Owner: read and write (rw-)
# Group: no permissions (---)
# Others: no permissions (---)
ls -l prueba.txt # Displays file permissions and details
#Result: -rw------- 1 codespace codespace 0 Apr 15 13:34 prueba.txt
chmod 755 prueba.txt
# Sets permissions to 755
# Owner: read, write, execute (rwx)
# Group: read and execute (r-x)
# Others: read and execute (r-x)
ls -l prueba.txt # Displays file permissions and details
#Result: -rwxr-xr-x 1 codespace codespace 0 Apr 15 13:34 prueba.txt
