int __cdecl main(int argc, const char **argv, const char **envp)
{
  unsigned int v4; // eax
  FILE *v5; // ST28_8
  int v6; // [rsp+20h] [rbp-20h]
  int v7; // [rsp+24h] [rbp-1Ch]
  FILE *stream; // [rsp+28h] [rbp-18h]
  int i; // [rsp+3Ch] [rbp-4h]

  if ( argc == 2 )
  {
    v4 = time(0LL);
    srand(v4);
    v5 = fopen("/tmp/tmp.txt", "w");
    fclose(v5);
    v7 = time(0LL);
    sleep(0x3Cu);
    do
    {
      stream = fopen("/tmp/tmp.txt", "aw");
      v6 = rand() % 500001 + 500000;
      for ( i = 0; i < v6; ++i )
        fwrite("I will build a great file!\n", 1uLL, 0x1BuLL, stream);
      fclose(stream);
      sleep(1u);
    }
    while ( (signed int)((unsigned __int64)time(0LL) - v7) <= 840 );
    system("rm /tmp/tmp.txt");
    while ( 1 )
      ;
  }
  puts("You must provide an IP address!");
  return 1;
}
