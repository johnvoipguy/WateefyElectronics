# NODE Backbone
### 8-Channel Addressable LED Controller · Ethernet + PoE Node

*Wateefy Electronics*

---

> **Wired control. The network powers the node.**

*[Hero image: populated NODE Backbone board with Ethernet cable, three-quarter view]*

---

## At a Glance


- **8 independent output channels** — WS281x / SK6812 / TM1814 family, 5 V level-shifted drive
- **Wired Ethernet on dedicated silicon** — W5500 controller with its own MAC, PHY and hardware TCP/IP stack
- **Power over Ethernet** — the switch powers the controller; no separate supply for the electronics
- **5–48 VDC pixel input, no jumpers** — **36 V nominal, 48 V maximum**; separate rail for strip power
- **30 A through the board at standard copper** — not a paid upgrade
- **Three isolated power domains** — dirty input, clean protected power, fused distribution bus
- **A fuse on every single output** — eight channels, eight fuses, no sharing

**123 × 129 mm** · 4-layer · ENIG · conformal coated

---

## Why This Exists


Wi-Fi is fine until it isn't. Put twelve controllers on one property, push sixty frames a second of sACN at all of them, and the failure mode is not a clean disconnect — it is stutter, tearing, and one zone that goes dark for four seconds during the show. Adding access points helps until the 2.4 GHz band gives up.

NODE Backbone puts the control plane on wire. Each node gets an Ethernet drop; the switch powers the logic and carries the data. Frame timing becomes deterministic, the controller shows up in your DHCP table like every other piece of infrastructure, and troubleshooting becomes a link light instead of a signal-strength guess.

This is the SKU for the installation that outgrew Wi-Fi.

---

## The Architecture: Three Power Domains


Choosing Ethernet does not mean accepting a weaker power section. The pixel path here is identical to the rest of the line.

Most controllers have one power rail. Input voltage lands on a terminal and it is the same copper that reaches your strips. Whatever arrives — spike, reverse polarity, sag, transient — arrives everywhere at once.

**NODE splits power into three separate domains on their own copper planes:**

**1 · Dirty power in.** The input terminal accepts whatever the supply, the wiring, and the person doing the wiring hand it. Assumed hostile, isolated to the smallest region of the board possible, nothing downstream touching it directly.

**2 · Clean power.** Between dirty and clean sits the protection stage: bidirectional transient clamping and an *active* reverse-polarity blocker. Reverse the supply and the pass element never turns on — no current path to the rest of the board, nothing sacrificed, red indicator tells you why. Correct the wiring and it recovers on its own.

**3 · The protected bus.** Clean power passes the main fuse to become the distribution bus. Each of the eight output channels taps that bus through its own fuse. A fault on run six opens one fuse and the other seven never notice.

> ### BEEFCAKE.
> *The pass element is a 205 A MOSFET on a 30 A board. It will never be the thing that fails.*

**Decoupling where the current actually is.** Two thousand microfarads of bulk sits on the protected bus, and another forty-seven at *every single output connector*. The distribution is the point: one reservoir at the input cannot cover the harness inductance of eight separate output runs no matter how large it is. When a full-white frame lands on all eight channels at once, each channel draws from its own reserve sitting centimetres from its terminal.

Four levels between the screw terminal and your pixels — clamp, active block, main fuse, channel fuse — each on its own copper. That is why this is a four-layer board with a split inner power plane rather than two layers and one pour.

**And a fourth domain, entirely separate:** the network side. Logic power arrives over Ethernet, on its own ground domain, joined to board ground at one deliberate point. The control plane and the high-current pixel return are treated as a design problem rather than an accident of layout — the difference between a board that passes on a bench and one that behaves across long runs and multiple supplies.

**Nothing in the pixel power path is rated below 63 V — and every semiconductor in it is 60 V or above — against a 48 V maximum input.**

**At maximum rated input, no component in the power path operates above 72% of its rating.** The pass MOSFET sits at 60%, the ideal-diode controller at 55%, the regulator at 45%. It is not a number anyone else in this class publishes, and it is the reason to believe the rest of this page.

---

## What Else You Actually Get


**A real network node.** Wired 10/100 Ethernet with PoE means the logic side needs nothing but the drop. Run pixel power to the enclosure on conductors sized for the load and let the network cable handle control and controller power. Fewer supplies, fewer failure points, and a control path that behaves the same at node twelve as at node one.

**Reachable even when the pixel supply is off.** Because logic power comes over Ethernet, the node stays on the network with the strip supply dark. Useful for pre-season configuration and for telling "controller down" apart from "supply down" without a ladder.

**Ethernet on dedicated silicon.** The ESP32-S3 has no built-in Ethernet MAC, so this variant runs a W5500 — a standalone controller carrying its own MAC, its own PHY, and a hardware TCP/IP stack, talking to the MCU over SPI. The alternative in this class is an ESP32-classic driving an external PHY over RMII, which consumes nine GPIO and runs the network stack on the same cores rendering your effects. Here, the network is somebody else's job.

**Data lines treated like data lines.** Series resistance and a sub-picofarad ESD device per channel, placed on the connector side where transients arrive, chosen so the clamp does not round off WS281x bit timing on long runs.

**Three things on this board can be killed by field abuse. All three pull out by hand.**

**The fuse.** A mini blade — the same part sold in a variety pack at every gas station, auto parts counter and big-box store in the country. Pulls with fingers, costs pennies. Not a cartridge you order online and wait for.

**The buffer.** A jellybean octal logic IC in a DIP socket. It sits directly behind your wiring, which makes it the part most likely to die and the part most annoying to replace anywhere else. Here it lifts out with a fingernail. And the socket accepts **either a '541 or a '245** — the strap that sets pin 1 handles the 541's active-low output enable and the 245's direction pin, so you fit whichever is in stock. Supply-chain resilience on a fifty-cent line item sounds trivial right up until the next shortage.

**The MCU.** A socketed module. Blow it up, seat another. No hot air, no braid, no scrap board.

Nobody else in this class can claim all three.

**And that is what the board area buys.** Blade holders, a DIP socket, and terminal clearance cost real estate — there is room to get an iron in, room to pull a fuse without tweezers, room to reach the reset button without unmounting anything, and room at the terminals for heavy wire with ferrules. Compact is easy. Compact *and* serviceable at 30 A is a different problem, and this is the side of it we chose. A channel that dies at eight o'clock on the twenty-third of December should be a fifteen-minute drive, not a three-day wait.

---

## Where It Goes


- **Large distributed displays** — a dozen or more nodes where Wi-Fi contention becomes the limiting factor
- **Permanent commercial and architectural installations** — where the lighting belongs in the building's network documentation
- **Long runs to outbuildings** — an Ethernet drop instead of a wireless prayer; pixel power still runs on its own conductors
- **High frame-rate sACN or Art-Net** — deterministic delivery, no shared-medium contention

---

## How It Compares


**Comparison basis.** The closest peer is the Bong69 8 Port LED Distro — same idea, power and data integrated on one board, eight ports, wired Ethernet, WLED, sold at maker scale. QuinLED's Dig-Quad supports an Ethernet-capable brain board and is the other reference point. Competitor figures are taken from the vendors' own published FAQ and specification pages as of July 2026 and should be re-verified before publication.

*Athom's WLED range is deliberately excluded: single-strip and PWM controllers aimed at room-level and audio-reactive use. Different product, different buyer.*

| | **NODE Backbone** | Bong69 8 Port LED Distro | QuinLED-Dig-Quad v3 |
|---|---|---|---|
| Output channels | 8 | 8 | 4 |
| Control transport | Wired Ethernet | Wired Ethernet (WT32-ETH01) | Wi-Fi, or Ethernet via brain board |
| **Ethernet implementation** | **W5500 dedicated controller on SPI — own MAC, PHY and hardware TCP/IP** | ESP32 internal RMII MAC + external PHY — consumes 9 GPIO | Per brain board |
| **Controller power** | **PoE from the switch** | From the pixel supply | From the pixel supply |
| **Reachable with pixel supply off** | **Yes** | No | No |
| **Pixel input range, one SKU** | **5–48 VDC** | V4: 12–48 V (**5 V support dropped**) · V3: 5–24 V (**discontinued**) | 5–24 VDC |
| Covers 5/12/24/36/48 V pixels | Yes, one board | 12–48 V only — 5 V support dropped in V4 | Jumper-selectable up to 24 V; 36 V and 48 V not supported |
| Input voltage selection | None — nothing to set wrong | Per board version | Jumper; vendor warns wrong setting *"will fry the onboard components"* |
| Input connector | Enclosed 57 A screw terminal | V4: spade connectors on a stud | Screw terminal |
| Continuous current, standard copper | 30 A | Not published | 15 A at 1 oz (30 A only with paid 2 oz upgrade) |
| Per-channel fuse rating | 7.5 A nominal · 10 A max per output | 5 A (V4) · 4 A hold / 8 A trip polyfuse (V3) | 10 A max recommended |
| Fuses on outputs | 8 — one per channel | 8 — one per channel | 5 fuses across 7 outputs (channels share) |
| Reverse-polarity protection | Active blocking — non-destructive, self-recovering | Not published | Parallel diode with fuse — sacrificial |
| Input transient clamp | Bidirectional TVS across the input | Not published | Not published |
| Data-line ESD protection | Per channel, sub-pF device | Series resistor only (33 Ω) | Not published |
| Power domain separation | 3 pixel domains + isolated network domain | Not published | Single rail |
| Level shifter | 8-channel, socketed DIP | Not published | 4-channel, soldered |
| Conformal coating | Yes | Not offered | Not offered |
| Fuse-status indicator | Channel activity LED | **Blue "good fuse" LED per channel** | Per board |
| Onboard USB programming | Via the module's own port | Onboard USB-C — required, the ESP is soldered down | Via the module's own port |
| **Field-replaceable MCU** | **Yes — socketed module** | **No — ESP32-WROOM soldered to the board** | Yes — socketed module |
| Fuse replacement | Mini blade — auto parts store, gas station, variety pack | Cartridge in a surface-mount holder — order online | ATO blade — auto parts store |
| Audio-reactive / mic support | DIY — headers fitted, spare GPIO available | DIY — wire an INMP441 to the H1 header (documented) | **Analog audio input broken out** |
| Temperature sensor support | DIY — headers fitted, spare GPIO available | DIY — add header, DS18B20 and 4.7 kΩ (documented) | **Optional onboard footprint** |
| Enclosure | *Coming soon* | None — 3D-print mounts published | None — bare board |
| Board size | 123 × 129 mm — *the cost of blade holders, a DIP socket and terminal clearance* | ~110 × 70 mm | ~100 × 50 mm |
| Firmware | WLED / ESPHome / ESPixelStick — module-level, not board-level | Same | Same |
| Firmware image | Pre-built Ethernet image supplied | Pre-built image supplied; ESPixelStick needs the vendor hardware profile | Stock WLED builds |
| Ecosystem | New | **Established, reviewed, xLights docs** | **Large, mature, well documented** |

**A note on firmware comparisons.** WLED, ESPHome, and ESPixelStick are properties of the ESP32 silicon, not of the carrier board — any of them will run on any of these products. What actually differs is which pre-built image ships, and how much GPIO the board's own hardware has already spent before your channels get any.

**Where the others are the better choice, plainly.** Bong69 ships a proven, well-reviewed Ethernet board with onboard USB-C programming, per-fuse status LEDs, documented audio-reactive and temperature-sensor support, xLights integration notes, published 3D-print mounts, and boards that arrive pre-configured and tested. QuinLED brings a deep peripheral breakout and years of community documentation. Neither ecosystem exists here yet. If you want established products, buy theirs.

**Where NODE Backbone is the better choice.** Everyone in this class can do Ethernet. Almost nobody powers the controller from it. PoE means one cable to the node, no second low-voltage feed into the enclosure, and a controller that stays on the network with the pixel supply dark — the difference between diagnosing a dead zone from your desk and diagnosing it from a ladder. Add one board covering 5/12/24/36/48 V pixels with every part in the power path rated at least 1.3× the maximum input — no version to pick, an enclosed 57 A terminal instead of exposed lugs, and four levels of protection on separate copper.

**And plainly: if one controller sits in a garage and works fine on Wi-Fi, buy NODE Mini and save the money.** NODE Backbone earns its price at the scale where wireless stops being reliable — a threshold that arrives earlier than most people expect.

---

## Ordering


| Item | Detail |
|---|---|
| Model | NODE Backbone (V1a) |
| Configuration | Assembled, tested, conformal coated |
| Included | Controller board, level shifter installed, fuses installed |
| Not included | **Enclosure**, Waveshare ESP32-S3-ETH-POE module, 3-pin plug connectors, blade fuses beyond those fitted, pixel supply, Ethernet cable |
| Availability | **Not currently offered for sale.** The present build is a validation run — first-article hardware for bring-up, characterisation and field trial. |
| Sale status | Planned for the next revision |
| Price | *TBD* |
| Lead time | *TBD* |
| Warranty | *TBD* |

---
---

# NODE Backbone V1a — Technical Specification

**Document rev:** 2.1 · **Board rev:** V1a · **Date:** 2026-08-06

---

---
---

# NODE Backbone V1a — Variant Specification

**Document rev:** 3.0 · **Board rev:** V1a · **Date:** 2026-08-06

*Power architecture, input protection, outputs, environmental and build data are common to the NODE family and are documented in the **NODE Platform Hardware Reference**. This supplement covers only what is specific to NODE Backbone.*

---

## 1. Logic Rail


| Parameter | Value | Notes |
|---|---|---|
| 5 V source | Waveshare ESP32-S3-ETH-POE module | **No onboard buck converter on this variant** |
| Supply path | Module 5 V output → buffer, indicators | Independent of pixel input rail |
| 5 V rail clamp | SMAJ6.0A TVS | 6 V standoff |
| Grounding | Module ground domain merged to board ground at a single defined point | Isolation handled explicitly in layout |
| Behavior with pixel supply off | Controller remains powered and network-reachable | Configuration and diagnostics available without strip power |

## 2. MCU, Network & Firmware


| Parameter | Value |
|---|---|
| Module | Waveshare ESP32-S3-ETH-POE (not included) |
| SoC | ESP32-S3R8 — dual-core Xtensa LX7 @ 240 MHz |
| Memory | 8 MB PSRAM |
| LED driver allocation | 4 hardware RMT TX channels; outputs 5–8 switch to parallel I2S automatically — no setting to change |
| Mounting | Socketed — removable without desoldering |
| Network interface | Wired 10/100 Ethernet, W5500 controller on SPI |
| Ethernet architecture | Dedicated MAC + PHY + hardware TCP/IP offload; MCU cores not used for the stack |
| Power over Ethernet | IEEE 802.3af compliant, via the module's PoE daughterboard |
| Wireless | Wi-Fi available on module; wired Ethernet is the intended control path |
| Firmware | WLED — pre-built Ethernet image supplied (W5500 SPI configuration) |
| Supported LED protocols | WS2811, WS2812/B, WS2813, WS2815, WS2816, SK6812/RGBW, TM1814, and other single-wire families supported by WLED |
| Control protocols | Per WLED: E1.31/sACN, Art-Net, DDP, MQTT, HTTP/JSON API |
| Additional I/O | Spare module GPIO broken out on fitted headers for I²C and SPI peripherals, plus 3.3 V / 5 V / GND / TX / RX — no LED channels sacrificed |
| GPIO restriction | GPIO33–GPIO37 are consumed by the module's octal PSRAM and are unavailable; channel assignments avoid these pins by design |

**Integrator note:** the module is an 802.3af powered device. Confirm the total PoE budget on your switch before populating it with many nodes.

## 3. Physical


| Parameter | Value |
|---|---|
| PCB dimensions | 123 × 129 mm |
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
| Input rail | Pixel input powers strips only; controller logic is PoE-fed |
| Logic supply | Waveshare module 5 V output — **no onboard buck on this variant** |
| Power domains | Four — the three pixel-side domains plus an independent network-powered logic domain, ground-joined at one defined point |
| Headroom wording | Where the Platform Reference says *power path*, read *pixel power path* |

## 5. Design Notes & Accepted Limitations


Stated plainly rather than buried:

- **Not automotive qualified.** Protection targets transients credible in a residential or light-commercial installation. Not tested to ISO 7637 load-dump profiles; not intended for vehicle use.
- **Worst-case clamp coordination.** At the TVS datasheet maximum clamping voltage under a full 1500 W pulse, the voltage presented to the pass MOSFET and bulk capacitors exceeds their ratings. That condition requires a pulse energy source which does not exist in a mains-fed low-voltage installation, and is accepted as non-credible for the intended deployment. At realistic clamp currents the entire downstream chain retains margin.
- **Over-voltage beyond specification is not survivable.** A supply above the rated input range will conduct the input TVS and open the main fuse. Sacrificial *by design* — the board is protected, the TVS and fuse are consumables.
- **No onboard 5 V regulator.** Logic power comes exclusively from the module. An unpowered Ethernet drop means an unpowered controller regardless of pixel supply state.
- **PoE budget is the installer's responsibility.** Node count per switch is bounded by the switch's total PoE power budget, not by this board.
- **Load capability.** Pixel power comes directly from the distribution bus; total system current is bounded by the 30 A main fuse and the user's supply.

---

*Wateefy Electronics · NODE Backbone · Specifications subject to change.*
