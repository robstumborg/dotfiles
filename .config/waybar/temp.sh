#!/bin/sh
cpu=$(sensors | grep "Package id 0" | awk '{print $4}' | sed 's/+//;s/\.0//;s/°C/°/')
echo "cpu: ${cpu} |"

