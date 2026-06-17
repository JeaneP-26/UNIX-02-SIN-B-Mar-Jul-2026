#!/bin/bash

awk '{print $1}' log.txt

awk '{print $2}' log.txt

awk '{print $3}' log.txt

# awk '{print $1,$2,$3}' log.txt

awk '{print $1,$NF}' log.txt

awk '{print $NF}' log.txt

awk -F',' '{print $1}' example_csv.txt

awk 'NR < 10' log.txt
#Shows 10 lines
#Result:
#
#13.66.139.0 - - [19/Dec/2020:13:57:26 +0100] "GET /index.php?option=com_phocagallery&view=category&id=1:almhuette-raith&Itemid=53 HTTP/1.1" 200 32653 "-" "Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)" "-"
#157.48.153.185 - - [19/Dec/2020:14:08:06 +0100] "GET /apache-log/access.log HTTP/1.1" 200 233 "-" "Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36" "-"
#157.48.153.185 - - [19/Dec/2020:14:08:08 +0100] "GET /favicon.ico HTTP/1.1" 404 217 "http://www.almhuette-raith.at/apache-log/access.log" "Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36" "-"
#216.244.66.230 - - [19/Dec/2020:14:14:26 +0100] "GET /robots.txt HTTP/1.1" 200 304 "-" "Mozilla/5.0 (compatible; DotBot/1.1; http://www.opensiteexplorer.org/dotbot, help@moz.com)" "-"
#54.36.148.92 - - [19/Dec/2020:14:16:44 +0100] "GET /index.php?option=com_phocagallery&view=category&id=2%3Awinterfotos&Itemid=53 HTTP/1.1" 200 30662 "-" "Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)" "-"
#92.101.35.224 - - [19/Dec/2020:14:29:21 +0100] "GET /administrator/index.php HTTP/1.1" 200 4263 "" "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)" "-"
#73.166.162.225 - - [19/Dec/2020:14:58:59 +0100] "GET /apache-log/access.log HTTP/1.1" 200 1299 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.101 Safari/537.36" "-"
#73.166.162.225 - - [19/Dec/2020:14:58:59 +0100] "GET /favicon.ico HTTP/1.1" 404 217 "http://www.almhuette-raith.at/apache-log/access.log" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.101 Safari/537.36" "-"

grep "42.236.10.117" log.txt | awk '{print $7}'
# Search for lines containing the IP 42.236.10.117 in log.txt and print only the 7th field

# Replace all occurrences of Mozilla with Godzilla in log.txt and print to terminal
sed 's/Mozilla/Godzilla/g' log.txt
# Replace all occurrences of Mozilla with Godzilla and save the result in a new file
sed 's/Mozilla/Godzilla/g' log.txt > newlog.txt
# Replace all occurrences of Mozilla with Godzilla directly in log.txt using -i flag
sed -i 's/Mozilla/Godzilla/g' log.txt
# Search for lines containing Godzilla in log.txt to verify the replacement worked
grep "Godzilla" log.txt


sed 's/ //g' log.txt > newlog1.txt