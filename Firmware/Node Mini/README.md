# Node Mini Firmware (XIAO)
This page is the quick user entrypoint for Seeed Xiao ESP32S3 firmware in this repo.

## Get firmware

1. Open releases: https://github.com/johnvoipguy/wled-custom-builds/releases
2. Download the Seeed Xiao ESP32S3 asset for your target line.

## Which file should I flash?

- `.app.bin` for OTA updates on an already-running device.
- `.full.bin` for first-time USB/UART flash or recovery.

## Flashing

### OTA

Use WLED UI: Settings -> Security & Updates -> Manual OTA.

### UART (first-time / recovery)

```sh
esptool.py --chip esp32s3 write_flash 0x0000 <your-file>.full.bin
```

## Known-good preserved legacy assets

Latest:
- [seeed-xiao-esp32s3-v16-seeed_xiao_esp32s3v2-e1ca36c (mirrored)](https://github.com/johnvoipguy/WateefyElectronics/releases/tag/mirror-seeed-xiao-esp32s3-v16-seeed_xiao_esp32s3v2-e1ca36c)

Recent builds:
- [seeed-xiao-esp32s3-v16-seeed_xiao_esp32s3v2-e1ca36c (mirrored)](https://github.com/johnvoipguy/WateefyElectronics/releases/tag/mirror-seeed-xiao-esp32s3-v16-seeed_xiao_esp32s3v2-e1ca36c)
- [seeed-xiao-esp32s3-v15-seeed_xiao_esp32s3v2-9a42371 (mirrored)](https://github.com/johnvoipguy/WateefyElectronics/releases/tag/mirror-seeed-xiao-esp32s3-v15-seeed_xiao_esp32s3v2-9a42371)
- [seeed-xiao-esp32s3-v15-seeed_xiao_esp32s3v2-5afc742 (mirrored)](https://github.com/johnvoipguy/WateefyElectronics/releases/tag/mirror-seeed-xiao-esp32s3-v15-seeed_xiao_esp32s3v2-5afc742)
- [seeed-xiao-esp32s3-nightly-seeed_xiao_esp32s3v2-d8018a2 (mirrored)](https://github.com/johnvoipguy/WateefyElectronics/releases/tag/mirror-seeed-xiao-esp32s3-nightly-seeed_xiao_esp32s3v2-d8018a2)
- [LEGACY seeed_xiao_esp32s3v2E WLED Firmware - 2026-05-21 22:26 (mirrored)](https://github.com/johnvoipguy/WateefyElectronics/releases/tag/mirror-seeed_xiao_esp32s3v2-v20260521-222612)

All releases:
https://github.com/johnvoipguy/WateefyElectronics/releases
