# NovaOS

## Build (MSYS2)

You need a 32-bit ELF cross toolchain in PATH:
- `i686-elf-gcc`, `i686-elf-ld`, `i686-elf-objcopy` (objcopy optional)

Install the basics in MSYS2 (example):

```
pacman -S --needed make nasm
```

Install an ISO creation tool (recommended):

```
pacman -S --needed xorriso
```

Then build:

```
make
```

Output:
- `build/nova.img`

## Build ISO

Create a bootable ISO from the floppy image:

```
make iso
```

If you want to clean build artifacts:

```
make clean
```

`make clear` also works as an alias.

Output:
- `build/nova.iso`

## Run in VirtualBox

1. Create a new VM (Type: Other, Version: Other/Unknown 32-bit).
2. Disable EFI in the VM settings.
3. Attach one image:
	- Floppy: `build/nova.img` via Floppy Controller, or
	- ISO: `build/nova.iso` via Optical Drive.
4. If using ISO, set boot order to Optical first.
5. Start the VM.

## Run in QEMU (optional)

```
qemu-system-i386 -fda build/nova.img
```

Run ISO in QEMU (optional):

```
qemu-system-i386 -cdrom build/nova.iso
```
