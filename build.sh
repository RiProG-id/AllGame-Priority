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

clang "$mydir/NR/Priority/source.c" -o "$mydir/NR/Priority/main"
clang "$mydir/R/source.c" -o "$mydir/R/main"

zip_and_clean() {
  local dir=$1
  local zip_name=$2
  cd "$dir" || exit
  zip -r "./$zip_name" ./*
  rm -f "$dir/main"
}

zip_and_clean "$mydir/NR" "AllGame Priority 3.0 NR.zip"
zip_and_clean "$mydir/R" "AllGame Priority 3.0 R.zip"

mv "$mydir/NR/AllGame Priority 3.0 NR.zip" "$mydir"
mv "$mydir/R/AllGame Priority 3.0 R.zip" "$mydir"

cd "$mydir" || exit