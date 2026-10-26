CC      := gcc
TARGET  := build/app
SRC     := $(wildcard src/*.c)
OBJ     := $(SRC:src/%.c=build/%.o)

CFLAGS  := -std=c11 -Wall -Wextra -g -Iinclude $(shell pkg-config --cflags glfw3 gl)
LDLIBS  := $(shell pkg-config --libs glfw3 gl) -lm

.PHONY: all run clean

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $^ -o $@ $(LDLIBS)

build/%.o: src/%.c | build
	$(CC) $(CFLAGS) -MMD -c $< -o $@

build:
	mkdir -p build

run: $(TARGET)
	./$(TARGET)

clean:
	rm -rf build

-include $(OBJ:.o=.d)
