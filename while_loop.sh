#!/bin/bash
# Define the filename that will be used as a signal to stop the loop
SIGNAL_TO_STOP_FILE="stoploop"
# Start a while loop that continues as long as the file does not exist
while [[ ! -f "${SIGNAL_TO_STOP_FILE}" ]]; do
    # Notify the user that the signal file has not been found yet
    echo "The file ${SIGNAL_TO_STOP_FILE} does not yet exist..."
    # Inform the user the loop will check again after 2 seconds
    echo "Checking again in 2 seconds..."
    # Wait 2 seconds before checking the file existence again
    sleep 2
done
# Print message once the file is found and the loop condition is satisfied
echo "File was found! Exiting..."

# Test: created the stoploop file in a second terminal using: touch stoploop
# The loop detected the file and exited printing "File was found! Exiting..."