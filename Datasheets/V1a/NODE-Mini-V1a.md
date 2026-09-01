# NODE Mini
### 8-Channel Addressable LED Controller · Mini Node

*Wateefy Electronics*

---

> **The smallest node in the network. None of the compromises.**

*[Hero image: populated NODE Mini board, three-quarter view]*

---

## At a Glance


- **8 independent output channels** — WS281x / SK6812 / TM1814 family, 5 V level-shifted drive
- **5–48 VDC input, no jumpers** — **36 V nominal, 48 V maximum**; runs 5/12/24/36/48 V systems with nothing to set wrong
- **30 A through the board at standard copper** — not a paid upgrade
- **Three isolated power domains** — dirty input, clean protected power, fused distribution bus
- **A fuse on every single output** — eight channels, eight fuses, no sharing
- **Non-destructive reverse-polarity protection** — nothing is consumed when someone wires it backwards
- **Runs WLED out of the box** — no custom firmware, no vendor lock-in

**123 × 119 mm** · 4-layer · ENIG · conformal coated

---

## Why This Exists


Cheap pixel controllers die in predictable ways. A shovel shorts a run and takes the whole board with it. Somebody wires a supply backwards for two seconds. A strip gets hot-plugged and the inductive kick walks through the regulator. None of these are exotic — they are Tuesday in a real installation, and most boards have nothing standing in the path to stop any of them.

NODE Mini was built by someone who got tired of that. Every failure mode above has a specific part in front of it, chosen from a datasheet and verified against the copper. The result costs more than the cheap controller and survives the season that kills it.

---

## The Architecture: Three Power Domains


This is the part that matters, and it is the part nobody else builds.

Most controllers have one power rail. Input voltage lands on a terminal and it is the same copper that reaches your strips. Whatever arrives — spike, reverse polarity, sag, transient — arrives everywhere at once.

**NODE splits power into three separate domains on their own copper planes:**

**1 · Dirty power in.** The input terminal accepts whatever the supply, the wiring, and the person doing the wiring hand it. This domain is assumed hostile. It is isolated to the smallest region of the board possible and nothing downstream touches it directly.

**2 · Clean power.** Between dirty and clean sits the protection stage: bidirectional transient clamping and an *active* reverse-polarity blocker. Reverse the supply and the pass element simply never turns on — no current path exists to the rest of the board, nothing is sacrificed, and the red polarity indicator tells you why. Correct the wiring and it comes back on its own.

**3 · The protected bus.** Clean power passes the main fuse to become the distribution bus. Every one of the eight output channels taps this bus through its own individual fuse. A fault on run six opens one fuse. Runs one through five and seven through eight never notice.

> ### BEEFCAKE.
> *The pass element is a 205 A MOSFET on a 30 A board. It will never be the thing that fails.*

**Decoupling where the current actually is.** Two thousand microfarads of bulk sits on the protected bus, and another forty-seven at *every single output connector*. The distribution is the point: one reservoir at the input cannot cover the harness inductance of eight separate output runs no matter how large it is. When a full-white frame lands on all eight channels at once, each channel draws from its own reserve sitting centimetres from its terminal.

Four levels of protection between the screw terminal and your pixels — clamp, active block, main fuse, channel fuse — each on its own copper. That is why this board is four layers with a split inner power plane instead of two layers with one pour.

**Nothing in that power path is rated below 63 V — and every semiconductor in it is 60 V or above — against a 48 V maximum input.** Nothing in the chain runs near its limit.

**At maximum rated input, no component in the power path operates above 72% of its rating.** The pass MOSFET sits at 60%, the ideal-diode controller at 55%, the regulator at 45%. It is not a number anyone else in this class publishes, and it is the reason to believe the rest of this page.

---

## What Else You Actually Get


**Data lines treated like data lines.** Each output runs through a series resistor and a sub-picofarad ESD device placed on the *connector* side, where transients actually arrive. The low-capacitance part was chosen deliberately: a fat protection diode on a data line rounds off WS281x bit timing and produces a controller that works on the bench and sparkles on a 40-foot run. This one does not.

**Serviceable by design.** The level shifter sits in a DIP socket. The MCU module sits in headers. Fuses pull by hand. Through-hole parts dominate the power section on purpose — this board is meant to be repaired in a garage, not scrapped.

**Three things on this board can be killed by field abuse. All three pull out by hand.**

**The fuse.** A mini blade — the same part sold in a variety pack at every gas station, auto parts counter and big-box store in the country. Pulls with fingers, costs pennies. Not a cartridge you order online and wait for.

**The buffer.** A jellybean octal logic IC in a DIP socket. It sits directly behind your wiring, which makes it the part most likely to die and the part most annoying to replace anywhere else. Here it lifts out with a fingernail. And the socket accepts **either a '541 or a '245** — the strap that sets pin 1 handles the 541's active-low output enable and the 245's direction pin, so you fit whichever is in stock. Supply-chain resilience on a fifty-cent line item sounds trivial right up until the next shortage.

**The MCU.** A socketed module. Blow it up, seat another. No hot air, no braid, no scrap board.

Nobody else in this class can claim all three.

**And that is what the board area buys.** Blade holders, a DIP socket, and terminal clearance cost real estate — there is room to get an iron in, room to pull a fuse without tweezers, room to reach the reset button without unmounting anything, and room at the terminals for heavy wire with ferrules. Compact is easy. Compact *and* serviceable at 30 A is a different problem, and this is the side of it we chose. A channel that dies at eight o'clock on the twenty-third of December should be a fifteen-minute drive, not a three-day wait.

**Wide input, honestly rated.** The logic supply is built on a wide-input synchronous regulator rated far above anything the input can present. The silk says 5–48 VDC because that is what the protection chain survives, not what it survives on a good day. There is no voltage-select jumper because there is nothing to select.

---

## Where It Goes


- **Permanent architectural and holiday installations** — outdoor, seasonal, thermally cycled, occasionally abused
- **Distributed whole-property displays** — one node per zone, eight runs each, scaling by adding nodes rather than lengthening runs
- **Anywhere a service call costs more than the controller** — per-channel fusing turns a callback into a fuse swap

---

## How It Compares


**Comparison basis.** The closest peer is the Bong69 8 Port LED Distro — same idea, power and data integrated on one board, eight ports, WLED, sold at maker scale. QuinLED's Dig-Quad is the other reference point; their eight-output answer is the Dig-Octa *system*, a brain board plus stacked power distribution boards. Competitor figures are taken from the vendors' own published FAQ and specification pages as of July 2026 and should be re-verified before publication.

*Athom's WLED range is deliberately excluded: single-strip and PWM controllers aimed at room-level and audio-reactive use. Different product, different buyer.*

| | **NODE Mini** | Bong69 8 Port LED Distro | QuinLED-Dig-Quad v3 |
|---|---|---|---|
| Output channels | 8 | 8 | 4 |
| Power + data on one board | Yes | Yes | Yes |
| **Input range, one SKU** | **5–48 VDC** | V4: 12–48 V (**5 V support dropped**) · V3: 5–24 V (**discontinued**) | 5–24 VDC |
| Covers 5/12/24/36/48 V pixels | Yes, one board | 12–48 V only — 5 V support dropped in V4 | Jumper-selectable up to 24 V; 36 V and 48 V not supported |
| Input voltage selection | None — nothing to set wrong | Per board version | Jumper; vendor warns wrong setting *"will fry the onboard components"* |
| Input connector | Enclosed 57 A screw terminal | V4: spade connectors on a stud | Screw terminal |
| Continuous current, standard copper | 30 A | Not published | 15 A at 1 oz (30 A only with paid 2 oz upgrade) |
| Per-channel fuse rating | 7.5 A nominal · 10 A max per output | 5 A (V4) · 4 A hold / 8 A trip polyfuse (V3) | 10 A max recommended |
| Fuses on outputs | 8 — one per channel | 8 — one per channel | 5 fuses across 7 outputs (channels share) |
| Reverse-polarity protection | Active blocking — non-destructive, self-recovering | Not published | Parallel diode with fuse — sacrificial |
| Input transient clamp | Bidirectional TVS across the input | Not published | Not published |
| Data-line ESD protection | Per channel, sub-pF device | Series resistor only (33 Ω) | Not published |
| Power domain separation | 3 domains: dirty in / clean / fused bus | Not published | Single rail |
| Level shifter | 8-channel, socketed DIP | Not published | 4-channel, soldered |
| Conformal coating | Yes | Not offered | Not offered |
| Fuse-status indicator | Channel activity LED | **Blue "good fuse" LED per channel** | Per board |
| Onboard USB programming | Via the module's own port | Onboard USB-C — required, the ESP is soldered down | Via the module's own port |
| **Field-replaceable MCU** | **Yes — socketed module** | **No — ESP32-WROOM soldered to the board** | Yes — socketed module |
| Fuse replacement | Mini blade — auto parts store, gas station, variety pack | Cartridge in a surface-mount holder — order online | ATO blade — auto parts store |
| Audio-reactive / mic support | DIY — I²C/SPI headers fitted; trades LED outputs on the XIAO | DIY — wire an INMP441 to the H1 header (documented) | **Analog audio input broken out** |
| Temperature sensor support | DIY — headers fitted; trades an LED output on the XIAO | DIY — add header, DS18B20 and 4.7 kΩ (documented) | **Optional onboard footprint** |
| Enclosure | *Coming soon* | None — 3D-print mounts published | None — bare board |
| Board size | 123 × 119 mm — *the cost of blade holders, a DIP socket and terminal clearance* | ~110 × 70 mm | ~100 × 50 mm |
| Firmware | WLED / ESPHome / ESPixelStick — module-level, not board-level | Same | Same |
| Firmware image | Pre-built image supplied | Pre-built image supplied; ESPixelStick needs the vendor hardware profile | Stock WLED builds |
| Ecosystem | New | **Established, reviewed, xLights docs** | **Large, mature, well documented** |

**A note on firmware comparisons.** WLED, ESPHome, and ESPixelStick are properties of the ESP32 silicon, not of the carrier board — any of them will run on any of these products. What actually differs is which pre-built image ships, and how much GPIO the board's own hardware has already spent before your channels get any.

**Where the others are the better choice, plainly.** Bong69 ships a proven, well-reviewed board with onboard USB-C programming, per-fuse status LEDs, documented audio-reactive and temperature-sensor support, xLights integration notes, published 3D-print mounts, and boards that arrive pre-configured and tested. QuinLED brings a deep peripheral breakout and years of community documentation. Neither of those ecosystems exists here yet. If you want established products, buy theirs.

**Where NODE is the better choice.** One board covers 5/12/24/36/48 V pixels with every part in the power path rated at least 1.3× the maximum input — no version to pick, no jumper to set wrong, and no discontinued SKU to hunt for when your next run uses different strips. An enclosed 57 A screw terminal instead of exposed spade lugs. Reverse polarity that costs nothing when it happens instead of nothing at all standing in the way. A clamp on the input, an ESD device on every data line, and four levels of protection on separate copper between the terminal and your pixels.

**The honest summary:** they built a lighting controller. This is a lighting controller built like industrial equipment — which is worth paying for exactly when the board is somewhere inconvenient and the failure is expensive, and is not worth paying for when it sits on a bench next to you.

---

## Ordering


| Item | Detail |
|---|---|
| Model | NODE Mini (V1a) |
| Configuration | Assembled, tested, conformal coated |
| Included | Controller board, level shifter installed, fuses installed |
| Not included | **Enclosure**, XIAO ESP32-S3 module, 3-pin plug connectors, blade fuses beyond those fitted, power supply |
| Availability | **Not currently offered for sale.** The present build is a validation run — first-article hardware for bring-up, characterisation and field trial. |
| Sale status | Planned for the next revision |
| Price | *TBD* |
| Lead time | *TBD* |
| Warranty | *TBD* |

---
---

# NODE Mini V1a — Technical Specification

**Document rev:** 2.1 · **Board rev:** V1a · **Date:** 2026-08-06

---

---
---

# NODE Mini V1a — Variant Specification

**Document rev:** 3.0 · **Board rev:** V1a · **Date:** 2026-08-06

*Power architecture, input protection, outputs, environmental and build data are common to the NODE family and are documented in the **NODE Platform Hardware Reference**. This supplement covers only what is specific to NODE Mini.*

---

## 1. 5 V Logic Rail


| Parameter | Value | Notes |
|---|---|---|
| Regulator | LMR38020SDDAR synchronous buck | HSOIC-8 with PowerPAD, 12 thermal vias |
| Absolute maximum input | 85 V | 68% utilization at worst-case TVS clamp |
| Switching frequency | 400 kHz | Set by 64.9 kΩ RT resistor |
| Output voltage | 5.115 V | 100 kΩ / 24.3 kΩ divider, 1.0 V reference |
| Output current capability | 2 A | Actual load ≈ 0.5 A → 25% utilization |
| Inductor | 15 µH, 3.0 A saturation, 2.5 A RMS | 79% of saturation rating at full 2 A load |
| Output capacitance | 3 × 22 µF ceramic, 16 V | Per regulator datasheet recommendation |
| Module bulk capacitance | 100 µF, 25 V | Local reserve for Wi-Fi transmit transients |
| Rail bypass | 100 nF ceramic, 50 V | Behind regulation — HV plane rating does not apply |
| Input capacitance | 47 µF electrolytic 80 V + 4.7 µF + 100 nF, ceramics 100 V X7R | Rated for the full input range with derating headroom |
| 5 V rail clamp | SMAJ6.0A TVS | 6 V standoff vs 5.24 V worst-case rail = 87% |
| Minimum on-time margin | 2.0× at 48 V input | No frequency foldback anywhere in the input range |
| Manual reset | Momentary switch to regulator enable | 10 kΩ pull-up to distribution bus |

## 2. MCU & Firmware


| Parameter | Value |
|---|---|
| Module | Seeed Studio XIAO ESP32-S3 (not included) |
| SoC | ESP32-S3R8 — dual-core Xtensa LX7 @ 240 MHz |
| Memory | 8 MB PSRAM |
| LED driver allocation | 4 hardware RMT TX channels; outputs 5–8 switch to parallel I2S automatically — no setting to change |
| Mounting | 2 × 7-pin sockets — removable without desoldering |
| Channel GPIO | GPIO01 – GPIO08 to buffer inputs |
| Additional I/O | Headers fitted for 2 × I²C and 2 × SPI plus 3.3 V / 5 V / GND / TX / RX. The XIAO has no spare GPIO, so peripheral pins trade against output channels — using both SPI buses means two fewer LED outputs |
| Firmware | WLED — pre-built image supplied, configured for this board's GPIO map |
| Supported LED protocols | WS2811, WS2812/B, WS2813, WS2815, WS2816, SK6812/RGBW, TM1814, and other single-wire families supported by WLED |
| Connectivity | Wi-Fi 2.4 GHz via module |
| Control protocols | Per WLED: E1.31/sACN, Art-Net, DDP, MQTT, HTTP/JSON API |

## 3. Physical


| Parameter | Value |
|---|---|
| PCB dimensions | 123 × 119 mm |
| PCB thickness | 1.6 mm |
| Layer count | 4 — signal / ground plane / split power plane / signal |
| Copper weight | 1 oz outer, 1 oz inner |
| Substrate | Nan Ya NP-155F, T<sub>g</sub> 155 °C |
| Surface finish | ENIG, 1 µ" gold |
| Via treatment | Epoxy filled and capped |
| Soldermask | Blue |
| Mounting | 4 × corner mounting holes, 3 mm |
| Mounting hole spacing | 107.9 × 103.8 mm |
| Enclosure | *Coming soon* — enclosures exist for the V0.1 prototype; being updated to the current board dimensions |
| Net weight | *TBD — measure at first article* |
| Conformal coating | Applied after assembly; connectors, sockets, fuse clips, and switches masked |

## 4. Deltas from the Platform Reference

| Item | This variant |
|---|---|
| Input rail | Single rail — powers both pixels and onboard logic |
| Logic supply | Onboard LMR38020 synchronous buck (see §1) |
| Power domains | Three, per the Platform Reference |

## 5. Design Notes & Accepted Limitations


Stated plainly rather than buried:

- **Not automotive qualified.** Protection targets transients credible in a residential or light-commercial installation. Not tested to ISO 7637 load-dump profiles; not intended for vehicle use.
- **Worst-case clamp coordination.** At the TVS datasheet maximum clamping voltage under a full 1500 W pulse, the voltage presented to the pass MOSFET and bulk capacitors exceeds their ratings. That condition requires a pulse energy source which does not exist in a mains-fed low-voltage installation, and is accepted as non-credible for the intended deployment. At realistic clamp currents the entire downstream chain retains margin.
- **Over-voltage beyond specification is not survivable.** A supply above the rated input range will conduct the input TVS and open the main fuse. This is sacrificial *by design* — the board is protected, the TVS and fuse are consumables.
- **Load capability.** The 5 V rail powers onboard logic and indicators only. Pixel power comes directly from the distribution bus; total system current is bounded by the 30 A main fuse and the user's supply.

---

*Wateefy Electronics · NODE Mini · Specifications subject to change.*
