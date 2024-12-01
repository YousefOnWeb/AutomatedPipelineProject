#!/bin/bash

# Run unit tests using pytest
echo "Running unit tests..."
pytest app/tests/test_unit.py --maxfail=5 --disable-warnings --tb=short > test_results.log

# Run Selenium-based UI tests
echo "Running UI tests..."
pytest app/tests/test_ui.py --maxfail=5 --disable-warnings --tb=short >> test_results.log

# Check if tests passed
if grep -q "FAILED" test_results.log; then
    echo "Tests failed!"
    exit 1
else
    echo "All tests passed!"
fi
