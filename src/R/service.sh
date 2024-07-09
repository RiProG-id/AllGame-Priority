#!/bin/sh
while [ -z "$(getprop sys.boot_completed)" ]; do
	sleep 5
done
sleep 10
if ! pm list package | grep -q me.toast; then
	pm disable com.android.vending >/dev/null 2>&1
	pm install /data/adb/modules/Priority/toast.apk
	if ! pm list package | grep -q me.toast; then
		cp /data/adb/modules/Priority/toast.apk /data/local/tmp
		pm install /data/local/tmp/toast.apk
		rm /data/local/tmp/toast.apk
	fi
	pm enable com.android.vending >/dev/null 2>&1
fi
sleep 10
/data/adb/modules/Priority/main
