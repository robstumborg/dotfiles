#!/bin/bash
notmuch tag -inbox -- tag:inbox
pkill --signal SIGUSR1 alot
