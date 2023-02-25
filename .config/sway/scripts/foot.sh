#!/bin/bash

if [ $(pgrep foot) != 0 ]; then
  foot -s
  footclient
else
  footclient
fi
