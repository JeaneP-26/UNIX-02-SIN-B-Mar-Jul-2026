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

