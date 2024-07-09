## AllGame Priority

### Description
AllGame Priority is a module designed to periodically elevate task priorities for games, aiming to enhance their performance.

### Build Instructions

```sh
git clone https://github.com/RiProG-id/AllGame-Priority.git
cd AllGame-Priority
bash build.sh
```

### Installation Instructions

#### Non-Root Method

1. Extract the `Priority` folder from `AllGame Priority 4.1 R.zip` to internal storage.
   
2. Use either Brevent or another ADB shell app.
   
3. Edit the `gamelist.txt` file to add support for additional games.
   
4. Execute the following commands to run the module:
   - Run:
     ```sh
     sh /sdcard/Priority/run.sh
     ```
   - Run without toast:
     ```sh
     sh /sdcard/Priority/run.sh notoast
     ```
   - Kill program:
     ```sh
     sh /sdcard/Priority/run.sh kill
     ```

- Make sure to edit gamelist.txt to include support for additional games.

#### Root Method

1. Install `AllGame Priority 4.1 R.zip` using a root manager app like Magisk, KernelSU, or Apatch.
   
2. Reboot your device.

- su -c AGP | to configure if required.

### Changelog from Version 4.0 to 4.1

- Fixed issue where AGP menu could not be selected.
- Fixed issue where app toast could not be installed.
- Fixed error issues on Android version 8.
- Reverted to the old toast application.
- Fixed issue with Play Protect marking the app as unsafe.

### More Information

**Author:**
[RiProG](https://github.com/RiProG-id)

**Contributors:**
- [rakarmp](https://github.com/rakarmp)
- [Rem01Gaming](https://github.com/Rem01Gaming)
- [fahrez256](https://github.com/fahrez256)

**Visit:**
- [Support ME](https://t.me/RiOpSo/2848)
- [Telegram Channel](https://t.me/RiOpSo)
- [Telegram Group](https://t.me/RiOpSoDisc)
