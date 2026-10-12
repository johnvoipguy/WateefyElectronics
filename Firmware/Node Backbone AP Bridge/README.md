# Node Backbone AP Bridge Firmware

> **BETA / IN TESTING.** This firmware is not hardware-validated yet. Bench testing and throughput
> numbers are still to come, and anything on this page can change. For a production install, run
> the standard [Node Backbone firmware](../Node%20Backbone/README.md).

## What it is

A separate WLED build for the NODE Backbone. It is not a setting in the standard Backbone firmware.
It ships under its own release name, `WAVESHARE-S3-ETH-APBRIDGE`, so an OTA update can't swap one
build for the other by accident.

## What it does

The Backbone keeps driving its own pixels over wired Ethernet. It also runs a WiFi access point that
is **bridged straight onto your wired LAN**.

Wireless NODE Mini and NODE Flex boards join that access point like any other WiFi network. From
there they behave like ordinary devices on your wired LAN:

- They get their address from your router's DHCP.
- You can reach them from anywhere on the LAN.
- Your controller software sends to them directly.

A Backbone placed out in the yard can feed nearby wireless boards that are too far from your house
WiFi.

## How it works

- **Pure layer-2 bridge.** The access point and the Ethernet port are joined into a single network
  interface. There is no NAT, no separate subnet and no port forwarding. The Backbone's own address
  belongs to that bridge and comes from DHCP, or from WLED's static IP settings.
- **Same MAC address as the standard build,** so an existing DHCP reservation for the Backbone keeps
  working.
- **The access point is always on.** The Backbone never joins another WiFi network as a client in
  this build.
- **Up to 3 wireless boards by default.** The firmware enforces the limit. It can be raised to 10,
  but every board added shares the same WiFi airtime.
- **No captive portal.** Clients are on the real LAN, so WLED's setup portal at 4.3.2.1 isn't used in
  this build.
- **Never bridged without a key.** If the access point key is empty or shorter than 8 characters,
  the access point is not bridged. It stays a local setup network until a valid key is set, so an
  open access point never puts anyone on your LAN.

### Protocol advice

- **Use DDP, unicast,** to each wireless board. This is the recommended setup.
- **E1.31/sACN and Art-Net work but are not recommended over WiFi.** Multicast and broadcast traffic
  from the wired LAN is flooded onto the access point and eats airtime the wireless boards need.
- **Wired-side throughput is limited by the Backbone's SPI-attached Ethernet controller.**

### Throughput (theoretical, NOT validated)

> ⚠️ **These are design targets only. They have not been bench tested.** Real numbers will
> replace them after bench testing, and they may come in lower.

The Backbone and every wireless board share one network budget, like a power supply's watt
budget.

**Backbone network budget:** up to 300,000 pixel-frames/sec (DDP, RGB)

Math: 8 Mbps usable wire rate ÷ 3 bytes per RGB pixel, after DDP/UDP/IP/Ethernet packet
overhead (~5%), ≈ 316,000, rounded down to 300,000. RGBW pixels are 4 bytes, so about 225,000.

Add up pixels × FPS for the Backbone plus every wireless board, and stay under the budget.

| FPS | Total pixels (Backbone + wireless) |
|---|---|
| 40 | up to ~7,500 |
| 30 | up to ~10,000 |
| 20 | up to ~15,000 |

Up to 3 wireless boards per Backbone; need more, add a Backbone. Keep wireless boards within about
10 ft (3 m) line of sight of the Backbone.

## Configure it

Once flashed, the Backbone comes up on your wired LAN as usual. Open WLED and go to
**Settings → Usermods → ApBridge**. Every setting lives on that page:

| Setting | Default | What it does |
|---|---|---|
| Bridge | On | Bridge the access point onto Ethernet. Off makes the board behave like the standard Backbone build |
| SSID | `WLED_BRIDGE` | Access point network name |
| Key | `876543210` | Access point key, 8–64 characters. Write-only; leave it empty to keep the current key |
| Channel | 6 | WiFi channel, 1–13 |
| Hidden | Off | Hide the SSID |
| Always on | On | Keep the access point on. Forced on while Bridge is on |
| STA cap | 3 | Maximum number of wireless boards, 1–10 |
| No 11b | Off | Disable slow 802.11b rates on the access point |

**Saving any change reboots the Backbone.**

The SSID and key are the same values shown on WLED's WiFi settings page, so the two pages stay in
sync. **Change the default key on every install.** It is the same on every unit.

To set a static IP for the Backbone, use WLED's normal static IP fields under **Settings → WiFi
Setup**.

### Joining a wireless board

On each NODE Mini or Flex, open **Settings → WiFi Setup** and enter the Backbone's SSID and key as
the network to join. Leave the board on DHCP, or give it a static address on your LAN subnet.

## Download

Not published yet. Once a beta build is released it will be linked here and on the
[releases page](https://github.com/johnvoipguy/WateefyElectronics/releases).

Flashing requires `esptool`. See the [firmware directory](../README.md) for the procedure.

<sub>© 2026 Wateefy Electronics. Specifications subject to change.</sub>
