extern void clear_screen(unsigned char color);
extern void print_center(const char* str, int y, unsigned char color);
extern void print_at(const char* str, int x, int y, unsigned char color);
extern void draw_progress_bar(int x, int y, int width, int percent, unsigned char color);

static void delay(unsigned int cycles) {
    volatile unsigned int i;
    for (i = 0; i < cycles; i++) {
    }
}

void draw_ui() {
    int percent;

    clear_screen(0x1F);

    print_center("NN   NN   OOO    V     V    AAA", 4, 0x1F);
    print_center("NNN  NN  O   O    V   V    A   A", 5, 0x1F);
    print_center("NN N NN  O   O     V V     AAAAA", 6, 0x1F);
    print_center("NN  NNN  O   O      V      A   A", 7, 0x1F);
    print_center("NN   NN   OOO              A   A", 8, 0x1F);
    print_center("               OPERATING SYSTEM", 9, 0x1F);

    print_center("NOVA OS BOOTING", 11, 0x1E);
    print_center("Loading kernel modules...", 13, 0x1F);

    for (percent = 0; percent <= 100; percent += 5) {
        draw_progress_bar(19, 15, 40, percent, 0x1E);
        delay(1200000);
    }

    print_center("Welcome to NovaOS!", 18, 0x1E);
    print_at("System ready.", 2, 23, 0x1F);
}