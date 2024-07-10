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

1. Extract the `Priority` folder from `AllGame Priority 4.5 R.zip` to internal storage.
   
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

1. Install `AllGame Priority 4.5 R.zip` using a root manager app like Magisk, KernelSU, or Apatch.
   
2. Reboot your device.

- su -c AGP | to configure if required.

### Changelog from Version 4.1 to 4.5

- Fixed the issue of AGP toast menu not taking effect
- Consolidated initialization of toast notifications for improved efficiency.
- Simplified file handling for game list retrieval.
- Enhanced game detection logic for better performance.
- Optimized system call sequences for game optimization tasks.
- Streamlined state management between game open and close events.
- Bug fixes for improved stability and reliability.

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
