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

1. Extract the `Priority` folder from `AllGame Priority 3.5 R.zip` to internal storage.
   
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

**Notes for Non-Root Method:**
- Make sure to edit gamelist.txt to include support for additional games.

#### Root Method

1. Install `AllGame Priority 3.5 R.zip` using a root manager app like Magisk, KernelSU, or Apatch.
   
2. Reboot your device.

**Notes for Root Method:**
- Use the `su -c AGP` command to configure or modify the game list.txt if necessary.
- Option to enable/disable toast in the menu.

### Changelog from Version 3.0 to 3.5
Here is the shortened changelog:

- Fixed toast menu issue.
- Merged NR and R sources with improved `gamelist.txt` detection.
- Added delay loop for performance optimization.
- Introduced new commands and configurations for Non-Root users.
- Refactored source code.
- Applied clang-format.
- Optimized compiler clang with -O3 flag.
- Added new games.
- Fixed bugs.

For additional support, visit [Support ME](https://t.me/RiOpSo/2848).