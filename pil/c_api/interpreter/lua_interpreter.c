#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

static void show_error(lua_State *L, const char *fmt, ...) {
      va_list argp;
      va_start(argp, fmt);
      vfprintf(stderr, fmt, argp);
      va_end(argp);
      lua_close(L);
      exit(EXIT_FAILURE);
}

int main (void) {
  char buff[256];
  int error;
  lua_State *L = lua_open();   /* opens Lua */
  // luaopen_base(L);             /* opens the basic library */
  // luaopen_table(L);            /* opens the table library */
  // luaopen_io(L);               /* opens the I/O library */
  // luaopen_string(L);           /* opens the string lib. */
  // luaopen_math(L);             /* opens the math lib. */
  luaL_openlibs(L);

  while (fgets(buff, sizeof(buff), stdin) != NULL) {
    error = luaL_loadbuffer(L, buff, strlen(buff), "line") ||
            lua_pcall(L, 0, 0, 0);
    if (error) {
      fprintf(stderr, "%s\n", lua_tostring(L, -1));
      // show_error(L, "%s", lua_tostring(L, -1));
      lua_pop(L, 1);  /* pop error message from the stack */
    }
  }

  lua_close(L);
  return 0;
}