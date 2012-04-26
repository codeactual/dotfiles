echo "Loading $0"

function mysqltail {
  if [ -z "$1" ]; then
    echo "Line count missing."
    return
  fi

  if [ -z "$2" ]; then
    echo "Input file missing."
    return
  fi

  local initialLines=$(($1 * 2));

  tail -n $initialLines $2 | sed '/SELECT\|INSERT\|DELETE\|UPDATE\|CREATE\|SHOW\|DROP/!d' | sed 's/^[0-9]\{6\} [0-9:]*//g' | sed 's/\([ \t]*[0-9]* Query[ \t]*\)//g' | sed 's/$/;/g' | tail -n $1
}
