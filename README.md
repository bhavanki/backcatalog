# backcatalog

A super-simple ROM manager for RetroPie.

## Why

If you have a lot of ROMs available in RetroPie, the choices can be overwhelming and the experience kind of messy. It can be a nicer experience to have a curated subset of collected ROMs available instead. Backcatalog helps you do that.

## How

After you set up backcatalog, ROMs are stored in a "backcatalog" directory instead of the normal ROM directory where RetroPie normally looks for them. You use the `promote` script to symlink ROMs from the backcatalog into the ROM directory, so that they are available to play. The `demote` script removes the symlinks.

That's pretty much it.

## Installation

Download [install.sh](install.sh) and run it to grab the latest scripts. Do the same later to get any updates.

## Setup

Run `setup_backcatalog.sh` to set up your system for backcatalog management. You need to tell it:

* Your RetroPie home directory, such as _/home/pi/RetroPie_
* Your ROMs directory, such as _/home/pi/RetroPie/roms_
* Where you want the backcatalog directory, such as _/home/pi/RetroPie/backcatalog_

The script creates the backcatalog directory if it doesn't already exist, and then moves all ROMs from the ROMs directory into the backcatalog directory. In this initial state, there are no ROMs available to RetroPie, but you can use `promote` to change that.

The setup also creates a configuration file at _$HOME/.config/backcatalog.sh_ which is needed for `promote` and `demote` to work. If you want to rearrange things later, you can edit that file so the scripts can find where ROMs should go.

## Usage

To make a ROM from the backcatalog available for RetroPie, use `promote`.

```bash
$ promote nes Duck_hunt.nes
Promoting ROMs for nes to /home/pi/RetroPie/roms
Promoted Duck_hunt.nes to /home/pi/RetroPie/roms/nes
```

To make a ROM unavailable for RetroPie, use `demote`.

```bash
$ demote nes Duck_hunt.nes
Demoting ROMs for nes to /home/pi/RetroPie/backcatalog/roms
Demoted Duck_hunt.nes
```

If you have [fzf](https://github.com/junegunn/fzf) installed, the scripts let you use fuzzy search to find the ROM you want. Just pass the name of the system to search through.

```bash
$ promote nes
```

Use the `-h` option for help.

**After promoting or demoting ROMs, restart EmulationStation.**

## License

[MIT](LICENSE)
