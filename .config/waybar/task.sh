#!/bin/sh
task=$(dstask show-active | jq -r 'if length == 0 then "task: none" else .[0] | "task \(.id): \(.summary)" end')
echo ${task}
