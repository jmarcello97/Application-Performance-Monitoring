int __cdecl main(int argc, const char **argv, const char **envp)
{
  unsigned int v4; // eax
  int seconds; // [rsp+10h] [rbp-50h]
  int v6; // [rsp+18h] [rbp-48h]
  int v7; // [rsp+1Ch] [rbp-44h]
  _QWORD *ptr; // [rsp+20h] [rbp-40h]
  int v9; // [rsp+2Ch] [rbp-34h]
  int j; // [rsp+48h] [rbp-18h]
  int i; // [rsp+4Ch] [rbp-14h]
  int k; // [rsp+4Ch] [rbp-14h]

  if ( argc == 2 )
  {
    v4 = time(0LL);
    srand(v4);
    while ( 1 )
    {
      v9 = rand() % 20001 + 30000;
      ptr = malloc(8LL * v9);
      for ( i = 0; i < v9; ++i )
        ptr[i] = malloc(4LL * (v9 + 1));
      v7 = rand() % 16 + 30;
      v6 = time(0LL);
      for ( j = (unsigned __int64)time(0LL) - v6; j < v7; j = (unsigned __int64)time(0LL) - v6 )
        ;
      seconds = rand() % 31 + 60;
      for ( k = 0; k < v9; ++k )
        free((void *)ptr[k]);
      free(ptr);
      sleep(seconds);
    }
  }
  puts("You must provide an IP address!");
  return 1;
}
