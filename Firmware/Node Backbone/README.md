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
