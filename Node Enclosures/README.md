# NODE Enclosures

### 3D-Printable Enclosures for the NODE Family

*Wateefy Electronics*

---

> **Free to print. Built to take the weather.**

**Document rev:** 1.0 · **Date:** 2026-10-08

---

## Overview

Three printable enclosures for NODE controllers, designed and test-printed in-house. Each
one has a fitted lid, a gland wall for every cable, and shrouded vents for an optional fan.

The print files (3MF) are free in this repository. Printed enclosures are also available in the
store, either bundled with a controller or on their own for anyone without a printer.

| | **NODE Aegis** | **NODE Bastion 350** | **NODE Citadel 600** |
|---|---|---|---|
| **Holds** | Any NODE board | NODE board + Mean Well LRS-350 | NODE board + Mean Well LRS-600 |
| **Dimensions (L × W × H)** | 187 × 153 × 46 mm | 275 × 175 × 91 mm | 275 × 175 × 99 mm |
| **Power input** | 1 × PG9 gland | 1 × PG9 gland | 1 × PG9 gland |
| **Pixel outputs** | 8 × PG7 glands | 8 × PG7 glands | 8 × PG7 glands |
| **Fan mount (optional 5 V fan)** | 3010 holes printed in | 3010 / 4010 holes printed in | 3010 / 4010 holes printed in |
| **Venting** | Shrouded vents | Shrouded vents | Shrouded vents |
| **PSU rail mounts** | — | Printable, included | Printable, included |
| **Lid** | Included | Included | Included |

---

## Common to All Three

- **Fasteners (not included):** every screw hole is printed with an M4 thread. Printed threads
  vary with printer accuracy, so use M4 self-tapping screws. Recommended lengths are 6 mm for
  the lid, and 4 mm for the NODE controller and the PSU rails.
- **Lid seal:** the top edge of the shell is stepped. A raised inner lip, about 1 mm wide and
  1.5 mm tall, runs inside the ring of screw holes and seats into a matching groove in the lid.
  The screw holes sit outside that lip, so water coming through a screw hole (loose, stripped
  or missing screw) can't get past the lid joint into the enclosure.
- **Glands:** 1 × PG9 for power in, 8 × PG7 for the pixel runs, one gland per channel.
- **Fan:** mounting holes for the fan are designed into the print: 3010 on the Aegis, 3010 or 4010
  on the Bastion and Citadel. The fan itself is optional, 5 V, and sits behind a printed vent
  shroud. The shrouds stay in place with or without a fan.
- **Ethernet (NODE Backbone, or NODE Flex with an Olimex or ETH01 module):** no Ethernet hole is pre-cut. Drill one for an M25 gland, or
  whatever size your cable and jack need.

---

## NODE Aegis

The bare-bones enclosure. Fits any NODE controller, with no onboard PSU. Use it when power
comes from a supply mounted elsewhere.

<p align="center">
  <img src="./Aegis/images/aegis-front-lid.png" alt="NODE Aegis, lid on, gland wall" width="32%">
  <img src="./Aegis/images/aegis-top-loaded.png" alt="NODE Aegis with controller installed" width="32%">
  <img src="./Aegis/images/aegis-top-bare.png" alt="NODE Aegis, empty shell" width="32%">
</p>

| | |
|---|---|
| Dimensions | 187 × 153 × 46 mm (L × W × H) |
| Fan | 3010 mounting holes printed in; 5 V fan optional |
| Files | [`Aegis/`](./Aegis/) |

---

## NODE Bastion 350

Controller and supply in one box. Built around the **Mean Well LRS-350**, which sits on
printable rails with the NODE board above it.

<p align="center">
  <img src="./Bastion%20350/images/bastion-350-loaded.png" alt="NODE Bastion 350 with controller and PSU" width="32%">
  <img src="./Bastion%20350/images/bastion-350-bare-lid.png" alt="NODE Bastion 350 shell, PSU rails and lid" width="32%">
  <img src="./Bastion%20350/images/bastion-350-closed.png" alt="NODE Bastion 350, lid on" width="32%">
  <img src="./Bastion%20350/images/bastion-350-loaded-lid.png" alt="NODE Bastion 350 loaded, lid alongside" width="32%">
</p>

| | |
|---|---|
| Dimensions | 275 × 175 × 91 mm (L × W × H) |
| PSU | Mean Well LRS-350, on included printable rail mounts |
| Fan | 3010 / 4010 mounting holes printed in; 5 V fan optional |
| Files | [`Bastion 350/`](./Bastion%20350/) |

---

## NODE Citadel 600

The large one. Same footprint as the Bastion, but taller to clear the **Mean Well LRS-600**.

<p align="center">
  <img src="./Citadel%20600/images/citadel-600-loaded.png" alt="NODE Citadel 600 with controller and PSU" width="32%">
  <img src="./Citadel%20600/images/citadel-600-bare.png" alt="NODE Citadel 600, empty shell" width="32%">
  <img src="./Citadel%20600/images/citadel-600-bare-top.png" alt="NODE Citadel 600, top view with PSU rails" width="32%">
</p>

| | |
|---|---|
| Dimensions | 275 × 175 × 99 mm (L × W × H) |
| PSU | Mean Well LRS-600, on included printable rail mounts |
| Fan | 3010 / 4010 mounting holes printed in; 5 V fan optional |
| Files | [`Citadel 600/`](./Citadel%20600/) |

---

## Files

Each enclosure folder holds its print-ready 3MF and reference photos:

```
Node Enclosures/
├── README.md
├── Aegis/
│   ├── NODE-Aegis-Enclosure.3mf
│   └── images/
├── Bastion 350/
│   ├── NODE-Bastion-350-Enclosure.3mf
│   └── images/
└── Citadel 600/
    ├── NODE-Citadel-600-Enclosure.3mf
    └── images/
```

---

## Printing

The 3MFs are slicer project files with every part laid out on its plates: the shell, the lid,
the vent shrouds, and on the Bastion and Citadel the PSU rails. They were saved with these
reference settings:

| Setting | Value |
|---|---|
| Material | PETG |
| Nozzle | 0.4 mm |
| Layer height | 0.2 mm |
| Walls | 2 |
| Infill | 15 % |
| Supports | None |

The profile was saved on a Qidi X-Plus 5. Re-slice for your own printer. Any slicer that
reads 3MF will import the geometry.

---

*Wateefy Electronics · NODE Enclosures · Rev 1.0*
