# NODE Backbone — Quick Start Guide
 
*Node Backbone, V1b*
 
Welcome to your NODE Backbone! Backbone is the PoE/Ethernet variant — your controller is powered and network-reachable straight off your Ethernet switch, separate from your pixel power supply. DMX, ADС/fuse-status monitoring, and the STEMMA QT I²C port are all hardwired for you — no jumpering required. This guide gets you from box to lit-up pixels. For full specs and troubleshooting, see the **NODE Backbone Full Guide**.
 
## What you'll need
 
- NODE Backbone board
- Waveshare ESP32-S3-ETH-POE module — unless you bought the kit
- TI level shifter, SN74AHCT541N or SN74AHCT245N — unless you bought the kit
- Terminal blocks: 3-pin, 5.08mm, Phoenix-style PCB screw terminal — unless you bought the kit
- Fuses: 30A standard blade (main input), 7.5A standard blade (per-channel output) — unless you bought the kit
- 5–48 VDC power supply sized for your pixel run (this powers your **pixels only** — see Step 3 for the controller's own power)
- **Required:** an IEEE 802.3af-compliant Power over Ethernet (PoE) network switch or power injector, plus an Ethernet cable — this is the only way to power the controller (see Step 3)
- WS281x/SK6812/TM1814-style addressable LED strips or fixtures
- Small Phillips or flathead screwdriver
No jumper wires needed on this board — DMX, the fuse-status/voltage monitor, and the STEMMA QT port are all hardwired.
 
![Node Backbone full board overview](images/backbone_board_overview.png)
 
## Safety first — read this before wiring anything
 
- **This board is not automotive-qualified.** It's designed for residential and light-commercial installs — not vehicles, not industrial equipment.
- **Never connect or disconnect wiring with power applied.** Turn off and unplug your power supply first.
- **Watch your polarity on the input terminal.** It's best practice to always double-check Vin and GND before powering up. The board has an ideal-diode circuit to protect against damage from a reversed input, and a Polarity LED that shows green (correct) or red (reversed) so you know at a glance.
- **Match your fuses to your load.** Don't upsize fuses beyond what's printed on the silkscreen — the board's rated limits are there for a reason.
- **Don't confuse the DMX jack with the Ethernet/PoE jack.** The DMX port is RJ45-shaped but carries DMX/RS-485 signaling, not Ethernet — never plug it into a network switch, PoE injector, or a cable meant for your Ethernet connection. DMX gear only.
- **An unpowered Ethernet drop means an unpowered controller.** There's no fallback power path on this board — if your Ethernet/PoE connection drops, the controller goes down even if your pixel supply is still on.
- **This board must be powered by an IEEE 802.3af-compliant PoE switch or injector.** There is no other way to power the controller — the pixel input terminal (Step 1) does not power it.
## Step 1 — Wire your power input
 
Find the terminal block marked **"5-48VDC Input."** This feeds your LED pixels — it does not power the controller itself (that's Step 3).
 
- ![Input Terminal Vin/GND labels](images/input_term_image1.png)
- Before inserting any wire, back the terminal screws out enough that the clamp gate fully opens — if you try to force a wire into a closed gate you'll damage the terminal.
- Insert your power supply's positive lead into the Vin opening and the negative lead into the GND opening, then tighten each screw down to clamp the wire firmly.
- Do not power up yet.
![Input Terminal with wires inserted](images/input_term_image2.png)
 
## Step 2 — Mount your MCU
 
The Waveshare ESP32-S3-ETH-POE module seats into its socket. It's field-replaceable — no soldering required.
 
*Board came complete? The MCU and level shifter are already installed — skip this step.*
 
![Waveshare ESP32-S3-ETH-POE seated in socket](images/backbone_mcu_socket_image1.png)
 
## Step 3 — Connect Ethernet / PoE
 
**This board MUST be powered by PoE — there is no other way to power the controller.** Plug an Ethernet cable from a PoE-capable switch (802.3af), or from a regular switch plus a PoE injector, into the **ETH** jack.
 
- The controller boots and becomes network-reachable from this connection alone — your pixel supply from Step 1 doesn't need to be powered for this to work.
- How many Backbone nodes your switch can power is limited by your switch's total PoE power budget — that's on you to check against your switch's specs, not something the board limits.
![Ethernet/PoE jack](images/backbone_eth_jack_image1.png)
 
## Step 4 — Wire your LED outputs
 
Each of the 8 output channels has its own 3-pole connector (V+ / DATA / GND) near the edge of the board. Connect your pixel strip or fixture's power, data, and ground leads to the channel you want to use. Each channel is individually fused — a fault on one channel won't take down the others.
 
![Output connector with wires landed](images/output_connector_image1.png)
 
## Step 5 — Power up and check the indicator LEDs
 
With your pixel supply and Ethernet/PoE both connected, you should see:
 
| Silkscreen label | What it tells you |
|---|---|
| **Polarity** (green) | Input polarity is correct. If this glows **red** instead, power off immediately and check your input wiring — you have it backwards. |
| **Fuse OK** | The main input fuse is intact and the distribution bus is live. If this is dark, check the main fuse. |
| **3.3V OK** | The module's logic rail is up — this only lights once Ethernet/PoE is connected and supplying power (see Step 3). |
 
If all three are lit correctly (green Polarity, Fuse OK, 3.3V OK), your board is alive and ready to be configured over the network through your MCU firmware of choice (WLED, etc.).
 
![Polarity/Fuse OK/3.3V OK LED cluster](images/backbone_led_indicator_image1.png)
 
## Fixed Pin Reference (for firmware configuration)
 
Nothing here needs jumpering — these functions are hardwired to the Waveshare module. You still need to enter the right GPIO numbers in your firmware (WLED, etc.) to use them.
 
| Function | GPIO |
|---|---|
| DMX EN | GPIO46 |
| DMX TX | GPIO45 |
| DMX RX | GPIO42 |
| ADC/MCP SDA | GPIO48 |
| ADC/MCP SCL | GPIO47 |
| STEMMA QT SDA | GPIO39 |
| STEMMA QT SCL | GPIO38 |
 
## Optional — DMX/RS-485 output
 
Node Backbone's DMX is hardwired — just plug your DMX cable into the RJ45-style jack labeled for DMX and set your DMX GPIOs (above) in your firmware. If you're not using DMX, you can ignore this section entirely.
 
**Reminder:** this jack is DMX only — don't confuse it with the Ethernet/PoE jack (see Safety, above).
 
![DMX jack](images/backbone_dmx_jack_image1.png)
 
## Optional — Sensor/expansion (I²C)
 
Backbone gives you two ready-to-use I²C access points, both hardwired — no jumpering:
 
- **Onboard ADS1115 (voltage monitor) + MCP23008 (I/O expander):** already wired to the module at the GPIOs listed above — fuse status, Vin, and 5V readings are available as soon as your firmware is configured for them.
- **STEMMA QT / Qwiic connector:** a plug-and-play 4-pin port (3.3V / GND / SDA / SCL) for external I²C sensors — no soldering, no jumper wires, just plug in a STEMMA QT cable.
![STEMMA QT/Qwiic connector](images/backbone_stemma_image1.png)
 
## Something not working?
 
See the **Troubleshooting** section of the full NODE Backbone Guide, or reach out through the support link printed on the board silkscreen. [Click here to report Issues:](https://github.com/johnvoipguy/WateefyElectronics/issues)
