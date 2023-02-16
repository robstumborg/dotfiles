#!/bin/sh
task=$(dstask show-active | jq -r '.[0].summary')
echo "task|string|${task}"
echo ""
