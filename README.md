<p align="center">
<img src="./seratux.png" alt="Seratux" style="margin: 20px 0;">
</p>

<p align="center">
<b>Seratux</b> is a collection of scripts to install and configure Serato on Linux.
</p>

## Usage

You need to download the [Serato Windows installer](https://serato.com/dj/pro/downloads). The install script then launch the configure script. 

```bash
# Install and configure
./install.sh /path/to/SeratoDJPro.exe

# Configure only
./configure.sh 
```

## Things to Know

- Wine >= 11 required
- Installation in the `.wine-serato` prefix
- Creation of the Windows registry entry for the `seratodjpro` callback (enables authentication).
- Creation of scripts and a desktop entry for the `xdg-open` callback (also enables authentication).

## Remaining Work

- Support for passthrough to enable MIDI and USB devices to work.
- Support for Spotify and other providers authentication callbacks.
