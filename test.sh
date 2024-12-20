#!/bin/bash

# Colors for test output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Test counter
TESTS_RUN=0
TESTS_PASSED=0

# Test function
run_test() {
    local test_name="$1"
    local test_command="$2"
    local expected_exit_code="$3"
    local expected_output="$4"

    echo "Running test: $test_name"
    TESTS_RUN=$((TESTS_RUN + 1))

    # Run the command and capture output and exit code
    output=$(eval "$test_command" 2>&1)
    exit_code=$?

    # Check exit code
    if [ "$exit_code" != "$expected_exit_code" ]; then
        echo -e "${RED}❌ Failed: Expected exit code $expected_exit_code, got $exit_code${NC}"
        return 1
    fi

    # Check output if expected output is provided
    if [ -n "$expected_output" ]; then
        if [[ "$output" == *"$expected_output"* ]]; then
            echo -e "${GREEN}✓ Passed${NC}"
            TESTS_PASSED=$((TESTS_PASSED + 1))
            return 0
        else
            echo -e "${RED}❌ Failed: Expected output containing '$expected_output', got '$output'${NC}"
            return 1
        fi
    fi

    echo -e "${GREEN}✓ Passed${NC}"
    TESTS_PASSED=$((TESTS_PASSED + 1))
    return 0
}

# Create test directory and files
TEST_DIR=$(mktemp -d)
touch "$TEST_DIR/test_file.txt"
mkdir "$TEST_DIR/test_dir"

# Test cases
echo "Starting tests..."

# Test 1: No arguments
run_test "No arguments provided" \
    "./windsurf" \
    1 \
    "Usage: windsurf <path>"

# Test 2: Non-existent path
run_test "Non-existent path" \
    "./windsurf /path/that/does/not/exist" \
    1 \
    "Error: Path does not exist"

# Test 3: Valid file path
run_test "Valid file path" \
    "./windsurf $TEST_DIR/test_file.txt" \
    0 \
    ""

# Test 4: Valid directory path
run_test "Valid directory path" \
    "./windsurf $TEST_DIR/test_dir" \
    0 \
    ""

# Test installation script
echo "Testing installation script..."

# Test 5: Installation script exists
run_test "Installation script exists" \
    "[ -f ./install.sh ]" \
    0 \
    ""

# Test 6: Installation script is executable
run_test "Installation script is executable" \
    "[ -x ./install.sh ]" \
    0 \
    ""

# Clean up
rm -rf "$TEST_DIR"

# Print summary
echo "----------------------------------------"
echo "Test Summary:"
echo "Tests run: $TESTS_RUN"
echo "Tests passed: $TESTS_PASSED"
echo "Tests failed: $((TESTS_RUN - TESTS_PASSED))"
if [ $TESTS_RUN -eq $TESTS_PASSED ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed${NC}"
    exit 1
fi
