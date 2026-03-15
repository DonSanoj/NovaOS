ASM=nasm

SRC_DIR=src
BUILD_DIR=build

all:
    nasm boot/boot.asm -f bin -o build/boot.bin
    gcc -ffreestanding -c kernel/kernel.c -o build/kernel.o