echo "Loading $0"

# Unpack tarballs here with x.y.z directory names.
export SANDBOX_BINARY"=/opt/mysql/msb_binaries"

# MySQL Sandbox CLI will install new servers here.
export SANDBOX_HOME="/opt/mysql/msb_sandboxes"

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
