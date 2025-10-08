# uzbek-latin-keyboard
Uzbek latin keyboard layout with extra symbols

**Note:** the current keyboard layout works only for X11 systems.

To install the keyboard layout follow these steps:

```bash
# cp uz /usr/share/X11/xkb/symbols/uz
```

Modify `/usr/share/X11/xkb/rules/evdev.xml` file to include the following:

```xml
<layout>
    <configItem>
        <name>uz</name>
        <shortdesc>uz</shortdesc>
        <description>Uzbek (Latin, enhanced)</description>
    </configItem>
</layout>
```

Run this command:

```
sudo dpkg-reconfigure xkb-data
```

Restart your computer.