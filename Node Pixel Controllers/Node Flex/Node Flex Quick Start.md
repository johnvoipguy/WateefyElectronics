# NODE Flex — Quick Start Guide

*Node Flex, V1b*

Welcome to your NODE Flex! Flex is the "universal" board in the family — it accepts almost any ESP32 DevKit-style module, and you map its GPIOs to pixel/DMX/I²C functions yourself with jumper wires. This guide gets you from box to lit-up pixels. For full specs and troubleshooting, see the **NODE Flex Full Guide**.

## What you'll need

- NODE Flex board
- An ESP32 DevKit module — **always customer-supplied**, kit or board-only (Flex has no fixed MCU; you seat whatever module you own). Needs 0.9″ or 1.0″ row spacing, 2.54mm pitch. Known-good drop-in Ethernet options: WT32-ETH01, WT32-ETH01-EVO, WT32-ETH02-PLUS.
- TI level shifter, SN74AHCT541N or SN74AHCT245N — unless you bought the kit
- Terminal blocks: 3-pin, 5.08mm, Phoenix-style PCB screw terminal — unless you bought the kit
- Fuses: 30A standard blade (main input), 7.5A standard blade (per-channel output) — unless you bought the kit
- 5–48 VDC power supply sized for your pixel run
- WS281x/SK6812/TM1814-style addressable LED strips or fixtures
- Small Phillips or flathead screwdriver
- Jumper wires — 10cm (4") female-to-female multicolored Dupont/breadboard jumper ribbon cables (longer works too, but 10cm covers every pin-to-pin jump on this board) — for mapping your DevKit's GPIOs to channels (see Step 2)

![Node Flex full board overview](images/Node_Flex_headers.png)

## Safety first — read this before wiring anything

- **This board is not automotive-qualified.** It's designed for residential and light-commercial installs — not vehicles, not industrial equipment.
- **Never connect or disconnect wiring with power applied.** Turn off and unplug your power supply first.
- **Watch your polarity on the input terminal.** It's best practice to always double-check Vin and GND before powering up. The board has an ideal-diode circuit to protect against damage from a reversed input, and a Polarity LED that shows green (correct) or red (reversed) so you know at a glance.
- **Match your fuses to your load.** Don't upsize fuses beyond what's printed on the silkscreen — the board's rated limits are there for a reason.
- **Don't confuse the DMX jack with an Ethernet/network jack.** It's RJ45-shaped, but it's DMX/RS-485 only — never plug it into a switch, router, or any network cable. DMX gear only.

## Step 1 — Wire your power input

Find the terminal block marked **"5-48VDC Input."**

- ![Input Terminal Vin/GND labels](images/Input_Terminal_Front.png)
- Before inserting any wire, back the terminal screws out enough that the clamp gate fully opens — if you try to force a wire into a closed gate you'll damage the terminal.
- Insert your power supply's positive lead into the Vin opening and the negative lead into the GND opening, then tighten each screw down to clamp the wire firmly.
- Do not power up yet.

![Input Terminal with wires inserted](images/Input_Terminal_Front_arrows.png)

## Step 2 — Seat your DevKit and map GPIOs to channels

This is the step unique to Flex — there's no fixed MCU, so you decide which of your module's GPIOs drive which pixel channel.

- Seat your ESP32 DevKit into the header rows matching its pin spacing (0.9″ or 1.0″).
- In your DevKit firmware (WLED, etc.), assign the GPIOs you want to use as pixel data outputs.
- For each channel you want to use, connect a jumper wire from your board's pin for that configured GPIO to the matching **LS0–LS7** pin on the **Level Shifter Pinout** header.
- Unused channels don't need a jumper — pull-down resistors hold them at a known logic low automatically, so nothing floats.
- **Before you finalize your GPIO choices:** check your specific module's datasheet to confirm none of the GPIOs you're assigning are boot-strapping, flash, or PSRAM pins — this varies by module and isn't something the board can protect you from.

![DevKit seated in header rows](images/flex_devkit_seated_image1.png)

![Level Shifter Pinout header with jumper wires](images/flex_ls_jumpers_image1.png)

## Step 2b — Power your DevKit

Your DevKit still needs its own power feed from the board.

- Wire the board's **+5Vout** pin to your DevKit's **VBUS** pin.
- Wire a **GND** pin to your DevKit's **GND** pin.

## Step 3 — Wire your LED outputs

Each of the 8 output channels has its own 3-pole connector (V+ / DATA / GND) near the edge of the board. Connect your pixel strip or fixture's power, data, and ground leads to the channel whose LS pin you jumpered in Step 2. Each channel is individually fused — a fault on one channel won't take down the others.

![Output connector with wires landed](images/output_connector_image1.png)

## Step 4 — Power up and check the indicator LEDs

Apply power. You should see, in order:

| Silkscreen label | What it tells you |
|---|---|
| **Polarity** (green) | Input polarity is correct. If this glows **red** instead, power off immediately and check your input wiring — you have it backwards. |
| **Fuse OK** | The main input fuse is intact and the distribution bus is live. If this is dark, check the main fuse. |
| **+5V OK** | The onboard 5V logic regulator is up and running, powering your DevKit and buffers. |

If all three are lit correctly (green Polarity, Fuse OK, +5V OK), your board is alive and ready to be configured over USB/WiFi through your DevKit's firmware.

![Polarity/Fuse OK/+5V OK LED cluster](images/flex_led_indicator_image1.png)

## Jumper Reference

Flex doesn't use shorting-block jumpers like Mini's J1–J4 — every function is wired with point-to-point jumper wires between your DevKit's configured GPIO pins and the labeled header pins.

| Function | How to configure |
|---|---|
| Pixel output channels (LS0–LS7) | Jumper wire from your DevKit's configured GPIO pin to the LSx pin for that channel |
| DMX TX only | Jumper your DevKit's **3.3V/VCC** to the **TX only** block's **3.3v** pin, and your DevKit's configured DMX TX GPIO to the **TX only** block's **TX** pin |
| **Required: DMX needs 3.3V** | Jumper your DevKit's **3.3V/VCC** to the DMX block's **3.3v** pin — without this, DMX TX won't work, jumpered GPIOs alone aren't enough |
| DMX RX / TX / EN (RDM) | Jumper wires from your configured RX, TX, and EN GPIOs to the matching RX/TX/EN pins |
| Onboard ADS/MCP readings (fuse status, Vin, 5V) | Jumper wires from your configured SCL/SDA GPIOs to the **SCL OUT** / **SDA OUT** pins, plus jumpers to **3.3V** as needed |
| **Required: MCP/ADS needs 3.3V** | Jumper your DevKit's **3.3V/VCC** to the MCP/ADS header's **3.3V** pin — without this, onboard ADS/MCP readings won't work, jumpered GPIOs alone aren't enough |
| External I²C sensors (skips onboard ADS/MCP) | Jumper wires straight from your DevKit's own male header pins to your sensor |

## Optional — DMX/RS-485 output

Node Flex includes a DMX output block, labeled **"RDM/TX"** near the RJ45-style jack. If you're not using DMX, you can ignore this section entirely.

- **For DMX TX only:** jumper your DevKit's **3.3V/VCC** to the **TX only** block's **3.3v** pin, and your DevKit's configured DMX TX GPIO to the **TX only** block's **TX** pin.
- **For RDM:** jumper wires from your configured RX, TX, and EN GPIOs to the corresponding **RX** / **TX** / **EN** pins.

![DMX jack block](images/flex_dmx_jack_image1.png)

## Optional — Sensor/expansion header (I²C)

Node Flex has an onboard ADS1115 (voltage monitor) and MCP23008 (I/O expander), broken out to a header marked **"SCL OUT"** / **"SDA OUT"** / **"MCP/ADS."** This header is dedicated to enabling those onboard readings (fuse status, Vin, and 5V) — jumper your WLED-configured SCL/SDA GPIOs (plus 3.3V as needed) to it if you want that feature.

If you'd rather run your own external I²C sensors instead, don't use this header — jumper straight from your DevKit's own male header pins to your sensor.

![MCP/ADS header](images/flex_mcp_ads_header_image1.png)

## Something not working?

See the **Troubleshooting** section of the full NODE Flex Guide, or reach out through the support link printed on the board silkscreen. [Click here to report Issues:](https://github.com/johnvoipguy/WateefyElectronics/issues)
