#include <lua.h>
#include <lauxlib.h>

#define __METATABLE_NAME  "LuaBook.array"

typedef struct NumArray {
    int size;
    double values[1];  /* variable part */
} NumArray;

static int newarray (lua_State *L) {
    int n = luaL_checkint(L, 1);
    size_t nbytes = sizeof(NumArray) + (n - 1)*sizeof(double);
    NumArray *a = (NumArray *)lua_newuserdata(L, nbytes);
    
    luaL_getmetatable(L, __METATABLE_NAME);
    lua_setmetatable(L, -2);

    a->size = n;
    return 1;  /* new userdatum is already on the stack */
}

static NumArray *checkarray (lua_State *L) {
    void *ud = luaL_checkudata(L, 1, __METATABLE_NAME);
    luaL_argcheck(L, ud != NULL, 1, "`array' expected");
    return (NumArray *)ud;
}
static double *getelem (lua_State *L) {
    NumArray *a = checkarray(L);
    int index = luaL_checkint(L, 2);
    
    luaL_argcheck(L, 1 <= index && index <= a->size, 2,
                     "index out of range");
    
    /* return element address */
    return &a->values[index - 1];
}

static int setarray (lua_State *L) {
    double value = luaL_checknumber(L, 3);
    *getelem(L) = value;
    return 0;
}

static int getarray (lua_State *L) {
    lua_pushnumber(L, *getelem(L));
    return 1;
}

static int getsize (lua_State *L) {
    NumArray *a = checkarray(L);
    lua_pushnumber(L, a->size);
    return 1;
}

static int array2string (lua_State *L) {
    NumArray *a = checkarray(L);
    lua_pushfstring(L, "array<%p>(%d)", a, a->size);
    return 1;
}

static const struct luaL_reg arraylib_f [] = {
    {"new", newarray},
    {NULL, NULL}
};
    
static const struct luaL_reg arraylib_m [] = {
    {"set", setarray},
    {"get", getarray},
    {"size", getsize},
    {"__tostring", array2string},
    {NULL, NULL}
};

int luaopen_libnum_array (lua_State *L) {
    luaL_newmetatable(L, __METATABLE_NAME);
    lua_pushstring(L, "__index");
    lua_pushvalue(L, -2);  /* pushes the metatable */
    lua_settable(L, -3);  /* metatable.__index = metatable */
    
    // Register methods directly into the metatable
    luaL_openlib(L, NULL, arraylib_m, 0);
    
    luaL_openlib(L, "array", arraylib_f, 0);
    return 1;
}