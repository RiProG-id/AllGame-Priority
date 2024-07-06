#!/bin/bash

if ! command -v zip > /dev/null 2>&1; then
  echo "zip is not installed. Please install zip to proceed."
  exit 1
fi
if ! command -v clang > /dev/null 2>&1; then
  echo "clang is not installed. Please install clang to proceed."
  exit 1
fi

mydir=$(dirname "$(realpath "$0")")
version=$(cat "$mydir"/src/R/module.prop | grep version= | awk -F'=' '{print $2}')
if [ ! -d "$mydir"/output ]; then
  mkdir "$mydir"/output
fi

if [ -d "$mydir"/NR ]; then
  rm -rf "$mydir"/NR
fi
mkdir -p "$mydir"/NR/Priority
cp "$mydir"/src/gamelist.txt "$mydir"/NR/Priority
cp "$mydir"/src/NR/run.sh "$mydir"/NR/Priority
cp "$mydir"/src/source.c "$mydir"/NR/Priority
cp "$mydir"/src/Toast.apk "$mydir"/NR/Priority
cd "$mydir/NR/Priority"
clang ./source.c -o ./main
cd "$mydir/NR"
zip -r ./"AllGame Priority $version NR.zip" ./*
cd "$mydir"
mv "$mydir"/NR/"AllGame Priority $version NR.zip" "$mydir"/output
rm -rf "$mydir"/NR

if [ -d "$mydir"/R ]; then
  rm -rf "$mydir"/R
fi
mkdir "$mydir"/R
mkdir "$mydir"/R/common
mkdir -p "$mydir"/R/META-INF/com/google/android
mkdir -p "$mydir"/R/system/bin
cp "$mydir"/src/R/module.prop "$mydir"/R
cp "$mydir"/src/gamelist.txt "$mydir"/R
cp "$mydir"/src/R/install.sh "$mydir"/R
cp "$mydir"/src/R/service.sh "$mydir"/R/common
cp "$mydir"/src/R/update-binary.sh "$mydir"/R/META-INF/com/google/android/update-binary
cp "$mydir"/src/R/updater-script.sh "$mydir"/R/META-INF/com/google/android/updater-script
cp "$mydir"/src/R/AGP.sh "$mydir"/R/system/bin/AGP
cp "$mydir"/src/source.c "$mydir"/R
cp "$mydir"/src/Toast.apk "$mydir"/R
cd "$mydir"/R
clang ./source.c -o ./main
zip -r ./"AllGame Priority $version R.zip" ./*
cd "$mydir"
mv "$mydir"/R/"AllGame Priority $version R.zip" "$mydir"/output
rm -rf "$mydir"/R