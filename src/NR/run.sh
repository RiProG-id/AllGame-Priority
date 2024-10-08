#!/system/bin/sh
if [ ! -f /sdcard/Priority/gamelist.txt ]; then
	echo "Wrong directory"
fi

if [ ! -f /sdcard/Priority/main ]; then
	architecture=$(getprop ro.product.cpu.abi)
	if [ "$architecture" = "arm64-v8a" ]; then
		mv /sdcard/Priority/arm64 /sdcard/Priority/main
		rm /sdcard/Priority/arm
	elif [ "$architecture" = "armeabi-v7a" ]; then
		mv /sdcard/Priority/arm /sdcard/Priority/main
		rm /sdcard/Priority/arm64
	fi
fi
echo ""
echo "*****************************************"
echo "*      RiProG Open Source @RiOpSo       *"
echo "*****************************************"
echo "*                                       *"
echo "*                 Author                *"
echo "*             Muhammad Rizki            *"
echo "* Telegram: @RiProG | Github: RiProG-ID *"
echo "*                                       *"
echo "*****************************************"
echo ""
sleep 2
echo "AllGame Priority 5.0"
echo ""
sleep 2
cp /sdcard/Priority/gamelist.txt /sdcard/Priority/gamelist.txt.temp
counter=1
package_list=$(pm list packages | cut -f 2 -d :)
while IFS= read -r gamelist; do
	line=$(echo "$gamelist" | grep -v " ")
	if echo "$package_list" | grep -q "$line"; then
		echo "$counter. $line"
		counter=$((counter + 1))
	else
		sed -i /"$line"/d /sdcard/Priority/gamelist.txt.temp
	fi
done </sdcard/Priority/gamelist.txt
mv /sdcard/Priority/gamelist.txt.temp /sdcard/Priority/gamelist.txt
echo ""
if [ "$1" = notoast ]; then
	if [ -f /sdcard/Priority/toast.apk ]; then
		mv /sdcard/Priority/toast.apk /sdcard/Priority/notoast.apk
	fi
else
	if [ -f /sdcard/Priority/notoast.apk ]; then
		mv /sdcard/Priority/notoast.apk /sdcard/Priority/toast.apk
	fi
fi
if [ -f /sdcard/Priority/toast.apk ]; then
	if ! pm list packages | cut -f 2 -d : | grep -q bellavita.toast; then
		pm install /sdcard/Priority/toast.apk >/dev/null 2>&1
		if ! pm list packages | cut -f 2 -d : | grep -q bellavita.toast; then
			cp /sdcard/Priority/toast.apk /data/local/tmp >/dev/null 2>&1
			pm install /data/local/tmp/toast.apk >/dev/null 2>&1
			rm /data/local/tmp/toast.apk
		fi
	fi
else
	pm uninstall bellavita.toast >/dev/null 2>&1
fi
sleep 2
pkill -f main >/dev/null 2>&1
if [ "$1" = kill ]; then
	if ! pgrep -f main >/dev/null 2>&1; then
		echo "Program is stopped in the background."
		rm /data/local/tmp/main
	else
		echo "Program failed to stop."
	fi
	echo ""
else
	if ! pgrep -f main >/dev/null 2>&1; then
		cp /sdcard/Priority/main /data/local/tmp
		chmod +x /data/local/tmp/main
		nohup /data/local/tmp/main >/dev/null 2>&1 &
	fi
	sleep 2
	if pgrep -f main >/dev/null 2>&1; then
		echo "Program is running in the background."
	else
		echo "Program failed to run"
	fi
	echo ""
fi
