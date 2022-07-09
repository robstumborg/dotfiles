#!/bin/zsh
source /home/rj1/.config/zsh/.zprofile

# download mail from remotes
if [ $# -eq -0 ]; then
    mbsync -c $XDG_CONFIG_HOME/mbsync/config -a
else
    mbsync -c $XDG_CONFIG_HOME/mbsync/config $1
fi

# add mail to notmuch db
notmuch new

# do some tagging
notmuch tag +inbox -- folder:/inbox/ and tag:new
notmuch tag +notify -- folder:/inbox/ and tag:new
notmuch tag -new -- tag:new

# notify
SEARCH="tag:notify"

NOTIFY_COUNT=$(notmuch count "$SEARCH")

if [ "$NOTIFY_COUNT" -gt 0 ]; then
  RESULTS=$(notmuch search --format=json --output=summary --limit=3 --sort="newest-first" "$SEARCH" | jq -r '.[] | "\(.authors): \(.subject)"')
  /usr/bin/notify-send "$NOTIFY_COUNT new mails:" "$RESULTS"
fi

notmuch tag -notify -- tag:notify

# refresh alot buffer if it's open
pkill --signal SIGUSR1 alot
