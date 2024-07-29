.PHONY: clean all
TARGET = lua_interpreter
SOURCE = lua_interpreter.c
all: $(TARGET)

$(TARGET): $(SOURCE)
	gcc $^ -I/usr/include/lua5.1 -o $(TARGET) -llua5.1

clean:
	rm -f $(TARGET)