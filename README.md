# Uzbek (Latin) Keyboard Layout

This repository contains an enhanced Uzbek Latin keyboard layout for Linux, designed to improve the typing experience by providing quick access to special characters used in the language.

## About the keyboard layout

The provided installer adds these keyboard layout variants:

1.  It installs the **Uzbek layout** with a complete, enhanced set of characters and dead keys for full typographic control.
2.  It installs **Uzbek (US) layout** to ensure the most critical Uzbek characters are accessible for people used to standard US keyboard.
3.  It install **Uzbek (2023) layout** based on the latest changes to Uzbek alphabet in 2023.


### 1. Uzbek Layout

The main focus of this layout is on the following details:

- The [ʻOkina](https://en.wikipedia.org/wiki/%CA%BBOkina) (modifier letter turned comma) used for the letters Oʻ and Gʻ has been placed instead of the apostrophe. This symbol is typographically more correct than a single quote mark: it is not a punctuation mark and does not break the word.

- [The Modifier Letter Apostrophe](https://en.wikipedia.org/wiki/Modifier_letter_apostrophe) (which is used for the glottal stop/tutuq belgisi) has been placed on the grave accent key (the 'Esc' key's neighbor) instead of the 'gravis' (grave accent symbol). This symbol is also typographically correct, similar to the one above.

- This layout also includes letters used in the 1993 Uzbek alphabet and the current Turkish, Azerbaijani, and Turkmen alphabets: **Ŏ, Ğ, Ş, Ç, İ** (these are typed using the AltGr key)."

All other changes are shown in the illustration below:

![Uzbek keyboard layout](./.github/assets/keyboard-layout.png)

- 1-level: Black colored keys.
- 2-level: Uppercase of 1-level. Use SHIFT key.
- 3-level: Purple colored keys. Use Alt Gr (right Alt) key.
- 4-level: Uppercase of 3-level. Use SHIFT+ALT Gr (right Alt) key. Blue colored keys.

### 2. Uzbek (US) Layout

This layout is essentially the **US QWERTY layout** with two critical Uzbek characters mapped to the third level (Alt Gr).

| Key | Modifier | Output Character | Unicode | Purpose |
| :--- | :--- | :--- | :--- | :--- |
| **Apostrophe (`'`)** | AltGr (Level 3) | **ʻOkina** | U+02BB | Used in **Oʻ** and **Gʻ** (Modifier Letter Turned Comma). |
| **Grave Accent (`` ` ``)** | AltGr (Level 3) | **Tutuq Belgisi** | U+02BC | Used for the glottal stop (Modifier Letter Apostrophe). |

**Why this modification?**
This ensures that users who prefer to use the familiar US layout as their primary input method can still access the essential, typographically correct Uzbek characters instantly.

### 3. Uzbek (2023) Layout

This layout is designed to be **forward-compatible** with the major proposed changes to the Uzbek Latin alphabet (as considered in the 2023 draft). This includes mappings for the simpler, **single-character forms** of the digraphs, which are essential for better digital handling (searching, sorting, and display) of the language.

**Single-Character Mapping**

The following keys have been mapped to the proposed single-character letters:

| Key Position | 2023 Draft Character | Character Name |
| --- | --- | --- |
| W Key | Ş / ş | S with Cedilla |
| \[ Key | Õ / õ | O with Tilde |
| \] Key | Ğ / ğ | G with Breve |

## Installation

The provided `install.sh` script automates the installation process by copying the layout file and updating the system's XKB configuration.

### Prerequisites

You must be using a Linux distribution that uses the XKB system, such as Ubuntu, Debian, or Fedora.

### Steps

1. Clone the repository:

```bash
git clone https://github.com/itsbilolbek/uzbek-linux-keyboard.git
cd uzbek-linux-keyboard
```

2. Run the installation script:

```bash
chmod +x install.sh
sudo ./install.sh
```

The script will copy the layout file to the correct system directory, add an entry to the evdev.xml file, and reconfigure your keyboard settings.

## Usage

After a successful installation, you may need to **log out and log back in** for the new layout to appear in your system settings.

To select the layout:

1. Go to your system's **Settings > Keyboard** (or **Input Sources**).

2. Add a new keyboard layout.

3. Search for **"Uzbek"** and add it to your list of input sources.

## Contributing

If you find an issue or have suggestions for improvements, feel free to open a pull request or an issue on this repository.

## Customizing and Extending This Layout

If you want to modify this layout, add new symbols, or create your own variant, here are the essential steps and resources based on how this layout was built.

### Key Components of an XKB Layout

The core of this project lies in one file that defines the keyboard's behavior:

- **Symbols File:**

    - **Location:** `uz` (in the root of this repository)

    - **Purpose:** This file is copied to `/usr/share/X11/xkb/symbols/uz` and defines what character each physical key produces under different modifier keys (Shift, AltGr).

### Understanding Key Definitions

The keys in the `uz` file are defined using a structured format for up to four "levels":

```
key <KEY_CODE> { [ Level 1, Level 2, Level 3, Level 4 ] };
```

| Level | Modifier | Meaning | Example for key `E`
| --- | --- | --- | --- |
| 1 | None | Normal keypress | `e`
| 2 | `Shift` | Shift + Key | `E`
| 3 | `AltGr` | AltGr (Right Alt) + Key | `EuroSign` (€)
| 4 | `AltGr` + `Shift` | `AltGr + Shift + Key | `cent` (¢)

### How to Add/Change Characters

1. **Find the Keycode:** Use the XKB keycode (e.g., `<AD03>` for `E`) to locate the key you want to modify in the `uz` file.

2. **Use Keysyms or Unicode:**

    - **Keysym Name:** For standard characters, use the XKB symbolic name (e.g., registered, EuroSign).

    - **Unicode Value:** For less common or non-standard characters (especially when keysyms fail, like for ‰), use the explicit Unicode value (e.g., `U2030` for the per mille sign).

    - **Dead Keys:** To add an accent, use a dead key keysym (e.g., `dead_acute`, `dead_caron`).

3. **Test Your Changes:** Use the xkbcomp tool to check your syntax before running the installer:

4. **Install/Update:** Rerun the `sudo ./install.sh` script to copy the updated `uz` file and reload the system configuration.

## Attribution and License

This project incorporates code and inspiration from the following open-source projects, which are greatly appreciated.

### Oʻzbekcha tipografik klaviatura terilmalari

* **Source:** [Farhodjon's uzbek typography layouts](https://github.com/far5n10v/uzbek-typography-layouts)
* **License:** MIT License
* **Notes:** The core structure and syntax for the key mappings (Levels 2, 3 and 4) were adapted from this project's symbols file.

Please see the project's main **[LICENSE](LICENSE)** file for the full copyright and permission notices.

