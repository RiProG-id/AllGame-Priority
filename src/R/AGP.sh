#!/bin/sh
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
echo "Telegram: @fahrezone | Github: fahrez256"
echo ""
sleep 2
gamelist=/data/adb/modules/Priority/gamelist.txt
sleep 2
while true; do
	if [ "$extended" = true ]; then
		package_list=$(pm list packages | cut -f 2 -d :)
	else
		package_list=$(pm list packages -3 | cut -f 2 -d :)
	fi
	echo ""
	printf "\033[1mAllGame Priority Menu\033[0m"
	echo ""
	count=1
	for package in $package_list; do
		status=$(grep "$package" "$gamelist")
		if [ -z "$status" ]; then
			printf "\033[31m%s. %s\033[0m\n" "$count" "$package"
		else
			printf "\033[32m%s. %s\033[0m\n" "$count" "$package"
		fi
		count=$((count + 1))
	done
	echo ""
	if [ ! "$extended" = true ]; then
		printf "\033[31m%s. %s\033[0m\n" "$count" "Extended Menu"
	else
		printf "\033[32m%s. %s\033[0m\n" "$count" "Extended Menu"
	fi
	count=$((count + 1))
	echo ""
	if pm list package -d | grep -q me.toast; then
		printf "\033[31m%s. %s\033[0m\n" "$count" "Toast"
	else
		printf "\033[32m%s. %s\033[0m\n" "$count" "Toast"
	fi
	count=$((count + 1))
	echo ""
	echo "$count. exit"
	echo ""
	echo "Select number:"
	echo
	read -r choice
	if [ "$choice" = "$count" ]; then
		echo ""
		echo "Gamelist changes will take effect after next reboot
"
		echo ""
		echo ""
		exit 0
	elif [ "$choice" = "$((count - 1))" ]; then
		if pm list package -d | grep -q me.toast; then
			pm enable me.toast >/dev/null 2>&1
		else
			pm disable me.toast >/dev/null 2>&1
		fi
	elif [ "$choice" = "$((count - 2))" ]; then
		if [ "$extended" = true ]; then
			extended=false
		else
			extended=true
		fi
	elif [ "$choice" = "$count" ]; then
		package=$(echo "$package_list" | awk "NR==$choice")
		if grep -q "$package" "$gamelist"; then
			sed -i "/$package/d" "$gamelist"
		else
			echo "$package" >>"$gamelist"
		fi
	else
		echo "invalid select"
	fi
	echo ""
	sleep 2
done
