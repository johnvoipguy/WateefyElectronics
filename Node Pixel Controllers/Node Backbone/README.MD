<img src="../../images/Node_Backbone.png" width="485" height="445"> <img src="../../images/Node_Backbone_v1b_full.png" width="445" height="405">

                          V1                                                                   V1b


<p align="center">
  <img src="/images/wled_logo_akemi.png">
  <a href="https://github.com/Aircoookie/WLED/releases"><img src="https://img.shields.io/github/release/Aircoookie/WLED.svg?style=flat-square"></a>
  <a href="https://raw.githubusercontent.com/Aircoookie/WLED/master/LICENSE"><img src="https://img.shields.io/github/license/Aircoookie/wled?color=blue&style=flat-square"></a>
  <a href="https://wled.discourse.group"><img src="https://img.shields.io/discourse/topics?colorB=blue&label=forum&server=https%3A%2F%2Fwled.discourse.group%2F&style=flat-square"></a>
  <a href="https://discord.gg/QAh7wJHrRM"><img src="https://img.shields.io/discord/473448917040758787.svg?colorB=blue&label=discord&style=flat-square"></a>
  <a href="https://kno.wled.ge"><img src="https://img.shields.io/badge/quick_start-wiki-blue.svg?style=flat-square"></a>
  <a href="https://github.com/Aircoookie/WLED-App"><img src="https://img.shields.io/badge/app-wled-blue.svg?style=flat-square"></a>
  <a href="https://gitpod.io/#https://github.com/Aircoookie/WLED"><img src="https://img.shields.io/badge/Gitpod-ready--to--code-blue?style=flat-square&logo=gitpod"></a>

  </p>

# Welcome! ✨

A fast and feature-rich implementation of an ESP8266/ESP32 webserver to control NeoPixel (WS2812B, WS2811, SK6812) LEDs or also SPI based chipsets like the WS2801 and APA102!

## 🔌 Waveshare ESP32-S3-ETH Custom Build

This is a custom WLED build for the **Waveshare ESP32-S3-ETH** board with W5500 Ethernet support.

### 🚀 Quick Start (Get Flashing!)

**📥 Download Latest Firmware:**

**⚠️ Use v17** — this is the firmware line with full Ethernet protocol support (E1.31, Art-Net, DDP, MQTT over Ethernet). v16 is archived and does not route WLED protocols through Ethernet.

- Wrong network behavior or missing Ethernet: verify you flashed the v17 Waveshare target build.
- OTA failures: flash `.full.bin` over UART and retry setup.
 
Latest v17 builds:
https://github.com/johnvoipguy/WateefyElectronics/releases (filter for `waveshare-esp32s3-eth-v17`)

All releases:
https://github.com/johnvoipguy/WateefyElectronics/releases

**⚡ Flash Commands (v17):**

First time or after factory reset (use FULL.bin):
```bash
esptool.py --chip esp32s3 --port /dev/ttyACM0 --baud 921600 \
  write_flash 0x0 firmware/WLED_Waveshare_ESP32-S3-ETH_*_FULL.bin
```

OTA update on already-running board (use APP.bin, preserves settings):
```bash
esptool.py --chip esp32s3 --port /dev/ttyACM0 --baud 921600 \
  write_flash 0x10000 firmware/WLED_Waveshare_ESP32-S3-ETH_*_APP.bin
```

Replace `/dev/ttyACM0` with your serial port (Windows: `COM3`, `COM4`, etc.)

Alternatively, use web-based flasher: [ESPConnect](https://thelastoutpostworkshop.github.io/ESPConnect/)

### Hardware Configuration
- **Board**: Waveshare ESP32-S3-ETH (ESP32-S3, 16MB Flash, 8MB PSRAM) — v1a hardware
- **Ethernet**: W5500 SPI Ethernet (pins: MISO=12, MOSI=11, SCLK=13, CS=14, RST=9, INT=10)
- **LED Outputs**: 8 channels configured (GPIO 0, 1, 2, 3, 15, 18, 16, 17) — hardware-driven via 4 RMT + parallel I2S
  - **Note for v1b:** Proposed GPIO0→GPIO21 swap pending; when v1b ships, update this list and firmware accordingly
- **Status LED**: GPIO21 (onboard, not available for pixel output)

### Network Configuration

**v17 interface behavior:**
- **Ethernet (W5500)**: Wired 10/100 Mbps, carries E1.31, Art-Net, DDP, MQTT — full protocol support
- **WiFi**: Backup access carries E1.31, Art-Net, DDP, MQTT, webadmin — full protocol support (active only when Ethernet is disconnected)

#### Initial Setup Procedure
1. **First boot** (without Ethernet cable):
   - Device creates AP: `WLED-ETH-Config` (open, no password)
   - Connect to AP and configure WiFi via web interface (http://4.3.2.1)
   - Save settings and reboot

2. **Subsequent boots** (with Ethernet cable connected):
   - Ethernet: Gets DHCP address automatically (e.g., 192.168.50.239)
   - WiFi: Connects to configured SSID (e.g., 192.168.50.230)
   - Both interfaces active simultaneously — use Ethernet for LED streaming

#### Interface Capabilities (v17)

**Ethernet Interface** (primary for LED control):
- ✅ E1.31/sACN, Art-Net, DDP — **full protocol support over wire**
- ✅ MQTT
- ✅ HTTP/JSON API
- ✅ Web interface
- ✅ Ping/ICMP
- ✅ Low-latency, deterministic LED streaming

**WiFi Interface** (Initial configuration after flash and backup if no Ethernet):
- ✅ Full web interface (webadmin)
- ✅ E1.31 (sACN), Art-Net, DDP, MQTT — full protocol support
- ✅ HTTP/JSON API and WebSockets
- ✅ OTA updates
- ✅ Automatic activation when Ethernet is disconnected

#### Recommended Usage
- **Primary control**: Ethernet for xLights, sACN, Art-Net, and MQTT streaming
- **Configuration**: Web interface via Ethernet IP (primary) or WiFi if needed
- **Note on this firmware**: Waveshare v17 disables WiFi when Ethernet is connected. Other boards with different firmware keep both interfaces active.

### Technical Notes

v17 uses W5500 as a native Ethernet MAC/PHY interface (lwIP stack on ESP32 cores). This differs from v16's attempted hardware-socket offload, which proved non-functional — no WLED protocols actually reached Ethernet in v16. v17 trades some MCU cycles for correctness: the network stack runs in software, but every protocol that binds to lwIP works over Ethernet automatically.

### 🔧 Configuration Guide

#### First-Time Setup (WiFi Configuration Required)

**⚠️ CRITICAL: WiFi must be configured before Ethernet is connected.** This firmware disables WiFi when Ethernet cable is detected.

**Step 1: Initial Boot — NO Ethernet Cable**
1. Power on the board with **NO Ethernet cable connected**
2. Device creates open AP: `WLED-ETH-Config` (no password)
3. Connect phone/computer to this AP
4. Browser auto-opens to `http://4.3.2.1` (or navigate manually)
5. Go to **Config → WiFi Setup**
6. Enter your WiFi SSID and password
7. Click **Save & Reboot**

**Step 2: Connect Ethernet (WiFi will disable)**
1. After WiFi reboots and connects, plug Ethernet cable into RJ45 port
2. **WiFi automatically disables when Ethernet link is detected** — only one interface active at a time
3. Device gets **Ethernet IP** (check your router's DHCP list, e.g., 192.168.50.239)
4. Web interface accessible via **Ethernet IP only** until cable is unplugged (then WiFi auto-resumes)

**Step 3: Configure LED Settings**
1. Access web interface via Ethernet: `http://192.168.50.239` (or use mDNS: `http://wled-<chipid>.local`)
2. Go to **Config → LED Preferences**
3. Default LED pins: GPIO 0–7 (8 independent channels)
   - **Outputs 1–4**: Hardware RMT drivers (recommended for timing-critical strips like WS2812B)
   - **Outputs 5–8**: Software I2S drivers (automatic, no manual configuration needed)
4. Select LED type per channel (WS2812B, SK6812, WS2811, etc.)
5. Set LED count per channel
6. Click **Save** — no reboot required

**Step 4: Configure LED Streaming Protocol (Optional)**
1. Go to **Config → Sync Interfaces**
2. Select your LED control protocol: **E1.31 (sACN), Art-Net, or DDP** (recommended)
3. Set UDP port if needed (default: E1.31 = 5568, Art-Net = 6454, DDP = 4048)
4. Save and test from your control software (xLights, Vixen, etc.)

#### Network Settings (Pre-Configured)
- **Ethernet Type**: W5500 SPI (Type 13)
- **DHCP**: Enabled automatically
- **mDNS**: `http://wled-<chipid>.local` available after WiFi setup

#### Available GPIO for Usermods and Peripherals

If you want to add custom functionality (temperature sensors, extra I/O, microphone input, etc.):

- **GPIO 38–41**: Available for usermods (I²C, SPI, analog input, etc.)
- **GPIO4**: Reserved for SD card (if future SD card support is added)

**Do NOT use:**
- GPIO 0–3, 15–18: LED data outputs
- GPIO 4–7: SD card (reserved for future SD card support)
- GPIO 9–14: W5500 Ethernet SPI (CS, RST, INT, MOSI, SCLK, MISO)
- GPIO 21: Onboard status LED
- GPIO 33–37: Module PSRAM (unavailable)

#### Important Notes
- ⚠️ **WiFi MUST be configured first** (Step 1) before connecting Ethernet cable
- ⚠️ **Ethernet disables WiFi** — this is firmware behavior on this board, not a defect
- ✅ Access web interface via **Ethernet IP only** when cable is connected
- ✅ **Use Ethernet for E1.31/Art-Net/DDP** — low-latency, deterministic streaming (recommended over WiFi)
- ✅ Unplug Ethernet cable to re-enable WiFi (e.g., for wireless troubleshooting)

## ⚙️ WLED Features

This board runs **WLED** — open-source LED controller firmware. Key features:

- **8 independent LED outputs** (this board: GPIO 0–3, 15–18)
- WS2812FX library with 100+ special effects  
- FastLED noise effects and 50 palettes  
- Modern web UI with color, effect, and segment controls  
- Segments to set different effects/colors to user-defined LED ranges  
- Up to 250 user presets with automatic playback cycling  
- Presets can trigger API calls  
- Full network configuration via settings page  
- Access Point (AP) and Station mode with automatic failsafe AP  
- Support for RGBW and other LED strip types
- Nightlight function (gradual dimming)  
- Full OTA firmware updates (HTTP + ArduinoOTA), password-protectable  
- Configurable auto-brightness limiting for safe operation  
- Filesystem-based config backup/restore  

## 💡 Supported light control interfaces
- WLED app for [Android](https://play.google.com/store/apps/details?id=com.aircoookie.WLED) and [iOS](https://apps.apple.com/us/app/wled/id1475695033)
- JSON and HTTP request APIs  
- MQTT   
- E1.31, Art-Net, DDP and TPM2.net
- [diyHue](https://github.com/diyhue/diyHue) (Wled is supported by diyHue, including Hue Sync Entertainment under udp. Thanks to [Gregory Mallios](https://github.com/gmallios))
- [Hyperion](https://github.com/hyperion-project/hyperion.ng)
- UDP realtime  
- Alexa voice control (including dimming and color)  
- Sync to Philips hue lights  
- Adalight (PC ambilight via serial) and TPM2  
- Sync color of multiple WLED devices (UDP notifier)  
- Infrared remotes (24-key RGB, receiver required)  
- Simple timers/schedules (time from NTP, timezones/DST supported)  

## 📲 WLED Documentation

For complete WLED documentation, features, and tutorials:
- **WLED Knowledge Base**: https://kno.wled.ge
- **WLED Project Site**: https://wled.me
- **Tutorials & Guides**: https://kno.wled.ge/basics/tutorials/

## 🤝 Community & Support

**WLED Project:**
- Licensed under the EUPL v1.2 license  
- [Project Credits](https://kno.wled.ge/about/contributors/)
- [Discord Community](https://discord.gg/QAh7wJHrRM)
- [Forum](https://wled.discourse.group)

Check out the WLED [Discourse forum](https://wled.discourse.group)!  

You can also send me mails to [dev.aircoookie@gmail.com](mailto:dev.aircoookie@gmail.com), but please, only do so if you want to talk to me privately.  

If WLED really brightens up your day, you can [![](https://img.shields.io/badge/send%20me%20a%20small%20gift-paypal-blue.svg?style=flat-square)](https://paypal.me/aircoookie)


*Disclaimer:*   

If you are prone to photosensitive epilepsy, we recommended you do **not** use this software.  
If you still want to try, don't use strobe, lighting or noise modes or high effect speed settings.

As per the EUPL license, I assume no liability for any damage to you or any other person or equipment.  
