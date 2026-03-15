static unsigned short* const VGA_MEMORY = (unsigned short*)0xB8000;
static const int VGA_WIDTH = 80;
static const int VGA_HEIGHT = 25;

static int str_len(const char* str) {
    int len = 0;
    while (str[len] != 0) {
        len++;
    }
    return len;
}

static unsigned short vga_entry(char c, unsigned char color) {
    return (unsigned short)c | ((unsigned short)color << 8);
}

void clear_screen(unsigned char color) {
    int i;
    for (i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++) {
        VGA_MEMORY[i] = vga_entry(' ', color);
    }
}

void put_char_at(char c, int x, int y, unsigned char color) {
    if (x < 0 || x >= VGA_WIDTH || y < 0 || y >= VGA_HEIGHT) {
        return;
    }
    VGA_MEMORY[y * VGA_WIDTH + x] = vga_entry(c, color);
}

void print_at(const char* str, int x, int y, unsigned char color) {
    int i = 0;
    while (str[i] != 0) {
        put_char_at(str[i], x + i, y, color);
        i++;
    }
}

void print_center(const char* str, int y, unsigned char color) {
    int x = (VGA_WIDTH - str_len(str)) / 2;
    if (x < 0) {
        x = 0;
    }
    print_at(str, x, y, color);
}

void draw_progress_bar(int x, int y, int width, int percent, unsigned char color) {
    int i;
    int fill;

    if (percent < 0) {
        percent = 0;
    }
    if (percent > 100) {
        percent = 100;
    }

    fill = (width * percent) / 100;

    put_char_at('[', x, y, color);
    put_char_at(']', x + width + 1, y, color);

    for (i = 0; i < width; i++) {
        char c = (i < fill) ? '#' : '-';
        put_char_at(c, x + 1 + i, y, color);
    }
}

void print(const char* str) {
    print_at(str, 0, 0, 0x07);
}