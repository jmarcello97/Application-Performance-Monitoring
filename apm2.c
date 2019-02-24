int __cdecl main(int argc, const char **argv, const char **envp)
{
  unsigned int v4; // eax
  char s; // [rsp+10h] [rbp-70h]
  int v6; // [rsp+50h] [rbp-30h]
  int v7; // [rsp+54h] [rbp-2Ch]
  unsigned int v8; // [rsp+58h] [rbp-28h]
  int v9; // [rsp+5Ch] [rbp-24h]
  int v10; // [rsp+60h] [rbp-20h]
  int v11; // [rsp+64h] [rbp-1Ch]
  int v12; // [rsp+68h] [rbp-18h]
  int v13; // [rsp+6Ch] [rbp-14h]
  const char *v14; // [rsp+70h] [rbp-10h]
  int v15; // [rsp+7Ch] [rbp-4h]

  v14 = argv[1];
  v13 = 50000;
  v12 = 64000;
  v11 = 10;
  v10 = 20;
  if ( argc == 2 )
  {
    v4 = time(0LL);
    srand(v4);
    sleep(0x3Cu);
    while ( 1 )
    {
      v9 = time(0LL);
      v15 = 0;
      v8 = rand() % (v12 - v13 + 1) + v13;
      v7 = rand() % (v10 - v11 + 1) + v11;
      while ( v15 < v7 )
      {
        sprintf(&s, "ping -c 1 -s %d %s > /dev/null", v8, v14);
        system(&s);
        sleep(1u);
        v6 = time(0LL);
        v15 = v6 - v9;
      }
      sleep(0x2Du);
    }
  }
  puts("You must provide an IP address!");
  return 1;
}
