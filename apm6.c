int __cdecl main(int argc, const char **argv, const char **envp)
{
  unsigned int v4; // eax
  int seconds; // ST24_4
  int v6; // ST1C_4
  _QWORD *ptr; // [rsp+28h] [rbp-38h]
  int v8; // [rsp+34h] [rbp-2Ch]
  int i; // [rsp+38h] [rbp-28h]
  int j; // [rsp+4Ch] [rbp-14h]

  if ( argc == 2 )
  {
    v4 = time(0LL);
    srand(v4);
    for ( i = time(0LL); ; v6 = (unsigned __int64)time(0LL) - i )
    {
      v8 = rand() % 501 + 500;
      ptr = malloc(8LL * v8);
      for ( j = 0; j < v8; ++j )
        ptr[j] = malloc(4LL * (v8 + 1));
      seconds = rand() % 6 + 10;
      free(ptr);
      sleep(seconds);
    }
  }
  puts("You must provide an IP address!");
  return 1;
}
