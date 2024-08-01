# Compiler and flags
CC = gcc
CFLAGS = -fPIC -Wall -g -c # -fPIC creates position-independent code for shared libs
LDFLAGS = -shared # For creating a shared library
RM = rm -f 

# for lua
CFLAGS += -I/usr/include/lua5.1
LDFLAGS += -llua5.1

# Target (output) file
TARGET = libnum_array.so

# Source file
SRC = num_array.c

# Object file (intermediate)
OBJ = $(SRC:.c=.o)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

$(OBJ): $(SRC)
	$(CC) $(CFLAGS) $< -o $@

clean:
	$(RM) $(OBJ) $(TARGET)
