#include <lua.h>
#include <lauxlib.h>
#include <expat.h>

#define __META_TABLE_NAME "Expat"

typedef struct lxp_userdata {
      lua_State *L;
      XML_Parser parser;          /* associated expat parser */
      int tableref;   /* table with callbacks for this parser */
} lxp_userdata;

static void f_CharData (void *ud, const char *s, int len);
static void f_EndElement (void *ud, const char *name);
static void f_StartElement (void *ud, const char *name, const char **atts);

static int lxp_make_parser (lua_State *L) {
    XML_Parser p;
    lxp_userdata *xpu;
    
    /* (1) create a parser object */
    xpu = (lxp_userdata *)lua_newuserdata(L,
                                     sizeof(lxp_userdata));
    
    /* pre-initialize it, in case of errors */
    xpu->tableref = LUA_REFNIL;
    xpu->parser = NULL;
    
    /* set Its metatable */
    luaL_getmetatable(L, __META_TABLE_NAME);
    lua_setmetatable(L, -2);
    
    /* (2) create the Expat parser */
    p = xpu->parser = XML_ParserCreate(NULL);
    if (!p)
      luaL_error(L, "XML_ParserCreate failed");
    
    /* (3) create and store reference to callback table */
    luaL_checktype(L, 1, LUA_TTABLE);
    lua_pushvalue(L, 1);  /* put table on the stack top */
    xpu->tableref = luaL_ref(L, LUA_REGISTRYINDEX);
    
    /* (4) configure Expat parser */
    XML_SetUserData(p, xpu);
    XML_SetElementHandler(p, f_StartElement, f_EndElement);
    XML_SetCharacterDataHandler(p, f_CharData);
    return 1;
}

static int lxp_parse (lua_State *L) {
    int status;
    size_t len;
    const char *s;
    lxp_userdata *xpu;
   
    /* get and check first argument (should be a parser) */
    xpu = (lxp_userdata *)luaL_checkudata(L, 1, __META_TABLE_NAME);
    luaL_argcheck(L, xpu, 1, "expat parser expected");
   
    /* get second argument (a string) */
    s = luaL_optlstring(L, 2, NULL, &len);
   
    /* prepare environment for handlers: */
    /* put callback table at stack index 3 */
    lua_settop(L, 2);
    lua_getref(L, xpu->tableref);
    xpu->L = L;  /* set Lua state */
   
    /* call Expat to parse string */
    status = XML_Parse(xpu->parser, s, (int)len, s == NULL);
   
    /* return error code */
    lua_pushboolean(L, status);
    return 1;
}

static void f_CharData (void *ud, const char *s, int len) {
    lxp_userdata *xpu = (lxp_userdata *)ud;
    lua_State *L = xpu->L;
    
    /* get handler */
    lua_pushstring(L, "CharacterData");
    lua_gettable(L, 3);
    if (lua_isnil(L, -1)) {  /* no handler? */
      lua_pop(L, 1);
      return;
    }
    
    lua_pushvalue(L, 1);  /* push the parser (`self') */
    lua_pushlstring(L, s, len);  /* push Char data */
    lua_call(L, 2, 0);  /* call the handler */
}


static void f_EndElement (void *ud, const char *name) {
    lxp_userdata *xpu = (lxp_userdata *)ud;
    lua_State *L = xpu->L;

    lua_pushstring(L, "EndElement");
    lua_gettable(L, 3);
    if (lua_isnil(L, -1)) {  /* no handler? */
      lua_pop(L, 1);
      return;
    }

    lua_pushvalue(L, 1);  /* push the parser (`self') */
    lua_pushstring(L, name);  /* push tag name */
    lua_call(L, 2, 0);  /* call the handler */
}

static void f_StartElement (void *ud,
                            const char *name,
                            const char **atts) {
    lxp_userdata *xpu = (lxp_userdata *)ud;
    lua_State *L = xpu->L;
    
    lua_pushstring(L, "StartElement");
    lua_gettable(L, 3);
    if (lua_isnil(L, -1)) {  /* no handler? */
      lua_pop(L, 1);
      return;
    }
    
    lua_pushvalue(L, 1);  /* push the parser (`self') */
    lua_pushstring(L, name);  /* push tag name */
    
    /* create and fill the attribute table */
    lua_newtable(L);
    while (*atts) {
      lua_pushstring(L, *atts++);
      lua_pushstring(L, *atts++);
      lua_settable(L, -3);
    }
    
    lua_call(L, 3, 0);  /* call the handler */
}

static int lxp_close (lua_State *L) {
      lxp_userdata *xpu;
    
      xpu = (lxp_userdata *)luaL_checkudata(L, 1, __META_TABLE_NAME);
      luaL_argcheck(L, xpu, 1, "expat parser expected");
    
      /* free (unref) callback table */
      luaL_unref(L, LUA_REGISTRYINDEX, xpu->tableref);
      xpu->tableref = LUA_REFNIL;
    
      /* free Expat parser (if there is one) */
      if (xpu->parser)
        XML_ParserFree(xpu->parser);
      xpu->parser = NULL;
      return 0;
}

static const struct luaL_reg lxp_meths[] = {
    {"parse", lxp_parse},
    {"close", lxp_close},
    {"__gc", lxp_close},
    {NULL, NULL}
};

static const struct luaL_reg lxp_funcs[] = {
    {"new", lxp_make_parser},
    {NULL, NULL}
};

int luaopen_liblxp (lua_State *L) {
    /* create metatable */
    luaL_newmetatable(L, __META_TABLE_NAME);
    
    /* metatable.__index = metatable */
    lua_pushliteral(L, "__index");
    lua_pushvalue(L, -2);
    lua_rawset(L, -3);
    
    /* register methods */
    luaL_openlib (L, NULL, lxp_meths, 0);
    
    /* register functions (only lxp.new) */
    luaL_openlib (L, "lxp", lxp_funcs, 0);
    return 1;
}
