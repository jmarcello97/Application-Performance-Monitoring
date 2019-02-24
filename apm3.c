int __cdecl main(int argc, const char **argv, const char **envp)
{
  int result; // eax
  unsigned int v4; // eax
  int v5; // eax
  signed int v6; // eax
  signed int v7; // [rsp+14h] [rbp-2Ch]
  int v8; // [rsp+18h] [rbp-28h]
  int v9; // [rsp+34h] [rbp-Ch]
  int seconds; // [rsp+38h] [rbp-8h]
  int v11; // [rsp+3Ch] [rbp-4h]

  v8 = 0;
  v7 = 1;
  if ( argc == 2 )
  {
    v4 = time(0LL);
    srand(v4);
    seconds = rand() % 16 + 30;
    v9 = rand() % 16 + 60;
    v11 = time(0LL);
    while ( 1 )
    {
      v5 = v8++;
      if ( !v5 )
      {
        v6 = v7++;
        if ( !v6 )
          break;
      }
      if ( (signed int)((unsigned __int64)time(0LL) - v11) > v9 )
      {
        sleep(seconds);
        seconds = rand() % 16 + 30;
        v9 = rand() % 16 + 60;
        v11 = time(0LL);
      }
    }
    result = 0;
  }
  else
  {
    puts("You must provide an IP address!");
    result = 1;
  }
  return result;
}
