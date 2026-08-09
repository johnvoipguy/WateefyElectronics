# NODE Platform

### Hardware Reference · 8-Channel Addressable LED Controller Family

*Wateefy Electronics*

---

> **The power section is the product. The module is a consumable.**

**Document rev:** 3.0 · **Board rev:** V1a · **Date:** 2026-08-06

---

## Scope

This document covers the hardware common to every board in the NODE family — power
architecture, input protection, output stage, environmental data and build process. It applies
to **NODE Mini**, **NODE Flex** and **NODE Backbone** alike.

What differs between variants — the MCU module, the logic rail source, board dimensions,
GPIO mapping and per-board accepted limitations — is documented in each board's own
**Variant Specification**. Where a variant departs from anything stated here, its supplement
says so explicitly in *Deltas from the Platform Reference*.

Read this document for how the board protects your pixels. Read the supplement for which
board to buy.

---

## 1. Power Architecture


Three separate domains, each on its own copper region:

| Domain | Boundary | What it carries |
|---|---|---|
| **Input (unprotected)** | Screw terminal → ideal-diode stage | Raw supply. Assumed hostile. Transient clamp sits across this node. |
| **Clean (protected)** | Ideal-diode output → main fuse | Reverse-blocked, surge-clamped. Bulk capacitance lives here. |
| **Distribution bus (fused)** | Main fuse → 8 channel fuses + logic regulator | Everything downstream taps this bus through its own fuse. |


## 2. Input & Protection


| Parameter | Value | Notes |
|---|---|---|
| Input voltage range | 5 – 48 VDC | Single rail, powers both pixels and onboard logic |
| Input connector | WECO 158-A-111/02, 2-pole screw terminal | 57 A / 10 mm² rated; 30 A design maximum = 53% of rating |
| Maximum continuous current | 30 A | At standard 1 oz outer copper — no copper upgrade required |
| Main fuse | 30 A mini blade, Keystone 3568 holder | Holder rated 30 A / 500 V; user-replaceable |
| Reverse-polarity protection | LM74700-Q1 ideal-diode controller + CSD18540Q5B | FET held off under reverse input; no current path to load; non-sacrificial and self-recovering |
| Pass element | CSD18540Q5B NexFET | 60 V V<sub>DS</sub>, 205 A I<sub>D</sub>, ~2.2 mΩ R<sub>DS(on)</sub> — 15% of current rating at 30 A design load |
| Input transient clamp | SMCJ48CA bidirectional TVS, 1500 W | 48 V standoff, 53.3 V breakdown; conducts in neither direction at rated input |
| Bulk capacitance | 2 × 1000 µF, 63 V | On the clean rail, downstream of the ideal diode |
| Ideal-diode charge pump | 22 nF, 100 V | VCAP to ANODE, floating — not referenced to ground |
| Ideal-diode hold-up | 47 µF electrolytic, 80 V | Between controller and pass FET, per reference design |
| Polarity indication | Anti-parallel green/red LED pair | Green = correct, red = reversed; shared 1 kΩ limit; LED reverse stress 2 V against 5 V rating |

**Voltage headroom summary:** **36 V nominal, 48 V absolute maximum.** Every component in the power path is rated **63 V or above**; every semiconductor is **60 V or above**.

**Derating against input voltage.** Utilization of each component's own rating. **5 V, 12 V and 24 V are the mainstream pixel voltages** and are shown in bold:

| Component | Rating | **5 V** | **12 V** | **24 V** | 36 V | 48 V |
|---|---|---|---|---|---|---|
| Bulk input capacitors | 63 V | **8 %** | **19 %** | **38 %** | 57 % | 76 % |
| Channel output caps | 80 V | **6 %** | **15 %** | **30 %** | 45 % | 60 % |
| Ideal-diode hold-up | 80 V | **6 %** | **15 %** | **30 %** | 45 % | 60 % |
| Buck input electrolytic | 80 V | **6 %** | **15 %** | **30 %** | 45 % | 60 % |
| HV-plane ceramics | 100 V | **5 %** | **12 %** | **24 %** | 36 % | 48 % |
| Ideal-diode controller | 65 V | **8 %** | **18 %** | **37 %** | 55 % | 74 % |
| Pass MOSFET V<sub>DS</sub> | 60 V | **8 %** | **20 %** | **40 %** | 60 % | 80 % |
| Buck regulator V<sub>IN</sub> | 80 V | **6 %** | **15 %** | **30 %** | 45 % | 60 % |

At the **36 V nominal** rating no part on the plane exceeds 60 % of its own limit. At the **48 V absolute maximum** nothing exceeds 80 %. On the 5 V, 12 V and 24 V strips that carry the overwhelming majority of installations, the entire plane runs under 40 %.


## 3. Outputs


| Parameter | Value | Notes |
|---|---|---|
| Channels | 8 | Independent, individually fused — no shared fuses |
| Output connector | Phoenix MKDS-series 3-pole, per channel | V+ / DATA / GND; 12 A rated → 63% at the 7.5 A fitted fuse, 83% at the 10 A maximum |
| Per-channel fuse | 7.5 A mini blade fitted, 10 A maximum — Keystone 3568 holder | 25% of holder rating at 7.5 A, 33% at 10 A; user-replaceable |
| Level translation | SN74HCT541 octal buffer, DIP-20 socket | 3.3 V drive vs 2.0 V V<sub>IH</sub> = 1.3 V margin |
| Data series resistance | 330 Ω, axial through-hole, per channel | Limits fault current back into the buffer |
| Data ESD protection | PESD5V0F1BL, per channel, connector side | 0.4–0.55 pF junction capacitance; RC ≈ 181 ps — no measurable effect on WS281x bit timing |
| Data drive current | ≈ 4 mA per channel | 67% of ±6 mA buffer rating |
| Buffer supply current | ≈ 45 mA total | 64% of 70 mA device maximum |
| Per-channel decoupling | 47 µF electrolytic 80 V + 100 nF ceramic 100 V | Local to each output connector |
| Channel activity indication | One LED per channel, 470 Ω limited | ≈ 5 mA, 25% of LED rating |


## 4. Environmental & Compliance


| Parameter | Value |
|---|---|
| Operating temperature | −20 °C to +60 °C *(design target; not qualification tested)* |
| Substrate rating | UL-recognized, JLC-1 marking |
| RoHS | Compliant |
| Workmanship | IPC Class 2 |
| Electrical test | Flying-probe, 100% of boards |
| Traceability | 2D barcode serial number, per board |


## Mounting & Enclosure


**No enclosure is included, and none is planned.** This is the norm in this segment — bare board, mounted in whatever the installation already uses: a CG1500, a DIN rail, a weatherproof box, a plywood backer.

What NODE adds instead is **conformal coating**, applied after assembly with connectors, sockets, fuse clips, and switches masked. Competing boards in this class ship uncoated. A coated board in a vented enclosure tolerates condensation and humidity in a way a bare board does not, which matters for the seasonal outdoor installs this was built for.

Four corner mounting holes are provided. *Hole spacing and a downloadable mount STL: to be published at first article.*

---


## Build & Assurance


- **Fabrication** — 4-layer, 1.6 mm, high-T<sub>g</sub> substrate, ENIG finish, epoxy-filled and capped vias, IPC Class 2 workmanship
- **Assembly** — professional SMT assembly, flying-probe electrical test on 100% of boards
- **Traceability** — 2D barcode serial on every board; UL-recognized substrate marking
- **Coating** — conformal coating applied after assembly, with connectors, sockets, fuse clips, and switches masked
- **Design review** — every net verified against manufacturer datasheets; schematics independently reviewed by two automated analysis passes with human verification of every finding

---

