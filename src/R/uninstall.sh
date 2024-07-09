#!/bin/sh
nohup sh -c 'while [ -z "$(getprop sys.boot_completed)" ]; do sleep 5; done; pm uninstall bellavita.toast' >/dev/null 2>&1 &
