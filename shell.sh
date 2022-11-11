#!/bin/sh

show_usage() {
    cat <<TEMPLATE_USAGE
Usage: $v_PROGRAM_NAME [OPTION]... 

...Description [REPLACE-ME]...

Example: $v_PROGRAM_NAME -h [REPLACE-ME]

Options:
  -h, --help        Show this message and exit
  -v, --verbose     Enable verbose output
-----------------------------------------------------"
TEMPLATE_USAGE
}

###
# Set default color codes for colorful prints
###
v_RED_COLOR="\033[0;31m"
v_GREEN_COLOR="\033[0;32m"
v_YELLOW_COLOR="\033[1;33m"
v_BLUE_COLOR="\033[0;34m"
v_NEUTRAL_COLOR="\033[0m"

error() {
    printf "${v_RED_COLOR}%s${v_NEUTRAL_COLOR}\n" "$@"
}

warning() {
    printf "${v_YELLOW_COLOR}%s${v_NEUTRAL_COLOR}\n" "$@"
}

info() {
    printf "${v_BLUE_COLOR}%s${v_NEUTRAL_COLOR}\n" "$@"
}

success() {
    printf "${v_GREEN_COLOR}%s${v_NEUTRAL_COLOR}\n" "$@"
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
            v_VERBOSE=true
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
    v_VERBOSE=false
}

main() {
    case "$(uname -s)" in
    Linux*) v_READLINK_PROGRAM="readlink" ;;
    Darwin*) v_READLINK_PROGRAM="greadlink" ;;
    esac

    v_PROGRAM_PATH="$($v_READLINK_PROGRAM -f "$0")"
    v_PROGRAM_NAME="$(basename "$v_PROGRAM_PATH")"
    v_PROGRAM_DIR="$(dirname "$v_PROGRAM_PATH")"

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

    if ! do_something "$@"; then
        error "Failed [REPLACE-ME]"
        return 4
    fi

    success "Successfully [REPLACE-ME]"
    return 0
}

# Call main and don't do anything else
# It will pass the correct exit code to the OS
main "$@"
