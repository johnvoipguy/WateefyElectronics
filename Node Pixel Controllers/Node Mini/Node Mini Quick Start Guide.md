# NODE Mini — Quick Start Guide

*Node Mini, V1b*

Welcome to your NODE Mini! This guide gets you from box to lit-up pixels in about 10 minutes. For full specs, jumper options, and troubleshooting, see the **NODE Mini Full Guide**.

## What you'll need

- NODE Mini board
- Seeed XIAO ESP32-S3 — unless you bought the kit
- TI level shifter, SN74AHCT541N or SN74AHCT245N — unless you bought the kit
- Terminal blocks: 3-pin, 5.08mm, Phoenix-style PCB screw terminal — unless you bought the kit
- Fuses: 30A standard blade (main input), 7.5A standard blade (per-channel output) — unless you bought the kit
- 5–48 VDC power supply sized for your pixel run
- WS281x/SK6812/TM1814-style addressable LED strips or fixtures
- Small Phillips or flathead screwdriver

![Node Mini full board overview](images/mini_board_overview.png)

## Safety first — read this before wiring anything

- **This board is not automotive-qualified.** It's designed for residential and light-commercial installs — not vehicles, not industrial equipment.
- **Never connect or disconnect wiring with power applied.** Turn off and unplug your power supply first.
- **Watch your polarity on the input terminal.** It's best practice to always double-check Vin and GND before powering up. The board has an ideal-diode circuit to protect against damage from a reversed input, and a Polarity LED that shows green (correct) or red (reversed) so you know at a glance.
- **Match your fuses to your load.** Don't upsize fuses beyond what's printed on the silkscreen — the board's rated limits are there for a reason.
- **Don't confuse the DMX jack with an Ethernet/network jack.** It's RJ45-shaped, but it's DMX/RS-485 only — never plug it into a switch, router, or any network cable. DMX gear only.

## Step 1 — Wire your power input

Find the terminal block marked **"5-48VDC Input."**

- ![Input Terminal Vin/GND labels](images/input_term_image1.png)
- Before inserting any wire, back the terminal screws out enough that the clamp gate fully opens — if you try to force a wire into a closed gate you'll damage the terminal.
- Insert your power supply's positive lead into the left (Vin) opening and the negative lead into the right (GND) opening, then tighten each screw down to clamp the wire firmly.
- Do not power up yet.

![Input Terminal with wires inserted](images/input_term_image2.png)

## Step 2 — Mount your MCU

The XIAO ESP32-S3 seats into the two 7-pin sockets in the middle top of the board. It's field-replaceable — no soldering required. Line up the USB-C connector with the "USB / Antenna" silkscreen marking and press it firmly into both socket rows.

*Board came complete? The MCU and level shifter are already installed — skip this step.*

![XIAO ESP32-S3 seated in sockets](images/mcu_socket_image1.png)

## Step 3 — Wire your LED outputs

Each of the 8 output channels has its own 3-pole connector (V+ / DATA / GND) near the edge of the board. Connect your pixel strip or fixture's power, data, and ground leads to the channel you want to use. Each channel is individually fused — a fault on one channel won't take down the others.

![Output connector with wires landed](images/output_connector_image1.png)

## Step 4 — Power up and check the indicator LEDs

Apply power. You should see, in order:

| Silkscreen label | What it tells you |
|---|---|
| **Polarity** (green) | Input polarity is correct. If this glows **red** instead, power off immediately and check your input wiring — you have it backwards. |
| **Fuse OK** | The main input fuse is intact and the distribution bus is live. If this is dark, check the main fuse. |
| **5V OK** | The onboard 5V logic regulator is up and running, powering your MCU and buffers. |

If all three are lit correctly (green Polarity, Fuse OK, 5V OK), your board is alive and ready to be configured over USB/WiFi through your MCU firmware of choice (WLED, etc.).

![Polarity/Fuse OK/5V OK LED cluster](images/led_indicator_image1.png)

## Jumper Reference (J1–J4)

| Jumper | Function |
|---|---|
| J1 | Enables SN74AHCT245N level shifter |
| J2 | Enables Fuse Status |
| J3 | Enables ADC voltage monitoring |
| J4 | Enables DMX TX |

## Optional — DMX/RS-485 output

Node Mini includes a 4-port DMX output block, labeled near the RJ45-style jacks. If you're not using DMX, you can ignore this section entirely.

- Only **port 1** supports DMX receive (RX) — the other three ports are transmit-only.
- Look for the silkscreen markings **"RDM DMX"**, **"EN / DMX TX"**, and **"RX"** near the DMX jacks to identify the ports.
- **For DMX (TX):** place the jumper on **J4**.
- **For RDM:** leave **J4** unjumpered — instead, connect jumper wires from **GPIO7** and **GPIO8** to either **EN** or **RX**, depending on your WLED configuration.

![DMX jack block](images/dmx_jack_image1.png)

## Optional — Sensor/expansion header (I²C)

Node Mini has an onboard ADS1115 (voltage monitor) and MCP23008 (I/O expander) on their own internal I²C bus, broken out to a small header marked **"SCL ADS/MCP"** / **"SDA ADS/MCP"**. This header does double duty — use it to enable ADS/MCP readings (fuse status, Vin, and 5V readings), or to tap in additional I²C sensors, depending on your project.

![SCL/SDA ADS/MCP header](images/i2c_header_image1.png)

## Something not working?

See the **Troubleshooting** section of the full NODE Mini Guide, or reach out through the support link printed on the board silkscreen. *(Placeholder — insert support URL/QR destination here.)*
