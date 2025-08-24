# Compiler and linker configuration
CXX = /opt/homebrew/bin/g++-15
CXXFLAGS = -Wall -Wextra -std=c++17 -fopenmp \
           -I/opt/homebrew/opt/eigen/include/eigen3 \
           -Iinclude \
           -I/opt/homebrew/opt/libomp/include
LDFLAGS = -L/opt/homebrew/opt/libomp/lib -fopenmp

# Directory configuration
SRC_DIR = src
BIN_DIR = bin
OBJ_DIR = $(BIN_DIR)/obj

# Find all .cpp files in SRC_DIR
SOURCES = $(shell find $(SRC_DIR) -name '*.cpp')
OBJECTS = $(SOURCES:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# Target executable
TARGET = $(BIN_DIR)/price_opt

# Phony targets
.PHONY: all clean directories

all: directories $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) $(LDFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@

directories:
	@mkdir -p $(BIN_DIR)
	@mkdir -p $(OBJ_DIR)

clean:
	@rm -rf $(BIN_DIR)
