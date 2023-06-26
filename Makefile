# Variables
EXEC = prog
BUILD = ./build

# Files
HDR = $(wildcard *.h) $(wildcard */*.h)
SRC = $(wildcard *.c) $(wildcard */*.c)
#OBJ = $(patsubst %.c, $(BUILD)/$(notdir %.o), $(SRC))
OBJ = $(patsubst %.c, $(BUILD)/%.o, $(SRC))

# Compiler variables
CC = gcc
CFLAGS = -Wall

# Targets
all: build_directory $(EXEC)

$(EXEC): $(OBJ)
	@echo
	@echo Creating the executable.
	$(CC) $(CFLAGS) -o $(EXEC) $^
	@echo "Done."

build_directory:
	@if [ ! -d $(BUILD) ]; then \
	echo "Creating the build directory."; \
	mkdir -p $(BUILD); \
	fi

# For .c files accompanied by a .h file. (Most of them).
$(BUILD)/%.o: %.c %.h
	@echo
	@echo "Compiling "$<" into "$@" (With header)..."
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -o $@ -c $<
	@echo "Done."

# For .c files not accompanied by a .h file. (main.c is the only one).
$(BUILD)/%.o: %.c
	@echo
	@echo "Compiling "$<" into "$@" (No header) ..."
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -o $@ -c $<
	@echo "Done."

# Utility
clean:
	@echo Removing the build directory.
	@rm -rf ./build

clear: clean
	@echo Removing the executable.
	@rm -rf $(EXEC)

rebuild: clear all

test:
	@echo Headers: $(HDR)
	@echo Sources: $(SRC)
	@echo Objects: $(OBJ)
