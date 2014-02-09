echo "Loading $0"

HIST_FILE=$HOME/push/history

if [ -f $HIST_FILE ]; then
  tail -n 10 $HIST_FILE
else
  echo "No push history file."
fi
