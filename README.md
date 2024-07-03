## AllGame Priority

### Description
AllGame Priority is a module designed to periodically elevate the task priority for games, aiming to enhance their performance.

### Build Instructions

```sh
git clone https://github.com/yourusername/AllGame-Priority.git
cd AllGame-Priority
bash build.sh
```

### Installation Instructions

#### Non-Root Method

1. Extract the `Priority` folder from `AllGame Priority 3.0 R.zip` to internal storage.

2. Use either Brevent or other ADB shell app.

3. Edit the `gamelist.txt` file to add support for other games.

4. Execute the following command to run the module:
   ```sh
   sh /sdcard/priority/run.sh
   ```

**Notes for Non-Root Method:**
- Make sure to edit `gamelist.txt` to include support for additional games.
- To disable notifications from the application, remove the `toast.apk` file.

#### Root Method

1. Install `AllGame Priority 3.0 R.zip` using a root manager app like Magisk, KernelSU, or Apatch.

2. Reboot your device.

**Notes for Root Method:**
- Use `su -c AGP` command to configure settings if required.

[Support ME](https://t.me/RiOpSo/2848)