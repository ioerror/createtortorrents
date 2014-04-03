#!/bin/bash

## generate torrents for all files in /var/www/mirrors/torproject.org/dist 
## destination: /var/www/mirrors/torrents/

SOURCE=/var/www/mirrors/torproject.org/dist
DEST=/var/www/mirrors/torrents/

## requires mktorrent

MIRRORS='
http://www.torservers.net/mirrors/torproject.org/dist/,
http://www.torproject.org/dist/,
http://www.oignon.net/dist/,
http://tor.amorphis.eu/dist/,
http://tor.ccc.de/dist/,
http://tor.idnr.ws/dist/,
http://cyberside.net.ee/tor/,
http://mirrors.chaos-darmstadt.de/tor-mirror/dist/,
http://www.torproject.us/dist/,
http://tor.beme-it.de/dist/,
http://torproj.xpdm.us/dist/,
http://tor.askapache.com/dist/,
http://torproject.nwlinux.us/dist/,
http://tor.homosu.net/dist/,
http://www.torproject.org.nyud.net/dist/,
http://tor.kamagurka.org/dist/,
http://theonionrouter.com/dist/,
'
# last comma required!

TRACKERS=udp://tracker.openbittorrent.com:80/announce,udp://tracker.publicbt.com:80/announce,http://tracker.openbittorrent.com:80/announce,http://tracker.publicbt.com:80/announce,udp://tracker.ccc.de/announce

MIRRORS=`echo $MIRRORS | tr -d '\n' | tr -d '[:space:]'`
cd $SOURCE
for file in `find . -type f`
do
 path=${file%/*}
 path=${path#.}
 name=${file##*/}
 FILEMIRRORS=${MIRRORS//\/,/$path\/$name,}  #replace /, by $path/$name,

 echo Processing $path/$name
 mkdir -p $DEST/$path
 /usr/bin/mktorrent -a $TRACKERS -w $FILEMIRRORS $file -o $DEST/$file.torrent -c "created by www.torservers.net" 
done
