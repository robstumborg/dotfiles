#!/bin/sh
mails=$(notmuch search tag:inbox | wc -l)
echo "mail|string|${mails}"
echo ""
