#!/bin/bash
ls -l # List files and directories in the current directory with detailed information
#Result:
#total 64
#-rw-rw-rw-  1 root root   601 jun  1 13:14 blackhatbash1.sh
#-rw-rw-rw-  1 root root   952 jun  1 13:28 blackhatbash2.sh
#-rw-rw-rw-  1 root root   636 jun  1 13:44 blackhatbash3.sh
#-rw-rw-rw-  1 root root     6 jun  8 12:27 blackhatbash6.sh
#-rw-rw-rw-  1 root root 34523 jun  1 12:14 LICENSE
#-rw-rw-rw-  1 root root   476 jun  1 13:51 local_scope_variable.sh
#drwxrwxrwx+ 2 root root  4096 jun  1 13:21 mydirectory
#-rw-rw-rw-  1 root root   130 jun  1 12:14 README.md
ls -l / | grep "bin" # List all files in the root directory in long format and filter lines containing "bin"
#Result:
#lrwxrwxrwx    1 root root    7 may 15 11:37 bin -> usr/bin
#lrwxrwxrwx    1 root root    8 may 15 11:37 sbin -> usr/sbin
