echo "Loading $0"

#############################
##### commandlinefu.com #####
#############################

# Compare a remote dir with a local dir
# diff -y <(ssh user@host find /boot|sort) <(find /boot|sort)

# diff 2 remote files
# diff <(ssh user@host1 cat /path/to/file) <(ssh user@host2 cat /path/to/file2)

# Back Up a disk to an image in your home directory
# dd if=/dev/sda of=~/backup-disk-YY-MM-DD.img

# Restore disk from image
# dd if=~/backup-disk-YY-MM-DD.img of=/dev/sda

# send file to remote machine and unzip using ssh
# ssh user@host 'gunzip - > file' < file.gz

# Remove lines with matched string
# for i in $(find . -iname '*.html'); do sed '/String/d' $i > $i-tmp; mv $i-tmp $i; done

# Empty a file
# > file

# Remove all but one specific file
# rm -f !(survivior.txt)

# CPU architecture details
# lscpu

# Execute a command with a timeout
# timeout 5s COMMAND

# Rename files with vim (requires renameutils package)
# qmv -fdo

# Search for classes in Java JAR files
# find . -name "*.jar" | while read line; do unzip -l $line; done | grep your-string

# List the size of all sub folders and files from the current location, with sorting
# du -h --max-depth=1

# intercept stdout/stderr of another process or disowned process
# strace -ff -e trace=write -e write=1,2 -p SOME_PID

# diff files while disregarding indentation and trailing white space
# diff -b $file1 $file2

# Stop Mac OSX from creating .DS_Store files when interacting with a remote file server with the Finder
# defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Monitoring file handles used by a particular process
# lsof -c <process name> -r

# Generate list of words and their frequencies in a text file
# tr A-Z a-z | tr -cs a-z '\n' | sort | uniq -c

# Create a file of a given size in linux
# truncate -s 1M file

# Copy a file using pv and watch its progress
# pv sourcefile > destfile

# direct a single stream of input (ls) to multiple readers (grep & wc) without using temporary files
# ls |tee >(grep xxx |wc >xxx.count) >(grep yyy |wc >yyy.count) |grep zzz |wc >zzz.count

# Kill all Zombie processes
# kill -9 `ps -xaw -o state -o ppid | grep Z | grep -v PID | awk '{print $2}'`

# Make a file not writable / immutable by root
# sudo chattr +i <file>

# remove all dead symbolic links in a directory
# find -L /path/to/check -type l -delete

# Detach a process from the current shell
# ping -i1 www.google.com &> /dev/null & disown
# nohup ping -i1 www.google.com &

# Find the 10 biggest files taking up disk space
# find / -type f -size +100M -exec du {} \; | sort -n | tail -10 | cut -f 2
# find / -type f 2>/dev/null | xargs du 2>/dev/null | sort -n | tail -n 10 | cut -f 2 | xargs -n 1 du -h

# Copy a file over SSH without SCP
# ssh HOST cat < LOCALFILE ">" REMOTEFILE

# Remove multiple spaces
# sed "s/^ *//;s/ *$//;s/ \{1,\}/ /g" filename.txt

# Watch memcache traffic
# sudo tcpdump -i eth0 -s 65535 -A -ttt port 11211

# Remove files with dots safely
# rm -r .[!.]*

# strace all your apache processes
# ps auxw | grep sbin/apache | awk '{print"-p " $2}' | xargs strace

# Print all the lines between 10 and 20 of a file
# sed -n '10,20p' <filename>

# Print just line 4 from a textfile
# sed -n '4{p;q}'

# See where MySQL is looking for its config files
# mysql \-\? | grep ".cnf"

# uncomment the lines where the word DEBUG is found
# sed '/^#.*DEBUG.*/ s/^#//' $FILE

# change to the previous working directory
# cd -

# Automatically connect to a host with ssh once it is online
# var=host ;while ! nc -zw 1 $var 22;do sleep 1; done ; ssh user@$var

# show the working directories of running processes
# lsof -bw -d cwd -a -c java

# Find all the symlinks and hard links to a file
# find -L / -samefile /path/to/file -exec ls -ld {} +

# find files in a date range
# find . -type f -newermt "2010-01-01" ! -newermt "2010-06-01"

# Save the list of all available commands in your box to a file
# compgen -c | sort -u > commands

# Show 'Hardware path'-style tree of all devices in Linux
# lshw -short

# whowatch: Linux and UNIX interactive, process and users monitoring tool (package whowatch)

# Renames all files in the current directory such that the new file contains no space characters
# rename 'y/ /_/' *

# all IPs connected to this host grouped by ip address
# netstat -ntu | awk ' $5 ~ /^[0-9]/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort -n

# all IPs connected to this host not grouped
# netstat -lantp | grep ESTABLISHED |awk '{print $5}' | awk -F: '{print $1}' | sort -u

# Find common lines between two files
# comm -1 -2 <(sort file1) <(sort file2)

# Save lines unique to file2
# grep -Fvf file1 file2 > file-new

# View files opened by a program on startup and shutdown
# sudo lsof -rc command >> /tmp/command.txt

# List only directories, one per line
# find . -maxdepth 1 -type d | sort

# Add all unversioned files to svn
# svn status |grep '\?' |awk '{print $2}'| xargs svn add

# How To Get the Apache Document Root
# httpd -V | grep -i SERVER_CONFIG_FILE | cut -f2 -d'"' | xargs grep -i '^DocumentRoot' | cut -f2 -d'"'

# Test disk I/O
# dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync

# List files accessed by a command
# strace -ff -e trace=file my_command 2>&1 | perl -ne 's/^[^"]+"(([^\\"]|\\[\\"nt])*)".*/$1/ && print'

# Check if your webserver supports gzip compression with curl
# curl -I -H "Accept-Encoding: gzip,deflate" http://example.org

# Check variable has been set
# [ -z "$VAR" ] && echo "VAR has not been set" && exit 1

# Monitor connection statistics with netstat and watch
# watch -n 1 "netstat -ntu | sed '1,2d' | awk '{ print \$6 }' | sort | uniq -c | sort -k 2"

# Tunnel a MySQL server listening on a UNIX socket to the local machine
# socat TCP-LISTEN:5500 EXEC:'ssh user@remotehost "socat STDIO UNIX-CONNECT:/var/run/mysqld/mysqld.sock"'

# Convert text to uppercase
# upper() { echo ${@^^}; }

# Watch several log files of different machines in a single multitail window on your own machine
# multitail -l 'ssh machine1 "tail -f /var/log/apache2/error.log"' -l 'ssh machine2 "tail -f /var/log/apache2/error.log"'

# reverse order of file
# sed '1!G;h;$!d'

# Skip filenames with control characters, a.k.a tab,newline etc
# find . ! -name "$(printf '*[\001-\037\177]*')"

# Adding a startup script to be run at bootup Ubuntu
# sudo update-rc.d <scriptname> defaults

# Extract tar content without leading parent directory
# tar -xaf archive.tar.gz --strip-components=1

# diff current vi buffer edits against original file
# :w !diff -u % -

# sort ip by count quickly with awk from apache logs
# awk '{array[$1]++}END{ for (ip in array) print array[ip] " " ip}' <path/to/apache/*.log> | sort -n

# Print diagram of user/groups (package imagemagick for `display`)
# awk 'BEGIN{FS=":"; print "digraph{"}{split($4, a, ","); for (i in a) printf "\"%s\" [shape=box]\n\"%s\" -> \"%s\"\n", $1, a[i], $1}END{print "}"}' /etc/group|display

# Create a local compressed tarball from remote host directory
# ssh user@host "tar -zcf - /path/to/dir" > dir.tar.gz

# Create tarball of files modified in git
# tar czf git_mods_circa_dec23.tgz --files-from <(git ls-files -m)

# Daemonize nc - Transmit a file like a http server
# while ( nc -l 80 < /file.htm > : ) ; do : ; done &

# Transfer a file to multiple hosts over ssh (package pssh for `pscp`)
# pscp -h hosts.txt -l username /etc/hosts /tmp/hosts

# Intercept, monitor and manipulate a TCP connection
# mkfifo /tmp/fifo; cat /tmp/fifo | nc -l -p 1234 | tee -a to.log | nc machine port | tee -a from.log > /tmp/fifo

# Show all listening and established ports TCP and UDP together with the PID of the associated process
# netstat -plantu

# Serve the current directory at http://localhost:8000/
# python -m SimpleHTTPServer

# Save a file you edited in vim without the needed permissions
# :w !sudo tee %

# Run the previous shell command but replace string "foo" with "bar"
# ^foo^bar^ # first instance only
# !!:gs/foo/bar # all instances

# Quickly backup or copy a file
# cp filename{,.bak}

# traceroute and ping combined
# mtr google.com

# Copy your public-key to remote-machine for public-key authentication
# ssh-copy-id remote-machine

# Display currently mounted file systems nicely
# mount | column -t

# Top for files
# watch -d -n 1 'df; ls -FlAt /path'

# Mount a remote folder through SSH (package sshfs)
# sshfs name@server:/path/to/folder /path/to/mount/point

# Download a website recursively with wget
# wget --random-wait -r -p -e robots=off -U Mozilla www.example.com

# Execute a command independently from the current shell (subshells)
# (cd /tmp && ls)

# Tunnel your SSH connection via intermediate host
# ssh -t reachable_host ssh unreachable_host
# ssh -t host1 ssh -t host2 ssh -t host3 ssh -t host4 ...

# Show permissions of current directory and all directories upwards to /
# namei -m $(pwd)

# tree by modify time with newest file at bottom
# tree -L 1 -ChDit | tac

# Create a tar archive with all files of a certain type found in present dir and subdirs
# find ./ -type f -name "*.txt" -exec tar uvf myarchives.tar {} +

# Sort files in multiple directories by date
# find . -type f -exec ls -l --full-time {} + | sort -k 6,7

# Limit the transfer rate of a pipe with pv
# pv /dev/urandom -L 3m -i 0.3 > /dev/null

##############################
##### References / Lists #####
##############################

# http://presentations.codeinthehole.com/confoo2011/
# http://www.catonmat.net/blog/top-ten-one-liners-from-commandlinefu-explained/
