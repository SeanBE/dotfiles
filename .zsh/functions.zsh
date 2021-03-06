myIp() {
  curl ifconfig.me
  echo "\n"
  hostname -I | awk '{print $1}'
}

isTmux() {
	[ -n "$TMUX" ]
}

# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

# fshow - git commit browser
# https://junegunn.kr/2015/03/browsing-git-commits-with-fzf
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

sqlformat() {
        echo "\n" && python -c 'import sqlparse; print(sqlparse.format("""'$1'""", reindent=True, keyword_case="upper"))'
}

docker-labels() {
    docker inspect --format '{{ json .Config.Labels }}' $1 | jq 
}

headphonesOn() {
        if ! pactl list sinks short | grep bluez >/dev/null;
        then
                echo bluez sink not found
        else
                bt_sink_index=`pactl list sinks short | grep bluez_sink | cut -f1`
                pacmd set-default-sink $bt_sink_index
                echo using bleuz sink
        fi
}

# Print headers, following redirects.
# Based on: https://stackoverflow.com/a/10060342/2103996
function headers() {
  emulate -L zsh

  if [ $# -ne 1 ]; then
    echo "error: a host argument is required"
    return 1
  fi

  local REMOTE=$1

  curl -sSL -D - "$REMOTE" -o /dev/null
}
