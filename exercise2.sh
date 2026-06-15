#!/bin/bash
# This line tells the system to run this script using bash

# ============================================================
# exercise2.sh
# Script that audits the blackhatbash branch of the repository
# Checks: files present, line counts, commit schedule, and gives a score
# Based on: Black Hat Bash - No Starch Press
# ============================================================

# --- Colors to make the output easier to read ---
# Each variable stores an ANSI escape code that changes the terminal text color
# These codes work on most Linux terminals including GitHub Codespaces
RED='\033[0;31m'      # Red — used for errors and missing files
GREEN='\033[0;32m'    # Green — used for things that passed correctly
YELLOW='\033[1;33m'   # Yellow — used for warnings and outside-class commits
BLUE='\033[0;34m'     # Blue — used for section headers
CYAN='\033[0;36m'     # Cyan — used for informational values
BOLD='\033[1m'        # Bold — makes text thicker and more visible
RESET='\033[0m'       # Reset — goes back to the default terminal color

# --- Repository settings ---
# The script receives the path to a locally cloned repo as the first argument
# Usage: bash exercise2.sh <path_to_repo_folder>
# Example: bash exercise2.sh repo_luis
BRANCH="blackhatbash"   # Name of the branch we want to audit

# --- Class schedule: Monday and Wednesday, 7:00 AM to 9:00 AM Ecuador time ---
# GitHub stores commit timestamps in UTC (Coordinated Universal Time)
# Ecuador is UTC-5, so we subtract 5 hours inside the loop to get local time
CLASS_DAYS="1 3"   # Days when class happens: 1 = Monday, 3 = Wednesday
                   # These numbers come from the 'date +%u' command (1=Mon ... 7=Sun)
CLASS_START=7      # Class starts at 7:00 AM Ecuador time
CLASS_END=9        # Class ends at 9:00 AM Ecuador time

# --- List of all .sh scripts that should be in the repo ---
# This is a bash array — each item is a script name the student must have submitted
# The audit will check every name in this list and mark it as present or missing
EXPECTED_SCRIPTS=(
    "array.sh"               # Script practicing arrays in bash
    "background.sh"          # Script practicing background processes with &
    "blackhatbash1.sh"       # Exercise from Black Hat Bash chapter 1
    "blackhatbash2.sh"       # Exercise from Black Hat Bash chapter 2
    "blackhatbash3.sh"       # Exercise from Black Hat Bash chapter 3
    "blackhatbash4.sh"       # Exercise from Black Hat Bash chapter 4
    "blackhatbash5.sh"       # Exercise from Black Hat Bash chapter 5
    "blackhatbash6.sh"       # Exercise from Black Hat Bash chapter 6
    "blackhatbash7.sh"       # Exercise from Black Hat Bash chapter 7
    "break.sh"               # Script practicing the break statement in loops
    "case.sh"                # Script practicing case/esac conditional blocks
    "check_root_function.sh" # Script with a function that checks for root user
    "exercise1.sh"           # First exercise script of the course
    "exit_codes.sh"          # Script practicing exit codes ($?)
    "for_files.sh"           # Script using a for loop to iterate over files
    "for_ip.sh"              # Script using a for loop to iterate over IP addresses
    "for_ls.sh"              # Script using a for loop with ls output
    "for.sh"                 # Basic for loop script
    "function.sh"            # Script practicing bash functions
    "if_elif.sh"             # Script practicing if/elif/else conditionals
    "input_prompting.sh"     # Script that reads user input with read
    "integer_comparison.sh"  # Script comparing numbers with -eq -lt -gt etc
    "linking_conditions.sh"  # Script using && and || to link conditions
    "local_scope_variable.sh"  # Script showing local variables inside functions
    "ping_with_arguments.sh"   # Script that runs ping using command-line arguments
    "print_args.sh"            # Script that prints all arguments passed to it
    "string_comparison.sh"     # Script comparing strings with = and !=
    "test_if_file_exists.sh"   # Script checking if a file exists with -f or -e
    "until_loop.sh"            # Script practicing the until loop
    "while_loop.sh"            # Script practicing the while loop
    "while.sh"                 # Another while loop variation script
)


# ============================================================
# STEP 1 - Check that a folder was passed as argument
# ============================================================

echo ""  # Print an empty line to add space before the header
echo -e "${BOLD}${BLUE}=================================================${RESET}"  # Print top border of the header
echo -e "${BOLD}${BLUE}   REPOSITORY AUDIT - blackhatbash branch        ${RESET}"  # Print the title
echo -e "${BOLD}${BLUE}=================================================${RESET}"  # Print bottom border of the header
echo ""  # Print an empty line after the header

# $1 is the first argument the user passes when running the script
# Example: bash exercise2.sh repo_luis → $1 would be "repo_luis"
# -z means "is this variable empty?" — if no argument was given, show an error and stop
if [ -z "$1" ]; then
    echo -e "${RED}ERROR: You need to pass the repo folder as an argument.${RESET}"  # Show error in red
    echo -e "${YELLOW}Usage: bash exercise2.sh <folder>${RESET}"                     # Show correct usage
    echo -e "${YELLOW}Example: bash exercise2.sh repo_luis${RESET}"                  # Show a real example
    exit 1  # Stop the script immediately and return error code 1 to the terminal
fi

# Save the argument $1 into a variable with a more descriptive name
CLONE_DIR="$1"

# Check that the folder the user passed actually exists on disk
# ! means NOT — so this reads: "if this is NOT a directory, show an error"
# -d checks if the path exists and is a directory
if [ ! -d "$CLONE_DIR" ]; then
    echo -e "${RED}ERROR: Folder '${CLONE_DIR}' does not exist.${RESET}"          # Show the bad folder name
    echo -e "${YELLOW}Make sure you cloned the repo first with:${RESET}"           # Explain what to do
    echo -e "${YELLOW}  git clone --branch blackhatbash <repo_url> ${CLONE_DIR}${RESET}"  # Show the exact command
    exit 1  # Stop the script immediately and return error code 1 to the terminal
fi

# basename extracts just the folder name from a full path
# Example: /home/user/repo_luis → repo_luis
REPO_NAME=$(basename "$CLONE_DIR")

echo -e "${CYAN}Auditing local folder: ${BOLD}${CLONE_DIR}${RESET}"  # Tell the user which folder is being audited
echo -e "${GREEN}Folder found. Starting audit...${RESET}"             # Confirm the folder exists and we are starting
echo ""  # Print an empty line before the first section



# ============================================================
# STEP 2 - Read and display all .sh files with their line count
# ============================================================

echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"  # Print top border of section
echo -e "${BOLD}  SECTION 1: ALL .sh FILES AND THEIR LINE COUNT  ${RESET}"          # Print section title
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"  # Print bottom border of section
echo ""  # Empty line for spacing

TOTAL_LINES=0   # Counter that will add up lines from every file found
FOUND_FILES=0   # Counter that will add up how many .sh files were found

# Loop through every .sh file found in the repo folder
# find searches inside CLONE_DIR for files ending in .sh
# -not -path "*/.git/*" skips the hidden .git folder which is not student work
# -print0 separates file names with a null character instead of newlines — safer for filenames with spaces
# sort -z sorts the files alphabetically using the same null separator
# IFS= and -d '' tell read to use null as the delimiter, matching -print0
while IFS= read -r -d '' filepath; do
    filename=$(basename "$filepath")          # Extract just the file name from the full path
    lines=$(wc -l < "$filepath")             # Count how many lines the file has
    TOTAL_LINES=$((TOTAL_LINES + lines))     # Add this file's lines to the running total
    FOUND_FILES=$((FOUND_FILES + 1))         # Increase the file counter by 1
    echo -e "  ${GREEN}[FOUND]${RESET} ${filename}  →  ${YELLOW}${lines} lines${RESET}"  # Print the file name and its line count
done < <(find "$CLONE_DIR" -name "*.sh" -not -path "*/.git/*" -print0 | sort -z)
# < <(...) is process substitution — it feeds the output of find+sort into the while loop

echo ""  # Empty line after the file list
echo -e "  ${BOLD}Total .sh files found: ${CYAN}${FOUND_FILES}${RESET}"        # Print total number of files found
echo -e "  ${BOLD}Total lines across all files: ${CYAN}${TOTAL_LINES}${RESET}" # Print total lines across all files
echo ""  # Empty line before the next section



# ============================================================
# STEP 3 - Check which expected scripts are present or missing
# ============================================================

echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"  # Print top border of section
echo -e "${BOLD}  SECTION 2: EXPECTED FILES - PRESENT OR MISSING  ${RESET}"          # Print section title
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"  # Print bottom border of section
echo ""  # Empty line for spacing

PRESENT_COUNT=0   # Counter for scripts that were found in the repo
MISSING_COUNT=0   # Counter for scripts that were not found in the repo
MISSING_FILES=()  # Empty array that will store the names of missing files

# Loop through every script name in the EXPECTED_SCRIPTS array
for script in "${EXPECTED_SCRIPTS[@]}"; do
    # find searches for the script by name inside the repo folder
    # grep -q . returns true if find found at least one result
    # -q means quiet — it does not print anything, just checks if something was found
    if find "$CLONE_DIR" -name "$script" -not -path "*/.git/*" | grep -q .; then
        echo -e "  ${GREEN}[OK]${RESET}      $script"       # Script was found — print OK in green
        PRESENT_COUNT=$((PRESENT_COUNT + 1))                # Increase the present counter by 1
    else
        echo -e "  ${RED}[MISSING]${RESET} $script"         # Script was not found — print MISSING in red
        MISSING_COUNT=$((MISSING_COUNT + 1))                # Increase the missing counter by 1
        MISSING_FILES+=("$script")                          # Add the missing script name to the array
    fi
done

echo ""  # Empty line after the file list
echo -e "  ${BOLD}Scripts present:  ${GREEN}${PRESENT_COUNT} / ${#EXPECTED_SCRIPTS[@]}${RESET}"  # Show how many scripts were found out of total expected
echo -e "  ${BOLD}Scripts missing:  ${RED}${MISSING_COUNT}${RESET}"                              # Show how many scripts are missing
echo ""  # Empty line before the next section



# ============================================================
# STEP 3b - Check that every .sh file has #!/bin/bash at line 1
# ============================================================

echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"  # Print top border of section
echo -e "${BOLD}  SECTION 3: SHEBANG CHECK (#!/bin/bash)          ${RESET}"          # Print section title
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"  # Print bottom border of section
echo ""  # Empty line for spacing

NO_SHEBANG_COUNT=0   # Counter for scripts that are missing the shebang line
NO_SHEBANG_FILES=()  # Empty array that will store the names of files without shebang

# Loop through every .sh file in the repo, same as section 1
# find looks for all .sh files excluding the .git folder
# -print0 and -d '' handle filenames safely using null as separator
while IFS= read -r -d '' filepath; do
    filename=$(basename "$filepath")       # Extract just the file name from the full path
    first_line=$(head -n 1 "$filepath")   # Read only the very first line of the file
                                          # head -n 1 stops after reading line number 1

    # Compare the first line to the expected shebang
    # tr -d '[:space:]' removes any extra spaces or tabs before comparing
    # This prevents false negatives when a file has a trailing space after #!/bin/bash
    if [ "$(echo "$first_line" | tr -d '[:space:]')" = "#!/bin/bash" ]; then
        echo -e "  ${GREEN}[OK]${RESET}      $filename  →  has #!/bin/bash"          # File has the correct shebang
    else
        echo -e "  ${RED}[NO SHEBANG]${RESET} $filename  →  first line is: '$first_line'"  # Show what the first line actually is
        NO_SHEBANG_COUNT=$((NO_SHEBANG_COUNT + 1))   # Increase the missing shebang counter by 1
        NO_SHEBANG_FILES+=("$filename")               # Add this file name to the array of offenders
    fi
done < <(find "$CLONE_DIR" -name "*.sh" -not -path "*/.git/*" -print0 | sort -z)
# < <(...) feeds the output of find+sort into the while loop using process substitution

echo ""  # Empty line after the file list
echo -e "  ${BOLD}Scripts with correct shebang:  ${GREEN}$(( FOUND_FILES - NO_SHEBANG_COUNT )) / ${FOUND_FILES}${RESET}"  # Show how many passed
echo -e "  ${BOLD}Scripts missing shebang:       ${RED}${NO_SHEBANG_COUNT}${RESET}"  # Show how many failed
echo ""  # Empty line before the next section



# ============================================================
# STEP 4 - Check if commits were made during class hours
# ============================================================

echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"  # Print top border of section
echo -e "${BOLD}  SECTION 4: COMMIT SCHEDULE CHECK                ${RESET}"          # Print section title
echo -e "${BOLD}  (Mon & Wed, 7-9 AM Ecuador = 12-14 UTC)        ${RESET}"          # Reminder of the class schedule
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"  # Print bottom border of section
echo ""  # Empty line for spacing

TOTAL_COMMITS=0    # Counter for all commits found in the branch
ON_TIME_COMMITS=0  # Counter for commits made during class hours
LATE_COMMITS=0     # Counter for commits made outside class hours after the cutoff date
SKIPPED_COMMITS=0  # Counter for commits outside class hours but before the cutoff date

# Only commits ON or AFTER this date are penalized for being outside class hours
# Commits before this date are shown but ignored in the score calculation
# Format must be YYYY-MM-DD so string comparison works correctly
PENALTY_CUTOFF="2026-06-01"

# Read all commits from the branch using git log
# --format="%H|%ci|%s" returns: full hash | ISO date with timezone | commit message
# Example output: abc1234...|2026-06-15 13:14:39 +0000|feat: add script
# The pipe | is used as a separator between fields so we can split them with IFS
while IFS='|' read -r commit_hash commit_date commit_msg; do
    TOTAL_COMMITS=$((TOTAL_COMMITS + 1))  # Increase total commit counter by 1

    # Extract the hour from the UTC date string
    # awk '{print $2}' gets the time part (e.g. "13:14:39")
    # cut -d':' -f1 gets just the hour (e.g. "13")
    utc_hour=$(echo "$commit_date" | awk '{print $2}' | cut -d':' -f1)
    utc_hour=$((10#$utc_hour))  # Force base-10 conversion so hours like 08 or 09 don't cause errors

    # Convert UTC hour to Ecuador local time by subtracting 5 hours (Ecuador is UTC-5)
    ecuador_hour=$((utc_hour - 5))

    # If the result is negative it means we crossed midnight going backwards
    # For example: 3 AM UTC - 5 = -2, which should be 22 (10 PM) the day before
    if [ "$ecuador_hour" -lt 0 ]; then
        ecuador_hour=$((ecuador_hour + 24))  # Add 24 to wrap around to the previous day
    fi

    # Extract just the date part from the commit timestamp (e.g. "2026-06-15")
    utc_date=$(echo "$commit_date" | awk '{print $1}')

    # If the UTC hour was before 5 AM, the Ecuador date is actually the previous day
    # because subtracting 5 hours crossed midnight
    if [ "$utc_hour" -lt 5 ]; then
        ecuador_date=$(date -d "$utc_date - 1 day" +"%Y-%m-%d" 2>/dev/null)  # Subtract one day
    else
        ecuador_date="$utc_date"  # Date is the same in Ecuador as in UTC
    fi

    # Get the day of the week as a number using the Ecuador date
    # date +%u returns: 1=Monday, 2=Tuesday, 3=Wednesday ... 7=Sunday
    day_num=$(date -d "$ecuador_date" +"%u" 2>/dev/null)

    # Build a readable timestamp string to display in the output
    # printf "%02d" pads the hour with a leading zero if needed (e.g. 7 → 07)
    ecuador_time=$(printf "%02d:%s" "$ecuador_hour" "$(echo "$commit_date" | awk '{print $2}' | cut -d':' -f2-)")
    display_date="${ecuador_date} ${ecuador_time} (Ecuador)"  # Full readable date in Ecuador time

    # Check if the commit day matches one of the class days (Monday=1 or Wednesday=3)
    day_ok=false                      # Assume the day is not a class day
    for d in $CLASS_DAYS; do          # Loop through the class days list
        if [ "$day_num" = "$d" ]; then
            day_ok=true               # Day matches — mark it as a class day
        fi
    done

    # Check if the commit hour falls within class time (7 AM to 9 AM Ecuador)
    # -ge means greater than or equal to, -lt means less than
    time_ok=false  # Assume the time is outside class hours
    if [ "$ecuador_hour" -ge "$CLASS_START" ] && [ "$ecuador_hour" -lt "$CLASS_END" ]; then
        time_ok=true  # Hour is within class time — mark it as OK
    fi

    short_msg="${commit_msg:0:45}"   # Trim the commit message to 45 characters for cleaner display
    short_hash="${commit_hash:0:7}"  # Trim the commit hash to 7 characters (standard short format)

    # Decide how to label this commit based on day and time checks
    if $day_ok && $time_ok; then
        # Both day and time are correct — commit was made during class
        echo -e "  ${GREEN}[IN CLASS]${RESET}  ${short_hash} | ${display_date} | ${short_msg}"
        ON_TIME_COMMITS=$((ON_TIME_COMMITS + 1))  # Increase the in-class counter by 1
    else
        # Commit was outside class hours — check if it should be penalized
        # String comparison works here because dates are in YYYY-MM-DD format
        # which sorts correctly as text (earlier dates are alphabetically smaller)
        if [[ "$ecuador_date" < "$PENALTY_CUTOFF" ]]; then
            # Commit is before the cutoff date — show it but do not penalize
            echo -e "  ${CYAN}[BEFORE ${PENALTY_CUTOFF}]${RESET}  ${short_hash} | ${display_date} | ${short_msg}"
            SKIPPED_COMMITS=$((SKIPPED_COMMITS + 1))  # Increase the skipped counter by 1
        else
            # Commit is after the cutoff date and outside class — penalize it
            echo -e "  ${YELLOW}[OUTSIDE] ${RESET}  ${short_hash} | ${display_date} | ${short_msg}"
            LATE_COMMITS=$((LATE_COMMITS + 1))  # Increase the late counter by 1
        fi
    fi

done < <(git -C "$CLONE_DIR" --no-pager log "$BRANCH" --format="%H|%ci|%s" 2>/dev/null)
# git -C "$CLONE_DIR" runs git inside the repo folder without needing to cd into it
# --no-pager prevents git from pausing the output waiting for the user to press Enter
# 2>/dev/null suppresses any git error messages so they don't mix with the output

echo ""  # Empty line after the commit list
echo -e "  ${BOLD}Total commits in branch:              ${CYAN}${TOTAL_COMMITS}${RESET}"               # Total commits found
echo -e "  ${BOLD}Commits during class:                 ${GREEN}${ON_TIME_COMMITS}${RESET}"            # Commits made in class
echo -e "  ${BOLD}Commits outside (penalized):          ${YELLOW}${LATE_COMMITS}${RESET}"              # Commits that will lose points
echo -e "  ${BOLD}Commits before ${PENALTY_CUTOFF} (ignored):  ${CYAN}${SKIPPED_COMMITS}${RESET}"      # Commits ignored from penalty
echo ""  # Empty line before the next section

# ============================================================
# STEP 5 - Calculate a score out of 100 with penalties
# - Start at 100
# - Deduct 0.25 per missing script
# - Deduct 0.15 per commit outside class hours
# Since bash only does integers, we work in cents (multiply by 100)
# and convert back at the end for display
# ============================================================
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"
echo -e "${BOLD}  SECTION 5: FINAL SCORE (out of 100)            ${RESET}"
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"
echo ""

TOTAL_EXPECTED=${#EXPECTED_SCRIPTS[@]}

# Start at 10000 cents = 100.00 points
SCORE_CENTS=10000

# --- Penalty for missing scripts: 0.25 per file = 25 cents each ---
MISSING_PENALTY_CENTS=$(( MISSING_COUNT * 25 ))

# --- Penalty for commits outside class: 0.15 per commit = 15 cents each ---
LATE_PENALTY_CENTS=$(( LATE_COMMITS * 15 ))

# --- Penalty for missing shebang: 0.25 per file = 25 cents each ---
SHEBANG_PENALTY_CENTS=$(( NO_SHEBANG_COUNT * 25 ))

# --- Apply all penalties ---
SCORE_CENTS=$(( SCORE_CENTS - MISSING_PENALTY_CENTS - LATE_PENALTY_CENTS - SHEBANG_PENALTY_CENTS ))

# --- Make sure score does not go below 0 ---
if [ "$SCORE_CENTS" -lt 0 ]; then
    SCORE_CENTS=0
fi

# --- Convert cents to display format (e.g. 9750 → 97.50) ---
SCORE_INT=$(( SCORE_CENTS / 100 ))
SCORE_DEC=$(( SCORE_CENTS % 100 ))

# Pad decimal to always show two digits (e.g. 5 → 05)
SCORE_DISPLAY=$(printf "%d.%02d" "$SCORE_INT" "$SCORE_DEC")

# --- Show penalty breakdown ---
MISSING_DISPLAY=$(printf "%d.%02d" $(( MISSING_PENALTY_CENTS / 100 )) $(( MISSING_PENALTY_CENTS % 100 )))
LATE_DISPLAY=$(printf "%d.%02d" $(( LATE_PENALTY_CENTS / 100 )) $(( LATE_PENALTY_CENTS % 100 )))

SHEBANG_DISPLAY=$(printf "%d.%02d" $(( SHEBANG_PENALTY_CENTS / 100 )) $(( SHEBANG_PENALTY_CENTS % 100 )))

echo -e "  Starting score:                   ${CYAN}100.00${RESET}"
echo -e "  Scripts missing:    ${RED}-${MISSING_DISPLAY}${RESET}  (${MISSING_COUNT} × 0.25)"
echo -e "  No shebang:         ${RED}-${SHEBANG_DISPLAY}${RESET}  (${NO_SHEBANG_COUNT} × 0.25)"
echo -e "  Commits outside:    ${RED}-${LATE_DISPLAY}${RESET}  (${LATE_COMMITS} × 0.15)"
echo ""

# --- Pick color based on final score ---
if [ "$SCORE_CENTS" -ge 9000 ]; then
    SCORE_COLOR="${GREEN}"
elif [ "$SCORE_CENTS" -ge 7000 ]; then
    SCORE_COLOR="${YELLOW}"
else
    SCORE_COLOR="${RED}"
fi

echo -e "  ${BOLD}╔══════════════════════════════════╗${RESET}"
echo -e "  ${BOLD}║  FINAL SCORE:  ${SCORE_COLOR}${SCORE_DISPLAY} / 100${RESET}${BOLD}       ║${RESET}"
echo -e "  ${BOLD}╚══════════════════════════════════╝${RESET}"
echo ""

# --- Feedback message ---
if [ "$SCORE_CENTS" -ge 9000 ]; then
    echo -e "  ${GREEN}Excellent work! Everything looks great.${RESET}"
elif [ "$SCORE_CENTS" -ge 7000 ]; then
    echo -e "  ${GREEN}Good job! Just a few things to improve.${RESET}"
elif [ "$SCORE_CENTS" -ge 5000 ]; then
    echo -e "  ${YELLOW}Decent effort, but penalties brought the score down.${RESET}"
else
    echo -e "  ${RED}Needs more work. Check missing files and commit times.${RESET}"
fi

# --- List missing files if any ---
if [ "${#MISSING_FILES[@]}" -gt 0 ]; then
    echo ""
    echo -e "  ${YELLOW}Missing scripts to add:${RESET}"
    for mf in "${MISSING_FILES[@]}"; do
        echo -e "    ${RED}→ ${mf}${RESET}"
    done
fi

echo ""
echo -e "${BOLD}${BLUE}=================================================${RESET}"
echo -e "${CYAN}Audit complete.${RESET}"
echo -e "${BOLD}${BLUE}=================================================${RESET}"
echo ""