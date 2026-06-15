#!/bin/bash

# Loop through all files that start with "example_file" in the current directory
for file in example_file*; do

    # Check if the current file is exactly "example_file1"
    if [[ "${file}" == "example_file1" ]]; then
        echo "Skipping the first file"

        # Skip to the next iteration without processing this file
        continue
    fi

    # Write a random number to the current file
    echo "${RANDOM}" > "${file}"

done