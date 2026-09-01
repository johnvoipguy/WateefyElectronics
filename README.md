<p align="center">
  <img src="./images/REPLACE-WITH-LOGO-FILENAME.png" alt="Wateefy Electronics" width="380">
</p>

<h1 align="center">Wateefy Electronics</h1>

<p align="center"><strong>Hardware documentation, firmware images and release mirrors.</strong></p>

---

## About

Wateefy Electronics designs LED control and power distribution hardware for people who take their lighting seriously — permanent architectural work, seasonal displays that go up in November and stay up through weather nobody planned for, and installations where a dead zone is a phone call rather than an inconvenience.

The premise is straightforward. Lighting hardware fails in predictable ways: a shorted run takes the whole board, a supply gets wired backwards for two seconds, a strip is hot-plugged and the inductive kick walks through the regulator. None of these are exotic. They are Tuesday in a real installation, and most boards have nothing standing in the path to stop any of them.

Every Wateefy board is built the other way around. Each of those failure modes has a specific part in front of it, chosen from a datasheet and verified against the copper. Protection is separated onto its own planes rather than sharing one rail with everything else. The parts most likely to die in the field are the parts you can pull out with your fingers. It costs more than the cheap controller and it survives the season that kills it.

That philosophy scales across the catalog: pixel controllers, power distribution and injection, and whatever the next problem turns out to be.

This repository is the public documentation for that hardware. It is not the design source — schematics and layout are not published here.

---

## The NODE Platform

The NODE family is our line of addressable pixel controllers. Three boards share one power and protection architecture, differing only in how the MCU is powered and mounted — the protected power section is the product, and the module is a consumable.

| | **NODE Mini** | **NODE Flex** | **NODE Backbone** |
|---|---|---|---|
| **Control transport** | Wi-Fi | Per installed module | Wired Ethernet with PoE |
| **MCU** | Seeed XIAO ESP32-S3, socketed | Any ESP32 DevKit on 0.9″ or 1.0″ row spacing | Waveshare ESP32-S3-ETH-POE, socketed |
| **Logic power** | Onboard buck regulator from the pixel supply | Onboard buck regulator from the pixel supply | Power over Ethernet, independent of the pixel supply |
| **Built for** | Single zones on straightforward Wi-Fi sites | Mixed-hardware fleets and module obsolescence | Large installations where Wi-Fi contention becomes the limit |

### Shared architecture

Most controllers have one power rail. Input voltage lands on a terminal and it is the same copper that reaches the strips — whatever arrives, arrives everywhere at once.

NODE splits power into three isolated domains, each on its own copper plane:

1. **Dirty power in.** The input terminal is assumed hostile, isolated to the smallest region of the board possible, with nothing downstream touching it directly.
2. **Clean power.** Bidirectional transient clamping and an active reverse-polarity blocker sit between dirty and clean. Reverse the supply and the pass element never turns on — no current path, nothing sacrificed, red indicator explains why. Correct the wiring and it recovers on its own.
3. **The protected distribution bus.** Clean power passes the main fuse to become the bus. Each of the eight outputs taps that bus through its own fuse. A fault on run six opens one fuse and the other seven never notice.

Four levels of protection sit between the screw terminal and the pixels — clamp, active block, main fuse, channel fuse — each on its own copper. That is why these are four-layer boards with a split inner power plane rather than two layers and one pour.

### Common to every board

- 8 independent output channels — WS281x / SK6812 / TM1814 family, 5 V level-shifted drive
- 5–48 VDC input, no voltage jumper — one board runs 5, 12, 24 and 36 V pixel systems with nothing to set wrong
- 30 A through the board at standard 1 oz copper — not a paid upgrade
- One fuse per output channel, eight channels, no sharing
- Non-destructive reverse-polarity protection — nothing is consumed when someone wires it backwards
- Four-port DMX-512 / RS-485 output with per-port transient protection, one port receive-capable
- Per-channel data ESD protection chosen for low junction capacitance, so it does not round off WS281x bit timing on long runs
- Conformal coated at the fab — protects against moisture and humidity, with connectors, sockets, fuse clips and switches masked
- Runs WLED — pre-built images maintained for each board, no proprietary control protocol, no vendor lock-in

### Serviceable by design

Three things on these boards can be killed by field abuse, and all three pull out by hand.

**The fuse** is a mini blade — the same part sold in a variety pack at any auto parts counter. **The buffer** is a jellybean octal logic IC in a DIP socket, and the socket accepts either of two common logic families, so whichever one is in stock works. **The MCU** is a socketed module: seat another and carry on. No hot air, no braid, no scrap board.

That is what the board area buys. Blade holders, a DIP socket and terminal clearance cost real estate — room to get an iron in, room to pull a fuse without tweezers, room to reach the reset button without unmounting anything. Compact is easy. Compact and serviceable at high current is a different problem, and this is the side of it we chose. A channel that dies at eight o'clock on the twenty-third of December should be a fifteen-minute drive, not a three-day wait.

---

## Node Power

Controllers are half the problem. The other half is getting clean, protected power to where the pixels actually are — and the same three-domain thinking applies there too.

**Node Power is coming.** Details when the boards are ready, and not a day before.

---

## Documentation

Specifications are maintained per board, not in this README.

| Document | Covers |
|---|---|
| [NODE Platform Reference](./Node%20Pixel%20Controllers/README.md) | Power architecture, input protection, output stage, environmental and build data — common to all three boards. Also available as [PDF](./Node%20Pixel%20Controllers/NODE-Common-V1a.pdf) |
| [NODE Mini](./Node%20Pixel%20Controllers/Node%20Mini) | Variant specification — XIAO ESP32-S3 socket, onboard logic rail, GPIO map |
| [NODE Flex](./Node%20Pixel%20Controllers/Node%20Flex) | Variant specification — universal DevKit carrier, jumper channel mapping, module compatibility |
| [NODE Backbone](./Node%20Pixel%20Controllers/Node%20Backbone) | Variant specification — Ethernet and PoE, W5500 network stack, isolated logic domain |
| [Datasheets](./Datasheets) | Product datasheets in PDF |

Read the Platform Reference for how the board protects your pixels. Read the variant specification for the differences between boards.

---

## Firmware

Pre-built WLED images, configured for each board's GPIO map.

- [Node Mini (XIAO)](./Firmware/Node%20Mini/README.md)
- [Node Backbone (Waveshare)](./Firmware/Node%20Backbone/README.md)
- [All mirrored releases](https://github.com/johnvoipguy/WateefyElectronics/releases)

Images are built and maintained per board — Backbone needs its own Ethernet build, and the XIAO runs a modified build to match the Mini's GPIO map. Flash what is published here rather than a generic release.

WLED, ESPHome and ESPixelStick are properties of the ESP32 silicon, not of the carrier board, so any of them will run on any NODE board. What differs is which pre-built image ships, and how much GPIO the board's own hardware has already spent before your channels get any.

Flashing requires `esptool`. See the [firmware directory](./Firmware) for the procedure.

---

## Repository layout

```
Datasheets/               Product datasheets (PDF)
Firmware/                 Pre-built WLED images and flashing instructions
Node Pixel Controllers/   Platform reference and per-board specifications
images/                   Product and documentation imagery
releases/                 Release notes and mirrors
```

---

## Compatibility

**LED protocols:** WS2811, WS2812/B, WS2813, WS2815, WS2816, SK6812/RGBW, TM1814, and other single-wire families supported by WLED.

**Control protocols:** E1.31/sACN, Art-Net, DDP, MQTT and the HTTP/JSON API, per WLED. DMX-512 over RS-485 on the onboard transceiver ports.

---

## Status<p align="center">
  <img src="./images/REPLACE-WITH-LOGO-FILENAME.png" alt="Wateefy Electronics" width="380">
</p>

<h1 align="center">Wateefy Electronics</h1>

<p align="center"><strong>Hardware documentation, firmware images and release mirrors.</strong></p>

---

## About

**One person. No corners cut.**

Wateefy Electronics is a one-person hardware shop building pixel-lighting gear that survives the season that kills the cheap stuff.

It started with boards that kept dying. Lighting hardware fails in predictable ways: a shorted run takes the whole board, a supply gets wired backwards for two seconds, a strip is hot-plugged and the inductive kick walks through the regulator. None of that is exotic. It is a normal season in a real installation, and most boards have nothing standing in the path to stop any of it.

So I taught myself PCB design and built the board I wanted to own — one where every failure mode has a specific part in front of it, chosen from a datasheet and verified against the copper. That board became the NODE family. The engineering discipline comes from infrastructure that is not allowed to fall over; the lights are where I get to have fun with it.

There is no team to hide behind. If something is wrong, it is on me, and I will make it right.

### How I build

**Protection first — assume it gets abused.** Reverse polarity, transients, shorted runs, backwards supplies. The board is designed for the bad day, not the bench. Nothing in the power path runs near its limit.

**Honest specs — numbers you can check.** Real ratings, real derating, real trade-offs stated out loud. No vaporware, no spec-sheet trophies that fall apart when someone does the math.

**Serviceable — repair, don't replace.** Fuses you swap by hand. A board meant to be fixed and kept running, not thrown out when one channel dies.

**Open to the community.** Docs, board definitions and STLs live here on GitHub. This gear is for the xLights and WLED crowd, built alongside them.

That approach scales across the catalog: pixel controllers, power distribution and injection, and whatever the next problem turns out to be.

This repository is the public documentation for that hardware. It is not the design source — schematics and layout are not published here.

---

## The NODE Platform

The NODE family is our line of addressable pixel controllers. Three boards share one power and protection architecture, differing only in how the MCU is powered and mounted — the protected power section is the product, and the module is a consumable.

| | **NODE Mini** | **NODE Flex** | **NODE Backbone** |
|---|---|---|---|
| **Control transport** | Wi-Fi | Per installed module | Wired Ethernet with PoE |
| **MCU** | Seeed XIAO ESP32-S3, socketed | Any ESP32 DevKit on 0.9″ or 1.0″ row spacing | Waveshare ESP32-S3-ETH-POE, socketed |
| **Logic power** | Onboard buck regulator from the pixel supply | Onboard buck regulator from the pixel supply | Power over Ethernet, independent of the pixel supply |
| **Built for** | Single zones on straightforward Wi-Fi sites | Mixed-hardware fleets and module obsolescence | Large installations where Wi-Fi contention becomes the limit |

### Shared architecture

Most controllers have one power rail. Input voltage lands on a terminal and it is the same copper that reaches the strips — whatever arrives, arrives everywhere at once.

NODE splits power into three isolated domains, each on its own copper plane:

1. **Dirty power in.** The input terminal is assumed hostile, isolated to the smallest region of the board possible, with nothing downstream touching it directly.
2. **Clean power.** Bidirectional transient clamping and an active reverse-polarity blocker sit between dirty and clean. Reverse the supply and the pass element never turns on — no current path, nothing sacrificed, red indicator explains why. Correct the wiring and it recovers on its own.
3. **The protected distribution bus.** Clean power passes the main fuse to become the bus. Each of the eight outputs taps that bus through its own fuse. A fault on run six opens one fuse and the other seven never notice.

Four levels of protection sit between the screw terminal and the pixels — clamp, active block, main fuse, channel fuse — each on its own copper. That is why these are four-layer boards with a split inner power plane rather than two layers and one pour.

### Common to every board

- 8 independent output channels — WS281x / SK6812 / TM1814 family, 5 V level-shifted drive
- 5–48 VDC input, no voltage jumper — one board runs 5, 12, 24 and 36 V pixel systems with nothing to set wrong
- 30 A through the board at standard 1 oz copper — not a paid upgrade
- One fuse per output channel, eight channels, no sharing
- Non-destructive reverse-polarity protection — nothing is consumed when someone wires it backwards
- Four-port DMX-512 / RS-485 output with per-port transient protection, one port receive-capable
- Per-channel data ESD protection chosen for low junction capacitance, so it does not round off WS281x bit timing on long runs
- Conformal coated at the fab — protects against moisture and humidity, with connectors, sockets, fuse clips and switches masked
- Runs WLED — pre-built images maintained for each board, no proprietary control protocol, no vendor lock-in

### Serviceable by design

Three things on these boards can be killed by field abuse, and all three pull out by hand.

**The fuse** is a mini blade — the same part sold in a variety pack at any auto parts counter. **The buffer** is a jellybean octal logic IC in a DIP socket, and the socket accepts either of two common logic families, so whichever one is in stock works. **The MCU** is a socketed module: seat another and carry on. No hot air, no braid, no scrap board.

That is what the board area buys. Blade holders, a DIP socket and terminal clearance cost real estate — room to get an iron in, room to pull a fuse without tweezers, room to reach the reset button without unmounting anything. Compact is easy. Compact and serviceable at high current is a different problem, and this is the side of it we chose. A channel that dies at eight o'clock on the twenty-third of December should be a fifteen-minute drive, not a three-day wait.

---

## Node Power

Controllers are half the problem. The other half is getting clean, protected power to where the pixels actually are — and the same three-domain thinking applies there too.

**Node Power is coming.** Details when the boards are ready, and not a day before.

---

## Documentation

Specifications are maintained per board, not in this README.

| Document | Covers |
|---|---|
| [NODE Platform Reference](./Node%20Pixel%20Controllers/README.md) | Power architecture, input protection, output stage, environmental and build data — common to all three boards. Also available as [PDF](./Node%20Pixel%20Controllers/NODE-Common-V1a.pdf) |
| [NODE Mini](./Node%20Pixel%20Controllers/Node%20Mini) | Variant specification — XIAO ESP32-S3 socket, onboard logic rail, GPIO map |
| [NODE Flex](./Node%20Pixel%20Controllers/Node%20Flex) | Variant specification — universal DevKit carrier, jumper channel mapping, module compatibility |
| [NODE Backbone](./Node%20Pixel%20Controllers/Node%20Backbone) | Variant specification — Ethernet and PoE, W5500 network stack, isolated logic domain |
| [Datasheets](./Datasheets) | Product datasheets in PDF |

Read the Platform Reference for how the board protects your pixels. Read the variant specification for the differences between boards.

---

## Firmware

Pre-built WLED images, configured for each board's GPIO map.

- [Node Mini (XIAO)](./Firmware/Node%20Mini/README.md)
- [Node Backbone (Waveshare)](./Firmware/Node%20Backbone/README.md)
- [All mirrored releases](https://github.com/johnvoipguy/WateefyElectronics/releases)

Images are built and maintained per board — Backbone needs its own Ethernet build, and the XIAO runs a modified build to match the Mini's GPIO map. Flash what is published here rather than a generic release.

WLED, ESPHome and ESPixelStick are properties of the ESP32 silicon, not of the carrier board, so any of them will run on any NODE board. What differs is which pre-built image ships, and how much GPIO the board's own hardware has already spent before your channels get any.

Flashing requires `esptool`. See the [firmware directory](./Firmware) for the procedure.

---

## Repository layout

```
Datasheets/               Product datasheets (PDF)
Firmware/                 Pre-built WLED images and flashing instructions
Node Pixel Controllers/   Platform reference and per-board specifications
images/                   Product and documentation imagery
releases/                 Release notes and mirrors
```

---

## Compatibility

**LED protocols:** WS2811, WS2812/B, WS2813, WS2815, WS2816, SK6812/RGBW, TM1814, and other single-wire families supported by WLED.

**Control protocols:** E1.31/sACN, Art-Net, DDP, MQTT and the HTTP/JSON API, per WLED. DMX-512 over RS-485 on the onboard transceiver ports.

---

## Status

The NODE family is pre-release. Current hardware is a validation build — first-article boards for bring-up, characterisation and field trial. Documentation in this repository tracks that hardware and will change as revisions are finalised.

---

## Support

Open an [issue](https://github.com/johnvoipguy/WateefyElectronics/issues) for documentation errors, firmware problems or hardware questions.

---

## Accepted limitations

Stated plainly rather than buried:

- **Not automotive qualified.** Protection targets transients credible in a residential or light-commercial installation. Not tested to ISO 7637 load-dump profiles, and not intended for vehicle use.
- **Over-voltage beyond specification is not survivable.** A supply above the rated input range will conduct the input TVS and open the main fuse. This is sacrificial by design — the board is protected, and the TVS and fuse are treated as consumables.
- **No enclosure is included, and none is planned.** Four corner mounting holes are provided; the boards are intended to mount in whatever the installation already uses.
- **The ecosystem is new.** Established alternatives exist with years of community documentation behind them. Each board's specification names them directly and states plainly where they are the better choice.

---

## Firmware Downloads

Use this quick selector:

- **Node Mini (XIAO)** → [Go to Mini downloads](./Firmware/Node%20Mini/README.md)
- **Node Backbone (Waveshare)** → [Go to Backbone downloads](./Firmware/Node%20Backbone/README.md)

Or browse all mirrored releases directly:  
https://github.com/johnvoipguy/WateefyElectronics/releases

<sub>© 2026 Wateefy Electronics. Specifications subject to change.</sub>
