# Node Backbone Firmware (Waveshare)
This page is the quick user entrypoint for Waveshare ESP32-S3-ETH firmware in this repo.

## Get firmware

1. Open releases: https://github.com/johnvoipguy/wled-custom-builds/releases
2. Download the Waveshare ESP32-S3-ETH asset for your target line.

## Which file should I flash?

- `.app.bin` for OTA updates on an already-running device.
- `.full.bin` for first-time USB/UART flash or recovery.

## Flashing

### OTA

Use WLED UI: Settings -> Security & Updates -> Manual OTA.

### UART (first-time / recovery)
# Installing esptool

## Prerequisites

- Python 3.4 or newer installed
- `pip` installed and on your system `PATH`

### Don't have Python yet?

Check first — open a terminal and run `python --version` (Windows) or `python3 --version` (macOS/Linux). If you get a version number of 3.4 or higher, you're set. Otherwise:

**Windows**

1. Download the installer from [python.org/downloads](https://www.python.org/downloads/).
2. Run it, and **check the box that says "Add python.exe to PATH"** on the first screen. This is the step everyone misses — skip it and `pip` won't be found later.
3. Click **Install Now**.
4. Open a *new* command prompt (existing ones won't pick up the PATH change) and verify:

```bash
   python --version
   pip --version
```

**macOS**

macOS ships with an old Python that you shouldn't rely on. Install a current one instead:

```bash
# With Homebrew (recommended)
brew install python
```

Or download the installer from [python.org/downloads](https://www.python.org/downloads/) and run it. Then verify:

```bash
python3 --version
pip3 --version
```

## Installation

1. Open a command prompt (Windows) or terminal (macOS/Linux).
2. Run:

```bash
   pip install esptool
```

3. If that fails, try one of these:

```bash
   pip3 install esptool
```

```bash
   python -m pip install esptool
```

4. If you see `error: externally-managed-environment` (common on newer Debian/Ubuntu, or macOS with Homebrew Python), your system Python is protected against direct `pip` installs. Use `pipx` instead — it installs esptool into its own isolated environment and still puts it on your `PATH`:

```bash
   pipx install esptool
```

   If `pipx` isn't installed:

```bash
   # Debian/Ubuntu
   sudo apt install pipx

   # macOS
   brew install pipx
```

## Verify Installation

```bash
esptool version
```

If you see `command not found` or `'esptool' is not recognized`, you likely have an older release (v4.x or earlier), which uses the `.py` suffix:

```bash
esptool.py version
```

## References

- [esptool installation docs](https://docs.espressif.com/projects/esptool/en/latest/esp32/installation.html)
- [esptool README (ESP8266_RTOS_SDK)](https://github.com/espressif/ESP8266_RTOS_SDK/blob/master/components/esptool_py/esptool/README.md)
```sh
esptool.py --chip esp32s3 write_flash 0x0000 <your-file>.full.bin
```

## Troubleshooting

- Wrong network behavior or missing Ethernet: verify you flashed the Waveshare target build.
- OTA failures: flash `.full.bin` over UART and retry setup.

- If you prefer web-based flasher:  [ESPConnect](https://thelastoutpostworkshop.github.io/ESPConnect/)
  
Latest:
- [waveshare-esp32s3-eth-v16-waveshare_esp32s3_eth-e5614cb (mirrored)](https://github.com/johnvoipguy/WateefyElectronics/releases/tag/mirror-waveshare-esp32s3-eth-v16-waveshare_esp32s3_eth-e5614cb)

Recent builds:
- [waveshare-esp32s3-eth-v16-waveshare_esp32s3_eth-e5614cb (mirrored)](https://github.com/johnvoipguy/WateefyElectronics/releases/tag/mirror-waveshare-esp32s3-eth-v16-waveshare_esp32s3_eth-e5614cb)

All releases:
https://github.com/johnvoipguy/WateefyElectronics/releases
