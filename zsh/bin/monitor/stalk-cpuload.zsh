#!/bin/sh

# Based on http://www.linuxquestions.org/questions/linux-server-73/run-a-script-if-the-server-load-is-above-a-certain-value-853872/#post4211665

if [ -z $1 -o -z $2 ]; then
  echo "usage: stalk-cpuload.zsh <min load average, ex. 0.6> <log file>"
  exit
fi

EXECUTE_ON_AVERAGE="$1" # for last 60 secs
LOG_FILE="$2"
TOP_LIST_SIZE=25

while true; do
  LOAD=$(uptime | cut -d " " -f 13 | cut -d "," -f 1)
  if [ $(echo "$LOAD >= $EXECUTE_ON_AVERAGE" | bc) = 1 ]; then
    echo "\n-------------------------------" >> $LOG_FILE
    date --rfc-2822 >> $LOG_FILE
    echo "load: $LOAD" >> $LOG_FILE
    echo "-------------------------------\n" >> $LOG_FILE
    top -b -n 1 -c | head -n $(($TOP_LIST_SIZE + 7)) >> $LOG_FILE
  fi
  sleep 60
done
