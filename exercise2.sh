#!/bin/bash

# ============================================================
# exercise2.sh
# Script that audits the blackhatbash branch of the repository
# Checks: files present, line counts, commit schedule, and gives a score
# Based on: Black Hat Bash - No Starch Press
# ============================================================

# --- Colors to make the output easier to read ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# --- Repository settings ---
# The script receives the path to a locally cloned repo as the first argument
# Usage: bash exercise2.sh <path_to_repo_folder>
# Example: bash exercise2.sh repo_luis
BRANCH="blackhatbash"

# --- Class schedule: Monday and Wednesday, 7:00 AM to 9:00 AM Ecuador time ---
# Commits from GitHub come in UTC (+0000). We convert manually to Ecuador (UTC-5) inside the loop.
CLASS_DAYS="1 3"        # 1 = Monday, 3 = Wednesday (numbers from 'date +%u')
CLASS_START=7           # 7 AM Ecuador time
CLASS_END=9             # 9 AM Ecuador time

# --- List of all .sh scripts that should be in the repo ---
EXPECTED_SCRIPTS=(
    "array.sh"
    "background.sh"
    "blackhatbash1.sh"
    "blackhatbash2.sh"
    "blackhatbash3.sh"
    "blackhatbash4.sh"
    "blackhatbash5.sh"
    "blackhatbash6.sh"
    "blackhatbash7.sh"
    "break.sh"
    "case.sh"
    "check_root_function.sh"
    "exercise1.sh"
    "exit_codes.sh"
    "for_files.sh"
    "for_ip.sh"
    "for_ls.sh"
    "for.sh"
    "function.sh"
    "if_elif.sh"
    "input_prompting.sh"
    "integer_comparison.sh"
    "linking_conditions.sh"
    "local_scope_variable.sh"
    "ping_with_arguments.sh"
    "print_args.sh"
    "string_comparison.sh"
    "test_if_file_exists.sh"
    "until_loop.sh"
    "while_loop.sh"
    "while.sh"
)

# ============================================================
# STEP 1 - Check that a folder was passed as argument
# ============================================================
echo ""
echo -e "${BOLD}${BLUE}=================================================${RESET}"
echo -e "${BOLD}${BLUE}   REPOSITORY AUDIT - blackhatbash branch        ${RESET}"
echo -e "${BOLD}${BLUE}=================================================${RESET}"
echo ""

# $1 is whatever folder path you pass when running the script
# Example: bash exercise2.sh repo_luis
if [ -z "$1" ]; then
    echo -e "${RED}ERROR: You need to pass the repo folder as an argument.${RESET}"
    echo -e "${YELLOW}Usage: bash exercise2.sh <folder>${RESET}"
    echo -e "${YELLOW}Example: bash exercise2.sh repo_luis${RESET}"
    exit 1
fi

CLONE_DIR="$1"

# Check that the folder actually exists
if [ ! -d "$CLONE_DIR" ]; then
    echo -e "${RED}ERROR: Folder '${CLONE_DIR}' does not exist.${RESET}"
    echo -e "${YELLOW}Make sure you cloned the repo first with:${RESET}"
    echo -e "${YELLOW}  git clone --branch blackhatbash <repo_url> ${CLONE_DIR}${RESET}"
    exit 1
fi

# Show which repo we are auditing
REPO_NAME=$(basename "$CLONE_DIR")
echo -e "${CYAN}Auditing local folder: ${BOLD}${CLONE_DIR}${RESET}"
echo -e "${GREEN}Folder found. Starting audit...${RESET}"
echo ""

# ============================================================
# STEP 2 - Read and display all .sh files with their line count
# ============================================================
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"
echo -e "${BOLD}  SECTION 1: ALL .sh FILES AND THEIR LINE COUNT  ${RESET}"
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"
echo ""

TOTAL_LINES=0
FOUND_FILES=0

# Go through every .sh file found in the repo
while IFS= read -r -d '' filepath; do
    filename=$(basename "$filepath")
    lines=$(wc -l < "$filepath")
    TOTAL_LINES=$((TOTAL_LINES + lines))
    FOUND_FILES=$((FOUND_FILES + 1))
    echo -e "  ${GREEN}[FOUND]${RESET} ${filename}  →  ${YELLOW}${lines} lines${RESET}"
done < <(find "$CLONE_DIR" -name "*.sh" -not -path "*/.git/*" -print0 | sort -z)

echo ""
echo -e "  ${BOLD}Total .sh files found: ${CYAN}${FOUND_FILES}${RESET}"
echo -e "  ${BOLD}Total lines across all files: ${CYAN}${TOTAL_LINES}${RESET}"
echo ""

# ============================================================
# STEP 3 - Check which expected scripts are present or missing
# ============================================================
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"
echo -e "${BOLD}  SECTION 2: EXPECTED FILES - PRESENT OR MISSING  ${RESET}"
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"
echo ""

PRESENT_COUNT=0
MISSING_COUNT=0
MISSING_FILES=()

for script in "${EXPECTED_SCRIPTS[@]}"; do
    if find "$CLONE_DIR" -name "$script" -not -path "*/.git/*" | grep -q .; then
        echo -e "  ${GREEN}[OK]${RESET}      $script"
        PRESENT_COUNT=$((PRESENT_COUNT + 1))
    else
        echo -e "  ${RED}[MISSING]${RESET} $script"
        MISSING_COUNT=$((MISSING_COUNT + 1))
        MISSING_FILES+=("$script")
    fi
done

echo ""
echo -e "  ${BOLD}Scripts present:  ${GREEN}${PRESENT_COUNT} / ${#EXPECTED_SCRIPTS[@]}${RESET}"
echo -e "  ${BOLD}Scripts missing:  ${RED}${MISSING_COUNT}${RESET}"
echo ""

# ============================================================
# STEP 3b - Check that every .sh file has #!/bin/bash at line 1
# ============================================================
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"
echo -e "${BOLD}  SECTION 3: SHEBANG CHECK (#!/bin/bash)          ${RESET}"
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"
echo ""

NO_SHEBANG_COUNT=0
NO_SHEBANG_FILES=()

while IFS= read -r -d '' filepath; do
    filename=$(basename "$filepath")
    # Read only the very first line of the file
    first_line=$(head -n 1 "$filepath")

    if [ "$first_line" = "#!/bin/bash" ]; then
        echo -e "  ${GREEN}[OK]${RESET}      $filename  →  has #!/bin/bash"
    else
        echo -e "  ${RED}[NO SHEBANG]${RESET} $filename  →  first line is: '$first_line'"
        NO_SHEBANG_COUNT=$((NO_SHEBANG_COUNT + 1))
        NO_SHEBANG_FILES+=("$filename")
    fi
done < <(find "$CLONE_DIR" -name "*.sh" -not -path "*/.git/*" -print0 | sort -z)

echo ""
echo -e "  ${BOLD}Scripts with correct shebang:  ${GREEN}$(( FOUND_FILES - NO_SHEBANG_COUNT )) / ${FOUND_FILES}${RESET}"
echo -e "  ${BOLD}Scripts missing shebang:       ${RED}${NO_SHEBANG_COUNT}${RESET}"
echo ""

# ============================================================
# STEP 4 - Check if commits were made during class hours
# ============================================================
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"
echo -e "${BOLD}  SECTION 4: COMMIT SCHEDULE CHECK                ${RESET}"
echo -e "${BOLD}  (Mon & Wed, 7-9 AM Ecuador = 12-14 UTC)        ${RESET}"
echo -e "${BOLD}${CYAN}--------------------------------------------------${RESET}"
echo ""

TOTAL_COMMITS=0
ON_TIME_COMMITS=0
LATE_COMMITS=0
SKIPPED_COMMITS=0

# Only commits ON or AFTER this date are penalized for being outside class hours
# Format: YYYY-MM-DD
PENALTY_CUTOFF="2026-06-01"

# Read all commits from the branch
# git log --format="%H|%ci|%s" gives us: hash | date in ISO format | message
# Example date: 2026-06-15 13:14:39 +0000
while IFS='|' read -r commit_hash commit_date commit_msg; do
    TOTAL_COMMITS=$((TOTAL_COMMITS + 1))

    # Extract the hour directly from the date string (position 11-12 in "YYYY-MM-DD HH:MM:SS +0000")
    # This avoids any issues with 'date -d' interpreting timezones differently
    utc_hour=$(echo "$commit_date" | awk '{print $2}' | cut -d':' -f1)
    utc_hour=$((10#$utc_hour))   # Force base-10 so 08 or 09 don't cause errors

    # Convert UTC hour to Ecuador time (UTC-5)
    ecuador_hour=$((utc_hour - 5))
    # Handle midnight rollover (if result is negative, add 24)
    if [ "$ecuador_hour" -lt 0 ]; then
        ecuador_hour=$((ecuador_hour + 24))
    fi

    # Extract the date portion and get the day of the week in Ecuador time
    # If the UTC hour is < 5, the Ecuador date is actually the day before
    utc_date=$(echo "$commit_date" | awk '{print $1}')
    if [ "$utc_hour" -lt 5 ]; then
        # Subtract one day for Ecuador
        ecuador_date=$(date -d "$utc_date - 1 day" +"%Y-%m-%d" 2>/dev/null)
    else
        ecuador_date="$utc_date"
    fi
    day_num=$(date -d "$ecuador_date" +"%u" 2>/dev/null)

    # Build a readable Ecuador timestamp to show the user
    ecuador_time=$(printf "%02d:%s" "$ecuador_hour" "$(echo "$commit_date" | awk '{print $2}' | cut -d':' -f2-)")
    display_date="${ecuador_date} ${ecuador_time} (Ecuador)"

    # Check if it was Monday(1) or Wednesday(3)
    day_ok=false
    for d in $CLASS_DAYS; do
        if [ "$day_num" = "$d" ]; then
            day_ok=true
        fi
    done

    # Check if it was between 7:00 AM and 9:00 AM Ecuador time
    time_ok=false
    if [ "$ecuador_hour" -ge "$CLASS_START" ] && [ "$ecuador_hour" -lt "$CLASS_END" ]; then
        time_ok=true
    fi

    short_msg="${commit_msg:0:45}"
    short_hash="${commit_hash:0:7}"

    if $day_ok && $time_ok; then
        echo -e "  ${GREEN}[IN CLASS]${RESET}  ${short_hash} | ${display_date} | ${short_msg}"
        ON_TIME_COMMITS=$((ON_TIME_COMMITS + 1))
    else
        # Check if this commit is before the penalty cutoff date
        # We compare date strings directly — works because format is YYYY-MM-DD
        if [[ "$ecuador_date" < "$PENALTY_CUTOFF" ]]; then
            echo -e "  ${CYAN}[BEFORE ${PENALTY_CUTOFF}]${RESET}  ${short_hash} | ${display_date} | ${short_msg}"
            SKIPPED_COMMITS=$((SKIPPED_COMMITS + 1))
        else
            echo -e "  ${YELLOW}[OUTSIDE] ${RESET}  ${short_hash} | ${display_date} | ${short_msg}"
            LATE_COMMITS=$((LATE_COMMITS + 1))
        fi
    fi

done < <(git -C "$CLONE_DIR" --no-pager log "$BRANCH" --format="%H|%ci|%s" 2>/dev/null)

echo ""
echo -e "  ${BOLD}Total commits in branch:              ${CYAN}${TOTAL_COMMITS}${RESET}"
echo -e "  ${BOLD}Commits during class:                 ${GREEN}${ON_TIME_COMMITS}${RESET}"
echo -e "  ${BOLD}Commits outside (penalized):          ${YELLOW}${LATE_COMMITS}${RESET}"
echo -e "  ${BOLD}Commits before ${PENALTY_CUTOFF} (ignored):  ${CYAN}${SKIPPED_COMMITS}${RESET}"
echo ""

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