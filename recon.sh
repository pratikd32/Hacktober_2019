#!/bin/bash
clear
dom=$1
mkdir -p /root/bounty/$1
cd /root/bounty/$1
/root/go/bin/assetfinder --subs-only $1 | tee assfin.txt   
/root/go/bin/subfinder -d $1 | tee subfin.txt
sublist3r -d $1 -o $1l.txt
findomain -t $1 -o
cat assfin.txt >> tmp
cat subfin.txt >> tmp
cat $1l.txt >> tmp
cat $1.txt >> tmp
sort -u tmp | tee  al
sed 's/<BR>/\n/g' al | tee all
rm -rf *.txt
echo $1 > scope
cat scope | /root/go/bin/waybackurls | tee wbu
/root/go/bin/gau $1 -subs >> wbu
echo ""
cat all | /root/go/bin/httprobe -c 50 | tee htprobe 
cd /root/go/src/github.com/anshumanbh/tko-subs/
go run tko-subs.go -domains /root/bounty/$1/all -output /root/bounty/$1/out.csv -takeover -threads 50
mkdir -p /root/bounty/$1/screenshots
cd /root/bounty/$1/screenshots 
/root/go/bin/gowitness file -s ../htprobe -t 20
/root/go/bin/gowitness report generate
cd ..
dig @8.8.8.8 ns $1 | tee dig
host $1 | tee host
/opt/testssl.sh/testssl.sh $1 | tee ssl
echo ""
echo -e "\e[92mFollow Me On\e[0m" "\e[34mTwitter\e[0m" "\e[5m\e[93m@darklotuskdb\e[0m" "\e[92mHappy Hacking\e[0m"
echo -e "\e[1mGood Day\e[0m"
echo ""
