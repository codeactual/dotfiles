# Based on existing script but I can't find the original source.
echo "Loading $0"

function export_agent_meta {
  local pid=$1
  local sock=$2

  echo "Agent pid $pid"
  export SSH_AGENT_PID="$pid"

  echo "Agent sock $sock"
  export SSH_AUTH_SOCK="$sock"
}

function start_agent {
  # this seems to be the proper method as opposed to `exec ssh-agent bash`
  eval "$(ssh-agent)"
  ssh-add
}

function find_agent_meta {
  # Check to see if SSH Agent is already running
  agent_pid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($2)}' | head -1)"
  if [[ -z "$agent_pid" ]]; then
    echo "No agent found"
  else
    agent_ppid=$((agent_pid - 1))
    # and the actual auth socket file name is simply numerically one less than
    # the actual process id, regardless of what `ps -ef` reports as the ppid
    agent_sock="$(find /tmp -path "*ssh*" -type s -iname "agent.$agent_ppid" 2>&1 | grep -v 'Permission denied')"
  fi
}

find_agent_meta

# If the agent is not running (pid is zero length string)
if [[ -z "$agent_pid" ]]; then
    start_agent

# If the agent is running (pid is non zero)
else
    # Connect to the currently running ssh-agent

    # this doesn't work because for some reason the ppid is 1 both when
    # starting from ~/.profile and when executing as `ssh-agent bash`
    #agent_ppid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($3)}')"
    agent_ppid=$((agent_pid - 1))
    echo "Agent ppid $agent_ppid"

    # and the actual auth socket file name is simply numerically one less than
    # the actual process id, regardless of what `ps -ef` reports as the ppid
    agent_sock="$(find /tmp -path "*ssh*" -type s -iname "agent.$agent_ppid" 2>&1 | grep -v 'Permission denied')"

    # Invalidate the agent PID if no credentials are attached
    export_agent_meta $agent_pid $agent_sock
    ssh-add -l
    if [[ "$?" = 2 ]]; then
      killall -9 ssh-agent
      agent_pid=""
      echo "Existing agent had no credentials"
      start_agent
      find_agent_meta
      export_agent_meta $agent_pid $agent_sock
    fi
fi
