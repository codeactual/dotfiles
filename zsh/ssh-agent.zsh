# From https://gist.github.com/martijnvermaat/8070533#gistcomment-1778689
echo "Loading $0"

# Launch SSH agent if not running
if ! ps aux |grep $(whoami) |grep ssh-agent |grep -v grep >/dev/null; then ssh-agent ; fi

function ssh_agent_link_socket {
  # Link the latest ssh-agent socket
  ln -sf $(find /tmp -maxdepth 2 -type s -name "agent*" -user $USER -printf '%T@ %p\n' 2>/dev/null |sort -n|tail -1|cut -d' ' -f2) ~/.ssh/ssh_auth_sock
}

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

ssh_agent_link_socket
ssh-add -l
if [ $? -ne 0 ]; then
  ssh-add
  ssh_agent_link_socket
fi
