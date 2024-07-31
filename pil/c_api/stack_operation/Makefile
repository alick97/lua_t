.PHONY: all clean
TARGET = stack_operation
SOURCE = stack_operation.c
CFLAGS += -I/usr/include/lua5.1
LDFLAGS += -llua5.1
all: $(TARGET)

$(SOURCE:.c=.o) : $(SOURCE)
	gcc -c $< -o $@ $(CFLAGS)

$(TARGET): $(SOURCE:.c=.o)
	gcc -o $@ $^ $(LDFLAGS)

clean:
	rm -f $(TARGET) $(SOURCE:.c=.o)