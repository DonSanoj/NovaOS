void print (char* str) 
{
    char* video = (char*) 0xb8000;

    int i = 0;

    while (str[i] != 0)
    {
        video[i*2] = str[i];
        video[i*2 + 1] = 0x07;
        i++;
    }
}