sudo apt update # Update the list of available packages from the repositories 
sudo apt upgrade # Update all installed packages to their latest versions
sudo apt install parted # Install the "Parted" tool, used to manage disk partitions

#The order to follow is update, upgrade and install

sudo parted -l && -e "\n---\n" && lsblk -f && echo -e "\n---\n" # Display partitions and file with separators, print a visual separator, list the block devices with their file systems, and display another separator again to organize the output.
