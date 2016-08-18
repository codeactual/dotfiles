# From https://gist.github.com/martijnvermaat/8070533#gistcomment-1778689
echo "Loading $0"

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

function ssh_agent_start {
  # Launch SSH agent if not running
  if ! pgrep ssh-agent >/dev/null; then ssh-agent ; fi
}

function ssh_agent_link_socket {
  # Link the latest ssh-agent socket
  ln -sf $(find /tmp -maxdepth 2 -type s -name "agent*" -user $USER -printf '%T@ %p\n' 2>/dev/null |sort -n|tail -1|cut -d' ' -f2) ~/.ssh/ssh_auth_sock
}

function ssh_agent_stop {
  pkill ssh-agent
  rm -rf /tmp/ssh-* $SSH_AUTH_SOCK
}

ssh_agent_link_socket
ssh-add -l
if [ $? -ne 0 ]; then
  ssh_agent_stop
  ssh_agent_start
  sleep 1
  ssh_agent_link_socket
  ssh-add
fi
