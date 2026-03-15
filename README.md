# NovaOS

## Build (MSYS2)

You need a 32-bit ELF cross toolchain in PATH:
- `i686-elf-gcc`, `i686-elf-ld`, `i686-elf-objcopy` (objcopy optional)

Install the basics in MSYS2 (example):

```
pacman -S --needed make nasm
```

Then build:

```
make
```

Output:
- `build/nova.img`

## Run in VirtualBox

1. Create a new VM (Type: Other, Version: Other/Unknown 32-bit).
2. Disable EFI in the VM settings.
3. Attach the floppy image `build/nova.img`:
	- Settings -> Storage -> Add Floppy Controller -> Choose a disk -> select the image.
4. Start the VM.

## Run in QEMU (optional)

```
qemu-system-i386 -fda build/nova.img
```
