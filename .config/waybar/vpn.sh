#!/bin/bash
ip route | grep -q '10.6.0.2' \
&& echo '{"text":"Connected","class":"connected","percentage":100}' \
|| echo '{"text":"Disconnected","class":"disconnected","percentage":0}'

