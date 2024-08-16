#!/bin/sh
SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=true
REPLACE="
"
ui_print ""
ui_print "*****************************************"
ui_print "*      RiProG Open Source @RiOpSo       *"
ui_print "*****************************************"
ui_print "*                                       *"
ui_print "*                 Author                *"
ui_print "*             Muhammad Rizki            *"
ui_print "* Telegram: @RiProG | Github: RiProG-ID *"
ui_print "*                                       *"
ui_print "*****************************************"
ui_print ""
unzip -o "$ZIPFILE" 'toast.apk' -d "$MODPATH" >&2
if ! pm list packages | cut -f 2 -d : | grep -q bellavita.toast; then
	pm install "$MODPATH"/toast.apk >/dev/null 2>&1
	if ! pm list packages | cut -f 2 -d : | grep -q bellavita.toast; then
		cp "$MODPATH"/toast.apk /data/local/tmp >/dev/null 2>&1
		pm install /data/local/tmp/toast.apk >/dev/null 2>&1
		rm /data/local/tmp/toast.apk >/dev/null 2>&1
	fi
fi
ui_print ""
unzip -o "$ZIPFILE" 'gamelist.txt' -d "$MODPATH" >&2
counter=1
package_list=$(pm list packages | cut -f 2 -d :)
game_list=$(cat "$MODPATH/gamelist.txt")
echo "$game_list" | while IFS= read -r gamelist; do
	line=$(echo "$gamelist" | grep -v " ")
	if echo "$package_list" | grep -q "$line"; then
		ui_print "  $counter. $line"
		counter=$((counter + 1))
	else
		sed -i "/$line/d" "$MODPATH/gamelist.txt"
	fi
done
unzip "$ZIPFILE" system/* -d "$MODPATH/" >/dev/null 2>&1
chmod +x "$MODPATH/system/bin/AGP"
unzip -o "$ZIPFILE" 'source.c' -d "$MODPATH" >&2
if unzip -l | grep -q main; then
	unzip -o "$ZIPFILE" 'main' -d "$MODPATH" >&2
else
	architecture=$(getprop ro.product.cpu.abi)
	if [ "$architecture" = "arm64-v8a" ]; then
		unzip -p "$ZIPFILE" 'arm64' >"$MODPATH/main"
	elif [ "$architecture" = "armeabi-v7a" ]; then
		unzip -p "$ZIPFILE" 'arm' >"$MODPATH/main"
	fi
fi
chmod +x "$MODPATH/main"
ui_print ""
ui_print "su -c AGP | to configure if required"
ui_print ""
