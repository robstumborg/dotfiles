#!/bin/bash
notmuch tag -inbox -- folder:/inbox/ and tag:inbox
pkill --signal SIGUSR1 alot
