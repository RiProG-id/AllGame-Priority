```markdown
# AllGame Priority

## Description
The module elevates the task priority for the game list periodically to enhance its performance.

## Build

### Clone Repository

Clone the repository to your local machine using Git:

```sh
git clone https://github.com/yourusername/AllGame-Priority.git
cd AllGame-Priority
bash build.sh
```

### Installation Instructions

#### Non-Root Method

1. Extract the contents of the Priority.zip folder to internal storage.
   
2. Use either Brevent or ADB shell (e.g., `adb shell`) to manage the app.

3. Execute the following command to run the module:

```sh
sh /sdcard/priority/run.sh
```

Make sure to adjust paths and permissions as necessary for your setup.

#### Root Method

1. Install Priority.zip using a root manager app like Magisk, KernelSU, or Apatch.

2. Reboot your device.

3. Use `su -c AGP` for settings if required.
