<center><img src="../../images/Node_Flex.png" width="485" height="445"></center>

# NODE Flex
### 8-Channel Addressable LED Controller · Universal Module Carrier

*Wateefy Electronics*

---

> **One board. The Swiss Army knife of pixel controllers.**

*[Hero image: populated NODE Flex board with DevKit installed, three-quarter view]*

---

## At a Glance


- **8 independent output channels** — WS281x / SK6812 / TM1814 family, 5 V level-shifted drive
- **Any ESP32 DevKit on 0.9″ or 1.0″ row spacing** — both spacings on the board, up to 22 positions per row, jumper-mapped to the outputs
- **5–48 VDC input, no voltage jumper** — **36 V nominal, 48 V maximum**; nothing to set wrong, ever
- **30 A through the board at standard copper** — not a paid upgrade
- **Three isolated power domains** — dirty input, clean protected power, fused distribution bus
- **A fuse on every single output** — eight channels, eight fuses, no sharing
- **Non-destructive reverse-polarity protection** — nothing is consumed when someone wires it backwards

**123 × 138 mm** · 4-layer · ENIG · conformal coated

---

## Why This Exists


Every ESP32 DevKit has a different pinout. Every controller board is hard-wired to exactly one of them. So the board you bought last year is scrap when that module goes end-of-life, and the four dev boards in your parts drawer are useless because none of them match the footprint someone else chose.

NODE Flex breaks that dependency by defining compatibility as **geometry rather than a part number**. The board carries both of the common DevKit row spacings — 0.9 inch and 1.0 inch — with up to 22 positions in each row. Module length does not matter: a 2×15 or 2×19 board seats in the same sockets and simply leaves positions empty. A jumper field then decides which module pin drives which output channel.

The practical result is that the compatibility list cannot go stale. If a module lands on 0.9″ or 1.0″ centres, it fits — including modules that do not exist yet. When your favourite DevKit is discontinued, and it will be, you seat a different one and keep going. Same board, same protection, same firmware.

For anyone maintaining an installed base across mixed hardware, this is the SKU that ends the inventory problem.

---

## The Architecture: Three Power Domains


Flexibility lives in the MCU interface. Nothing upstream of it was softened to get there.

Most controllers have one power rail. Input voltage lands on a terminal and it is the same copper that reaches your strips. Whatever arrives — spike, reverse polarity, sag, transient — arrives everywhere at once.

**NODE splits power into three separate domains on their own copper planes:**

**1 · Dirty power in.** The input terminal accepts whatever the supply, the wiring, and the person doing the wiring hand it. This domain is assumed hostile, isolated to the smallest region of the board possible, and nothing downstream touches it directly.

**2 · Clean power.** Between dirty and clean sits the protection stage: bidirectional transient clamping and an *active* reverse-polarity blocker. Reverse the supply and the pass element never turns on — no current path to the rest of the board, nothing sacrificed, red indicator tells you why. Correct the wiring and it recovers on its own.

**3 · The protected bus.** Clean power passes the main fuse to become the distribution bus. Each of the eight output channels taps that bus through its own fuse. A fault on run six opens one fuse and the other seven never notice.

> ### BEEFCAKE.
> *The pass element is a 205 A MOSFET on a 30 A board. It will never be the thing that fails.*

**Decoupling where the current actually is.** Two thousand microfarads of bulk sits on the protected bus, and another forty-seven at *every single output connector*. The distribution is the point: one reservoir at the input cannot cover the harness inductance of eight separate output runs no matter how large it is. When a full-white frame lands on all eight channels at once, each channel draws from its own reserve sitting centimetres from its terminal.

Four levels between the screw terminal and your pixels — clamp, active block, main fuse, channel fuse — each on its own copper. That is why this is a four-layer board with a split inner power plane rather than two layers and one pour.

**Nothing in that power path is rated below 63 V — and every semiconductor in it is 60 V or above — against a 48 V maximum input.** Nothing in the chain runs near its limit.

**At maximum rated input, no component in the power path operates above 72% of its rating.** The pass MOSFET sits at 60%, the ideal-diode controller at 55%, the regulator at 45%. It is not a number anyone else in this class publishes, and it is the reason to believe the rest of this page.

---

## What Else You Actually Get


**Defined-state inputs.** Because a channel's jumper may legitimately be left unset, every buffer input carries a pull-down resistor. An unconfigured channel sits at a known logic low instead of floating and driving whatever it feels like — which on a strip full of pixels means darkness rather than noise. This is the detail that separates a real universal carrier from a breakout board with headers.

**Data lines treated like data lines.** Each output runs through a series resistor and a sub-picofarad ESD device placed on the *connector* side, where transients actually arrive. The low-capacitance part was chosen deliberately: a fat protection diode on a data line rounds off WS281x bit timing and produces a controller that works on the bench and sparkles on a 40-foot run.

**Three things on this board can be killed by field abuse. All three pull out by hand.**

**The fuse.** A mini blade — the same part sold in a variety pack at every gas station, auto parts counter and big-box store in the country. Pulls with fingers, costs pennies. Not a cartridge you order online and wait for.

**The buffer.** A jellybean octal logic IC in a DIP socket. It sits directly behind your wiring, which makes it the part most likely to die and the part most annoying to replace anywhere else. Here it lifts out with a fingernail. And the socket accepts **either a '541 or a '245** — the strap that sets pin 1 handles the 541's active-low output enable and the 245's direction pin, so you fit whichever is in stock. Supply-chain resilience on a fifty-cent line item sounds trivial right up until the next shortage.

**The MCU.** A socketed module. Blow it up, seat another. No hot air, no braid, no scrap board.

Nobody else in this class can claim all three.

**And that is what the board area buys.** Blade holders, a DIP socket, and terminal clearance cost real estate — there is room to get an iron in, room to pull a fuse without tweezers, room to reach the reset button without unmounting anything, and room at the terminals for heavy wire with ferrules. Compact is easy. Compact *and* serviceable at 30 A is a different problem, and this is the side of it we chose. A channel that dies at eight o'clock on the twenty-third of December should be a fifteen-minute drive, not a three-day wait.

**Serviceable by design.** The level shifter sits in a DIP socket. The DevKit sits in headers. Fuses pull by hand. Through-hole parts dominate the power section on purpose — this board is meant to be repaired, not replaced.

---

## Where It Goes


- **Mixed-hardware installations** — one controller SKU across a fleet built from whatever modules were available that year
- **Development and evaluation** — swap modules against a known-good, fully protected carrier
- **Long-life deployments** — the board outlives the module generation it was built around
- **Distributed whole-property displays** — one node per zone, eight runs each, scale by adding nodes

---

## How It Compares


**Comparison basis.** The closest peer is the Bong69 8 Port LED Distro — same idea, power and data integrated on one board, eight ports, WLED, sold at maker scale. QuinLED's Dig-Quad is the other reference point. Competitor figures are taken from the vendors' own published FAQ and specification pages as of July 2026 and should be re-verified before publication.

*Athom's WLED range is deliberately excluded: single-strip and PWM controllers aimed at room-level and audio-reactive use. Different product, different buyer.*

| | **NODE Flex** | Bong69 8 Port LED Distro | QuinLED-Dig-Quad v3 |
|---|---|---|---|
| Output channels | 8 | 8 | 4 |
| **MCU compatibility** | **Any DevKit on 0.9″ or 1.0″ row spacing, any length up to 22 positions** | Fixed — WT32-ETH01 integrated | Fixed footprint — QuinLED-ESP32 or D1 Mini 32 |
| Survives module obsolescence | Yes — jumper a different DevKit | No — board is the module | No |
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
| Unconfigured input handling | Pull-down on all 8 buffer inputs | n/a — fixed pinout | n/a — fixed pinout |
| Level shifter | 8-channel, socketed DIP | Not published | 4-channel, soldered |
| Conformal coating | Yes | Not offered | Not offered |
| Fuse-status indicator | Channel activity LED | **Blue "good fuse" LED per channel** | Per board |
| Onboard USB programming | Via the module's own port | Onboard USB-C — required, the ESP is soldered down | Via the module's own port |
| **Field-replaceable MCU** | **Yes — socketed module** | **No — ESP32-WROOM soldered to the board** | Yes — socketed module |
| Fuse replacement | Mini blade — auto parts store, gas station, variety pack | Cartridge in a surface-mount holder — order online | ATO blade — auto parts store |
| Audio-reactive / mic support | DIY — headers fitted, spare GPIO available | DIY — wire an INMP441 to the H1 header (documented) | **Analog audio input broken out** |
| Temperature sensor support | DIY — headers fitted, spare GPIO available | DIY — add header, DS18B20 and 4.7 kΩ (documented) | **Optional onboard footprint** |
| Enclosure | *Coming soon* | None — 3D-print mounts published | None — bare board |
| Board size | 123 × 138 mm — *the cost of blade holders, a DIP socket and terminal clearance* | ~110 × 70 mm | ~100 × 50 mm |
| Firmware | WLED / ESPHome / ESPixelStick — module-level, not board-level | Same | Same |
| Firmware image | Pre-built image supplied per module | Pre-built image supplied; ESPixelStick needs the vendor hardware profile | Stock WLED builds |
| Ecosystem | New | **Established, reviewed, xLights docs** | **Large, mature, well documented** |

**A note on firmware comparisons.** WLED, ESPHome, and ESPixelStick are properties of the ESP32 silicon, not of the carrier board — any of them will run on any of these products. What actually differs is which pre-built image ships, and how much GPIO the board's own hardware has already spent before your channels get any.

**Where the others are the better choice, plainly.** Bong69 ships a proven, well-reviewed board with onboard USB-C programming, per-fuse status LEDs, documented audio-reactive and temperature-sensor support, xLights integration notes, published 3D-print mounts, and boards that arrive pre-configured and tested. QuinLED brings a deep peripheral breakout and years of community documentation. Neither ecosystem exists here yet. If you want established products, buy theirs.

**Where NODE Flex is the better choice.** Every competing board *is* its module — when that ESP32 variant goes end-of-life, the board goes with it. NODE Flex is a carrier: the module is a consumable, the protected power section is the product. Add one board covering 5/12/24/36/48 V pixels with every part in the power path rated at least 1.3× the maximum input — no version to pick, eight fuses for eight channels, an enclosed 57 A terminal instead of exposed lugs, and four levels of protection on separate copper.

**The honest summary:** buy Bong69 or QuinLED if you want the mature ecosystem and never intend to change modules. Buy Flex if you have four different DevKits in a drawer, or if you expect to still be maintaining this installation after the current module generation is gone.

---

## Ordering


| Item | Detail |
|---|---|
| Model | NODE Flex (V1a) |
| Configuration | Assembled, tested, conformal coated |
| Included | Controller board, level shifter installed, fuses installed |
| Not included | **Enclosure**, ESP32 DevKit module, jumper shunts, 3-pin plug connectors, blade fuses beyond those fitted, power supply |
| Availability | **Not currently offered for sale.** The present build is a validation run — first-article hardware for bring-up, characterisation and field trial. |
| Sale status | Planned for the next revision |
| Price | *TBD* |
| Lead time | *TBD* |
| Warranty | *TBD* |

---
---

# NODE Flex V1a — Technical Specification

**Document rev:** 2.1 · **Board rev:** V1a · **Date:** 2026-08-06

---

---
---

# NODE Flex V1a — Variant Specification

**Document rev:** 3.0 · **Board rev:** V1a · **Date:** 2026-08-06

*Power architecture, input protection, outputs, environmental and build data are common to the NODE family and are documented in the **NODE Platform Hardware Reference**. This supplement covers only what is specific to NODE Flex.*

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

## 2. MCU Interface & Firmware


| Parameter | Value |
|---|---|
| Module support | Any ESP32-family DevKit on a supported row spacing (module not included) |
| Supported row spacings | **0.9″ (22.86 mm)** and **1.0″ (25.4 mm)** — both provided on the board |
| Socket rows | 2.54 mm pitch, up to 22 positions per row |
| Module length | Not constrained — shorter modules (2×15, 2×19) seat in the same rows, leaving positions unused |
| Channel assignment | Jumper header maps module GPIO to each of the 8 buffer inputs |
| Unconfigured channels | Held low by pull-down — no floating inputs |
| Buffer enable | Strap-selectable buffer output enable |
| Firmware | WLED — pre-built image supplied, configured for the fitted module's GPIO map |
| Supported LED protocols | WS2811, WS2812/B, WS2813, WS2815, WS2816, SK6812/RGBW, TM1814, and other single-wire families supported by WLED |
| Connectivity | Per installed module — Wi-Fi 2.4 GHz, or wired Ethernet / PoE-Ethernet where the DevKit provides it (e.g. WT32-ETH01) |
| Verified Ethernet DevKits | WT32-ETH01, WT32-ETH01-EVO and WT32-ETH02-PLUS all sit on 0.9″ (22.86 mm) centres and seat directly, leaving one free socket row per side |
| Known non-fitting modules | Olimex and LilyGo boards use non-standard row spacings and will **not** seat directly — they require an adapter or hand-wiring. Check your module's row centres against 0.9″ / 1.0″ before ordering |
| Control protocols | Per WLED: E1.31/sACN, Art-Net, DDP, MQTT, HTTP/JSON API |
| Additional I/O | Spare module GPIO broken out on fitted headers for I²C and SPI peripherals, plus 3.3 V / 5 V / GND / TX / RX. Availability depends on the fitted DevKit |

**Integrator note:** confirm that the GPIO assigned to a channel is not a boot-strapping pin on your specific module, and is free of flash or PSRAM duties. Pin restrictions vary by module and remain the integrator's responsibility.

## 3. Physical


| Parameter | Value |
|---|---|
| PCB dimensions | 123 × 138 mm |
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
| Buffer input pull-downs | 10 kΩ to ground on all 8 inputs — defines logic low when a channel jumper is not fitted; 330 µA sink at logic high |

## 5. Design Notes & Accepted Limitations


Stated plainly rather than buried:

- **Not automotive qualified.** Protection targets transients credible in a residential or light-commercial installation. Not tested to ISO 7637 load-dump profiles; not intended for vehicle use.
- **Worst-case clamp coordination.** At the TVS datasheet maximum clamping voltage under a full 1500 W pulse, the voltage presented to the pass MOSFET and bulk capacitors exceeds their ratings. That condition requires a pulse energy source which does not exist in a mains-fed low-voltage installation, and is accepted as non-credible for the intended deployment. At realistic clamp currents the entire downstream chain retains margin.
- **Over-voltage beyond specification is not survivable.** A supply above the rated input range will conduct the input TVS and open the main fuse. Sacrificial *by design* — the board is protected, the TVS and fuse are consumables.
- **Module compatibility is defined mechanically, and validated electrically by the integrator.** Any DevKit on 0.9″ or 1.0″ row spacing will seat. Whether a given GPIO on that module can drive an output channel is a separate question: strapping pins, flash and PSRAM duties, and input-only pins differ by module and must be checked against the module's own documentation before assigning channels. Olimex and LilyGo boards use non-standard row spacings and will not drop straight in — they need an adapter or hand-wiring to reach the socket rows.
- **Load capability.** The 5 V rail powers onboard logic and indicators only. Pixel power comes directly from the distribution bus; total system current is bounded by the 30 A main fuse and the user's supply.

---

*Wateefy Electronics · NODE Flex · Specifications subject to change.*
