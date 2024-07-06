#!/system/bin/sh

if [ ! -f /sdcard/Priority/gamelist.txt ]; then
  echo "File gamelist.txt not found"
  echo "Wrong directory"
fi

echo ""
echo "*****************************************"
echo "*      RiProG Open Source @RiOpSo       *"
echo "*****************************************"
echo "*                                       *"
echo "*             Muhammad Rizki            *"
echo "* Telegram: @RiProG | Github: RiProG-ID *"
echo "*                                       *"
echo "*****************************************"
echo ""

sleep 2

echo "AllGame Priority 3.1"
echo ""

maindir=/sdcard/Priority

sleep 2

cp "$maindir/gamelist.txt" "$maindir/gamelist.txt.temp" 
counter=1
package_list=$(pm list packages | cut -f 2 -d :)
while IFS= read -r gamelist; do
    line=$(echo "$gamelist" | awk '!/ /')
    if echo "$package_list" | grep -q "$line"; then
        echo "  $counter. $line"
        counter=$((counter + 1))
    else
        sed -i "/$line/d" "$maindir/gamelist.txt.temp"
    fi
done < "$maindir/gamelist.txt"
mv "$maindir/gamelist.txt.tmp" "$maindir/gamelist.txt"
echo ""

if [ "$1" = "notoast" ]; then
  if [ -f "$maindir/Toast.apk" ]; then
    mv "$maindir/Toast.apk" "$maindir/NoToast.apk"
  fi
else
  if [ -f "$maindir/NoToast.apk" ]; then
    mv "$maindir/NoToast.apk" "$maindir Toast.apk"
  fi
fi

if [ -f "$maindir/Toast.apk" ]; then
  if ! pm list packages -3 | grep -q bellavita.toast; then
    cp "$maindir/Toast.apk" /data/local/tmp
    pm install /data/local/tmp/Toast.apk
    rm /data/local/tmp/Toast.apk
  fi
else
  if pm list packages -3 | grep -q bellavita.toast; then
    pm uninstall bellavita.toast
  fi
fi

sleep 2

if [ "$1" = kill ]; then
  if pgrep -f main; then
    pkill -f main
  fi
  sleep 2
  if ! pgrep -f main; then
    echo "Program is stopped in the background."
  else
    echo "Program failed to stop."
  fi
  echo ""
else
  if ! pgrep -f main; then
    cp "$maindir/main" /data/local/tmp
    chmod +x /data/local/tmp/main
    nohup /data/local/tmp/main > /dev/null 2>&1 &
  fi
  sleep 2
  if pgrep -f main; then
    echo "Program is running in the background."
  else
    echo "Program failed to run"
  fi
  echo ""
fi