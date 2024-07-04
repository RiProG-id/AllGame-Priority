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
echo "AllGame Priority 3.0"
echo ""

maindir=/sdcard/Priority

sleep 2

counter=1
package_list=$(pm list packages | cut -f 2 -d :)
game_list=$(cat "$maindir/gamelist.txt")
echo "$game_list" | while IFS= read -r gamelist; do
    line=$(echo "$gamelist" | awk '!/ /')
    if echo "$package_list" | grep -q "$line"; then
        echo "  $counter. $line"
        counter=$((counter + 1))
    else
        sed -i "/$line/d" "$maindir/gamelist.txt"
    fi
done
echo ""

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

if [ ! "$1" = kill ]; then
  status=$(pgrep -f main) >/dev/null 2>&1
  if [ ! "$status" ]; then
    cp "$maindir/main" /data/local/tmp
    chmod +x /data/local/tmp/main
    nohup /data/local/tmp/main > /dev/null 2>&1 &
  fi

  sleep 2
  status=$(pgrep -f main) >/dev/null 2>&1
  if [ "$status" ]; then
    echo "Program is running in the background."
  else
    echo "Program failed to run"
  fi
  echo ""
else
  status=$(pgrep -f main) >/dev/null 2>&1
  if [ "$status" ]; then
    pkill -f main
  fi

  status=$(pgrep -f main) >/dev/null 2>&1
  if [ ! "$status" ]; then
    echo "Program is stopped in the background."
  else
    echo "Program failed to stop."
  fi
  echo ""
fi