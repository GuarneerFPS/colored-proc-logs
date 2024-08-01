#!/bin/bash

show_help() {
    echo "Usage: ./cl.sh [command]"
    echo
    echo "This script captures the command output, processes it, and colorizes the logs according to keywords."
    echo
    echo "Keywords and their colors:"
    echo "  ERROR    - Bright Red"
    echo "  WARN     - Bright Yellow"
    echo "  DEBUG    - Bright Blue"
    echo "  TRACE    - Bright Cyan"
    echo "  INFO     - Bright Green"
    echo
    echo "Example:"
    echo "  ./cl.sh /path/to/bin/MyBin -someFlag /path/to/object/SomeDepObj"
}

if [[ "$1" == "-h" || "$1" == "--help" || $# -eq 0 ]]; then
    show_help
    exit 0
fi

# Capture the command as args (everything to the right side of ./cl.sh [command])
command="$@"

# Execute the command, capturing both stdout and stderr. Then pipe it to awk for processing.
eval "$command" 2>&1 | awk '
function set_color(code) {
    printf "\033[%sm", code;
}

function reset_color() {
    printf "\033[0m";
}

{
    printed = 0
    if (/ERROR/) {
        set_color("1;91");  # Bright Red
        print $0;
        reset_color();
        printed = 1
    } else if (/WARN|WARNING/) {
        set_color("1;93");  # Bright Yellow
        print $0;
        reset_color();
        printed = 1
    } else if (/DEBUG/) {
        set_color("1;94");  # Bright Blue
        print $0;
        reset_color();
        printed = 1
    } else if (/TRACE/) {
        set_color("1;96");  # Bright Cyan
        print $0;
        reset_color();
        printed = 1
    } else if (/INFO/) {
        set_color("1;92");  # Bright Green
        print $0;
        reset_color();
        printed = 1
    }
    if (printed == 0) {
        print $0;  # Print any line without keywords normally 
    }
}'

# Status is checked to not miss segfaults and the like in the colored version of the output 
status="${PIPESTATUS[0]}"

if [ "$status" -ne 0 ]; then
    # Only segfault is individually handled, the rest of non-zero codes are assigned WARN level.  
    if [ "$status" -eq 139 ]; then
        echo -e "\033[1;91mERROR: The program terminated due to a segmentation fault.\033[0m"
    else
        echo -e "\033[1;93mWARN: Program exited with status $status.\033[0m"
    fi
fi
