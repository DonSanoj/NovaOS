void kernel_main() {

    char *video = (char*) 0xb8000;

    video[0] = 'A';
    video[1] = 0x07;

    video[2] = 'O';
    video[3] = 0x07;

    video[4] = 'S';
    video[5] = 0x07;

    while (1);
    
}