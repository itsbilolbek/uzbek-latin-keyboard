# uzbek-latin-keyboard
Uzbek latin keyboard layout with extra symbols

**Note:** the current keyboard layout works only for X11 systems.

To install the keyboard layout follow these steps:

```bash
$ sudo cp uz /usr/share/X11/xkb/symbols/uz
```

Modify `evdev.xml` file:

```bash
$ sudo nano /usr/share/X11/xkb/rules/evdev.xml
```

And add the following between `<layoutList></layoutList>`:

```xml
<layout>
    <configItem>
        <name>uz</name>
        <shortdesc>uz</shortdesc>
        <description>Uzbek (Latin)</description>
    </configItem>
</layout>
```

Run this command:

```bash
$ sudo dpkg-reconfigure xkb-data
```

Restart your computer.