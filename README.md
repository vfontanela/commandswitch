# Command Switch

A simple KDE Plasma 6 widget that runs one command when switched **ON** and another command when switched **OFF**.

It intentionally does **not** check system state, parse exit codes, or try to synchronize with reality. It is just a configurable visual switch for two commands.

## Features

- Configurable ON command
- Configurable OFF command
- Configurable ON/OFF notification title and message
- Configurable ON/OFF text
- Configurable ON/OFF icon names
- Two appearances:
  - Box button
  - Sliding toggle

## Example: Tailscale exit node

ON command:

```bash
sudo tailscale set --exit-node=bento
```

OFF command:

```bash
sudo tailscale set --exit-node=
```

ON notification:

```text
Bento
Exit node ativado
```

OFF notification:

```text
Bento
Exit node desativado
```

## Install from source

From this repository root:

```bash
kpackagetool6 --type Plasma/Applet --install package
```

If already installed:

```bash
kpackagetool6 --type Plasma/Applet --upgrade package
```

Restart Plasma if needed:

```bash
systemctl --user restart plasma-plasmashell
```

## Package a .plasmoid file

From this repository root:

```bash
cd package
zip -r ../command-switch-0.3.0.plasmoid .
```

Then install:

```bash
kpackagetool6 --type Plasma/Applet --install command-switch-0.3.0.plasmoid
```

## Philosophy

Command Switch is intentionally dumb.

It does not ask whether the system is really ON or OFF. It does not parse command output. It simply runs the configured ON command when switched on and the configured OFF command when switched off.

That makes it useful for scripts, VPN commands, Docker actions, systemd services, DNS toggles, proxy toggles, and other personal automations.

## License

GPL-3.0-or-later.
