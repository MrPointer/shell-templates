#!/bin/sh

show_usage() {
    cat <<TEMPLATE_USAGE
Usage: $PROGRAM_NAME [OPTION]... 

...Description [REPLACE-ME]...

Example: $PROGRAM_NAME -h [REPLACE-ME]

Options:
  -h, --help        Show this message and exit
  -v, --verbose     Enable verbose output
-----------------------------------------------------"
TEMPLATE_USAGE
}

###
# Set default color codes for colorful prints
###
RED_COLOR="\033[0;31m"
GREEN_COLOR="\033[0;32m"
YELLOW_COLOR="\033[1;33m"
BLUE_COLOR="\033[0;34m"
NEUTRAL_COLOR="\033[0m"

error() {
    printf "${RED_COLOR}%s${NEUTRAL_COLOR}\n" "$@"
}

warning() {
    printf "${YELLOW_COLOR}%s${NEUTRAL_COLOR}\n" "$@"
}

info() {
    printf "${BLUE_COLOR}%s${NEUTRAL_COLOR}\n" "$@"
}

success() {
    printf "${GREEN_COLOR}%s${NEUTRAL_COLOR}\n" "$@"
}

###
# Function Docs [REPLACE-ME]
###
do_something() {
    : # [REPLACE-ME]
}

###
# Set global variables.
###
set_globals() {
    :
}

###
# Parse arguments/options by traversing all input arguments.
###
parse_arguments() {
    while [ "$#" -gt 0 ]; do
        case $1 in
        -h | --help)
            show_usage
            exit 0
            ;;
        -v | --verbose)
            VERBOSE=true
            shift
            ;;
        *)
            # Unrecognizable options, skip (or treat as positional argument)
            shift
            ;;
        esac
    done
}

###
# Set default values to be used throughout the script (global variables).
###
set_defaults() {
    VERBOSE=false
}

main() {
    if ! set_defaults; then
        error "Failed setting defaults, aborting"
        return 1
    fi

    if ! parse_arguments "$@"; then
        error "Failed parsing arguments, aborting"
        return 2
    fi
    
    if ! set_globals; then
        error "Failed setting globals, aborting"
        return 3
    fi

    if ! invoke_actual_installation "$@"; then
        error "Failed [REPLACE-ME]"
        return 4
    fi

    success "Successfully [REPLACE-ME]"
    return 0
}

# Call main and don't do anything else
# It will pass the correct exit code to the OS
main "$@"

