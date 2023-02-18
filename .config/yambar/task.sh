#!/bin/sh
task=$(dstask show-active | jq -r 'if length == 0 then "none" else .[0] | "\(.summary) (id: \(.id))" end')
echo "task|string|${task}"
echo ""
