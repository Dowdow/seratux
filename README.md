<p align="center">
<img src="./seratux.png" alt="Seratux" style="margin: 20px 0;">
</p>

**Seratux** is a collection of scripts to install and configure Serato on Linux.

## Things to Know

- Wine >= 11 required
- Installation in the `.wine-serato` prefix
- Creation of the Windows registry entry for the `seratodjpro` callback (enables authentication).
- Creation of scripts and a desktop entry for the `xdg-open` callback (also enables authentication).

## Remaining Work

- Support for passthrough to enable MIDI and USB devices to work.
