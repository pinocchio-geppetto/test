#soured from: https://github.com/tscott8706/cpp-csv-col-replacer

SRC_EXE = colReplacer
TEST_EXE = testColReplacer

SRC_DIR = src
OBJ_DIR = obj
TEST_DIR = test/src
TEST_OBJ_DIR = test/obj

SRC = $(wildcard $(SRC_DIR)/*.cpp)
SRC_NO_MAIN = $(filter-out $(SRC_DIR)/main.cpp,$(SRC))
SRC_OBJ = $(SRC:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)
SRC_OBJ_NO_MAIN = $(filter-out $(OBJ_DIR)/main.o,$(SRC_OBJ))

TEST = $(wildcard $(TEST_DIR)/*.cpp)
TEST_OBJ = $(TEST:$(TEST_DIR)/%.cpp=$(TEST_OBJ_DIR)/%.o)
TEST_OBJ += $(SRC_OBJ_NO_MAIN)

ALL_OBJ = $(wildcard $(OBJ_DIR)/*.o)
ALL_OBJ += $(wildcard $(TEST_OBJ_DIR)/*.o)

INCLUDES = -Iinclude
TEST_INCLUDES = -Iinclude -Itest/include
CXXFLAGS += -Wall -std=c++11

.PHONY: all test clean

all: $(OBJ_DIR) $(SRC_EXE)

test: $(TEST_OBJ_DIR) $(TEST_EXE)

$(OBJ_DIR):
	mkdir $(OBJ_DIR)

$(TEST_OBJ_DIR):
	mkdir $(TEST_OBJ_DIR)

$(SRC_EXE): $(SRC_OBJ)
	$(CXX) $^ -o $@

$(TEST_EXE): $(TEST_OBJ)
	$(CXX) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(INCLUDES) $(CXXFLAGS) -c $< -o $@

$(TEST_OBJ_DIR)/%.o: $(TEST_DIR)/%.cpp
	$(CXX) $(TEST_INCLUDES) $(CXXFLAGS) -c $< -o $@

clean:
	$(RM) $(ALL_OBJ) $(SRC_EXE) $(TEST_EXE)
