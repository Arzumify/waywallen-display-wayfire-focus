# waywallen-kde

Plasma 6 Wallpaper plugin for `waywallen`.  

## Runtime dependencies

- `waywallen` daemon.  
- The `waywallen-display` library with qml

## install
```sh
kpackagetool6 --type Plasma/Wallpaper -i package
# or -u to upgrade, -r to remove
```

After upgrading, restart plasmashell so the new QML module is picked up:

```sh
systemctl --user restart plasma-plasmashell.service
```

### X11 sessions (e.g. Steam Deck)

On X11, plasmashell needs the EGL XCB backend to import the wallpaper's
DMA-BUFs. Add a systemd user drop-in at
`~/.config/systemd/user/plasma-plasmashell.service.d/override.conf`:

```ini
[Service]
Environment=QT_XCB_GL_INTEGRATION=xcb_egl
```

Then reload and restart:

```sh
systemctl --user daemon-reload
systemctl --user restart plasma-plasmashell.service
```
