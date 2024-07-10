#!/bin/sh
nohup sh -c 'while [ -z "$(getprop sys.boot_completed)" ]; do sleep 5; done; if pm list packages | cut -f 2 -d : | grep -q bellavita.toast; then;	pm uninstall bellavita.toast; fi' >/dev/null 2>&1 &

