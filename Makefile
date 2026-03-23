AS=nasm
CC=i686-elf-gcc
LD=i686-elf-ld
MKISOFS?=xorriso -as mkisofs

BUILD_DIR=build

CFLAGS=-ffreestanding -m32 -fno-pie -fno-pic -nostdlib -nostdinc -fno-builtin -fno-stack-protector -Wall -Wextra
LDFLAGS=-m elf_i386 -T kernel/linker.ld

.PHONY: all iso clean clear

all: $(BUILD_DIR)/nova.img

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/boot.bin: bootloader/boot.asm | $(BUILD_DIR)
	$(AS) $< -f bin -o $@

$(BUILD_DIR)/entry.o: kernel/entry.asm | $(BUILD_DIR)
	$(AS) $< -f elf32 -o $@

$(BUILD_DIR)/kernel.o: kernel/kernel.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/kernel.bin: $(BUILD_DIR)/entry.o $(BUILD_DIR)/kernel.o kernel/linker.ld
	$(LD) $(LDFLAGS) -o $@ $(BUILD_DIR)/entry.o $(BUILD_DIR)/kernel.o --oformat binary

$(BUILD_DIR)/nova.img: $(BUILD_DIR)/boot.bin $(BUILD_DIR)/kernel.bin
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$(BUILD_DIR)/boot.bin of=$@ conv=notrunc
	dd if=$(BUILD_DIR)/kernel.bin of=$@ bs=512 seek=1 conv=notrunc

$(BUILD_DIR)/nova.iso: $(BUILD_DIR)/nova.img | $(BUILD_DIR)
	$(MKISOFS) -o $@ -b nova.img -c boot.cat $(BUILD_DIR)

iso: $(BUILD_DIR)/nova.iso

clear: clean

clean:
	rm -rf $(BUILD_DIR) 