#!/system/bin/sh

if [ ! -f /sdcard/Priority/gamelist.txt ]; then
  echo "Wrong directory"
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
echo "Contributor"
echo "Telegram: @Zyarexx | Github: rakarmp"
echo "Telegram: @Rem01Gaming | Github: Rem01Gaming"
echo ""

sleep 2

echo "AllGame Priority 4.0"
echo 

sleep 2

cp /sdcard/Priority/gamelist.txt /sdcard/Priority/gamelist.txt.temp
counter=1
package_list=$(pm list packages | cut -f 2 -d :)
while IFS= read -r gamelist; do
    line=$(echo "$gamelist" | awk '!/ /')
    if echo "$package_list" | grep -q "$line"; then
        echo   "$counter. $line"
        counter=$((counter + 1))
    else
        sed -i /"$line"/d /sdcard/Priority/gamelist.txt.temp
    fi
done < /sdcard/Priority/gamelist.txt
mv /sdcard/Priority/gamelist.txt.temp /sdcard/Priority/gamelist.txt
echo ""

if [ "$1" = notoast ]; then
  if [ -f /sdcard/Priority/Toast.apk ]; then
    mv /sdcard/Priority/Toast.apk /sdcard/Priority/NoToast.apk
  fi
else
  if [ -f /sdcard/Priority/NoToast.apk ]; then
    mv /sdcard/Priority/NoToast.apk /sdcard/Priority Toast.apk
  fi
fi

if [ -f /sdcard/Priority/Toast.apk ]; then
  if ! pm list packages -3 | grep -q me.toast; then
    cp /sdcard/Priority/Toast.apk /data/local/tmp
    pm install /data/local/tmp/Toast.apk
    rm /data/local/tmp/Toast.apk
  fi
else
  if pm list packages -3 | grep -q me.toast; then
    pm uninstall me.toast
  fi
fi

sleep 2
pkill -f main
if [ "$1" = kill ]; then
  if ! pgrep -f main >/dev/null 2>&1; then
    echo "Program is stopped in the background."
  else
    echo "Program failed to stop."
  fi
  echo ""
else
  if ! pgrep -f main >/dev/null 2>&1; then
    cp /sdcard/Priority/main /data/local/tmp
    chmod +x /data/local/tmp/main
    nohup /data/local/tmp/main > /dev/null 2>&1 &
  fi
  sleep 2
  if pgrep -f main >/dev/null 2>&1; then
    echo "Program is running in the background."
  else
    echo "Program failed to run"
  fi
  echo ""
fi