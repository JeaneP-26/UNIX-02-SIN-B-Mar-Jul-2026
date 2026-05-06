id # Show user identity information (UID, GID, and groups)
#Result:
#uid=0(root) gid=0(root) grupos=0(root)
cat /etc/passwd | head -10
# Show the first 10 lines of /etc/passwd.
# cat : read the file
# | : pipe output to another command
# head -10 : limit to first 10 lines

#Results:
#root:x:0:0:root:/root:/bin/bash
#daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
#bin:x:2:2:bin:/bin:/usr/sbin/nologin
#sys:x:3:3:sys:/dev:/usr/sbin/nologin
#sync:x:4:65534:sync:/bin:/bin/sync
#games:x:5:60:games:/usr/games:/usr/sbin/nologin
#man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
#lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
#mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
#news:x:9:9:news:/var/spool/news:/usr/sbin/nologin

cat /etc/group | head -10  # Show the first 10 lines of /etc/group
#Result:
#root:x:0:
#daemon:x:1:
#bin:x:2:
#sys:x:3:
#adm:x:4:
#tty:x:5:
#disk:x:6:
#lp:x:7:
#mail:x:8:
#news:x:9:

groups # Show groups of the current user
#Result: root

groups $USER  # Show groups of the current user using the $USER variable
#Result: root

id -u # Show user ID (UID)
id -g # Show primary group ID (GID)
id -G # Show all group IDs the user belongs to

cat /etc/group  # Display the contents of /etc/group (list of system groups)
#Results:
#root:x:0:
#daemon:x:1:
#bin:x:2:
#sys:x:3:
#adm:x:4:
#tty:x:5:
#disk:x:6:
#lp:x:7:
#mail:x:8:
#news:x:9:
#uucp:x:10:
#man:x:12:
#proxy:x:13:
#kmem:x:15:
#dialout:x:20:
#fax:x:21:
#voice:x:22:
#cdrom:x:24:
#floppy:x:25:
#tape:x:26:
#sudo:x:27:
#audio:x:29:
#dip:x:30:
#www-data:x:33:
#backup:x:34:
#operator:x:37:
#list:x:38:
#irc:x:39:
#src:x:40:
#shadow:x:42:
#utmp:x:43:
#video:x:44:
#sasl:x:45:
#plugdev:x:46:
#staff:x:50:
#games:x:60:
#users:x:100:
#nogroup:x:65534:
#lpadmin:x:999:
#systemd-journal:x:998:
#systemd-network:x:997:
#debian-tor:x:101:
#tcpdump:x:996:
cat /etc/group | grep games
# Show lines in /etc/group that contain "games"
# grep filters matching text
#Result: games:x:60:
cat /etc/gshadow
# Display the contents of /etc/gshadow (secure group information)
# Usually requires root privileges
#Results:
#root:*::
#daemon:*::
#bin:*::
#sys:*::
#adm:*::
#tty:*::
#disk:*::
#lp:*::
#mail:*::
#news:*::
#uucp:*::
#man:*::
#proxy:*::
#kmem:*::
#dialout:*::
#fax:*::
#voice:*::
#cdrom:*::
#floppy:*::
#tape:*::
#sudo:*::
#audio:*::
#dip:*::
#www-data:*::
#backup:*::
#operator:*::
#list:*::
#irc:*::
#src:*::
#shadow:*::
#utmp:*::
#video:*::
#sasl:*::
#plugdev:*::
#staff:*::
#games:*::
#users:*::
#nogroup:*::
#lpadmin:!*::
#systemd-journal:!*::
#systemd-network:!*::
#debian-tor:!::
#tcpdump:!*::

mkdir ~/proyecto_unix/ # Create "proyecto_unix" directory in home
ls -la ~/proyecto_unix/ # List all contents (including hidden) with details
#Result:
#total 8
#drwxr-xr-x 2 root root 4096 may  4 13:40 .
#drwx------ 1 root root 4096 may  4 13:40 ..


#Basic Sintaxis
#groupadd [options] group_name
#Create a simple group
sudo groupadd desarrolladores
sudo groupadd -g 2000 operaciones  #Specific GID
#System group (GID < 1000)
sudo groupadd --system servicios_web

#Verify that the groups were created
grep "desarrolladores\|operaciones\|servicios_web" /etc/group
#Results:
#desarrolladores:x:1000:
#operaciones:x:2000:
#servicios_web:x:995:

grep -E "desarrolladores|operaciones|servicios_web" /etc/group
#desarrolladores:x:1000:
#operaciones:x:2000:
#servicios_web:x:995:

#View main options
groupadd --help
#Result:
#Modo de uso: groupadd [opciones] GRUPO
#Opciones:
#  -f, --force                   termina si el grupo ya existe, y cancela -g
 #                               si el GID ya se está en uso
 # -g, --gid GID                 utiliza GID para el nuevo grupo
 # -h, --help                    muestra este mensaje de ayuda y termina
 # -K, --key CLAVE=VALOR         sobrescribe los valores predeterminados de
 #                               «/etc/login.defs»
 # -o, --non-unique              permite crear grupos con GID (no únicos)
 #                               duplicados
 # -p, --password CONTRASEÑA     utiliza esta contraseña cifrada para el nuevo
 #                               grupo
 # -r, --system                  crea una cuenta del sistema
 # -R, --root DIR_CHROOT         establece DIR_CHROOT como el directorio
 #                               al cual hacer chroot
 # -P, --prefix PREFIX_DIR       directory prefix
 # -U, --users USERS             comma-separated list of users to add as
#                               members of this group


#View the GID range in the system
grep "GID_MIN\|GID_MAX\|SYS_GID" /etc/login.defs
#Results:
#GID_MIN                  1000
#GID_MAX                 60000
#SYS_GID_MIN              101
#SYS_GID_MAX              999
#SUB_GID_MIN                100000
#SUB_GID_MAX             600100000

#System groups have a GID lower than the minimum user GID
#In Ubuntu, typically
#SYS_GID_MIN = 100
#SYS_GID_MAX = 999
#GID_MIN = 100
#GID_MAX = 60000

#addgroup [options] group_name
#Create groups using addgroup
sudo addgroup diseno
sudo addgroup --gid 2100 marketing
sudo addgroup --system cache_web
#Verify
grep -E "diseno|marketing|cache_web" /etc/group
#Result:
#diseno:x:1001:
#marketing:x:2100:
#cache_web:x:102:

#View which groups the current user belongs to
groups
#Result: root
id
#Result: uid=0(root) gid=0(root) grupos=0(root)

#Add a user to a group using low-level usermod
usermod -aG desarrolladores $USER
usermod -aG diseno $USER
#In this section, an error occurs because $USER is empty
#So it is corrected by explicitly using the username (root) to add users to the group
usermod -aG desarrolladores root
usermod -aG diseno root
#Result:
groups root
#root : root desarrolladores diseno

#Verify the changes in /etc/group
grep -E "desarrolladores|diseno" /etc/group
#Result:
#desarrolladores:x:1000:root
#diseno:x:1001:root

#Add user to a group using high-level adduser (Debian)
adduser root marketing
#Check current status
id root
#Result:
#uid=0(root) gid=0(root) grupos=0(root),1000(desarrolladores),1001(diseno),2100(marketing
grep root /etc/group
#Result:
#root:x:0:
#desarrolladores:x:1000:root
#diseno:x:1001:root
#marketing:x:2100:root

#Create a temporary group for the demo
groupadd grupo_temporal
usermod -aG grupo_temporal root
id root #Named grupo_temporal
#Result
#uid=0(root) gid=0(root) grupos=0(root),1000(desarrolladores),1001(diseno),2100(marketing),2101(grupo_temporal)

#Now the ERROR: using usermod without -a
usermod -G desarrolladores root
#This REMOVES all secondary groups except "desarrolladores"
id root  #All other groups were lost
#Result:
#uid=0(root) gid=0(root) grupos=0(root),1000(desarrolladores)