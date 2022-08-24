#!/usr/bin/env bash

# saner programming env: these switches turn some bugs into errors
set -o pipefail -o nounset

function show_usage {
    cat <<TEMPLATE_USAGE
Usage: $PROGRAM_NAME [OPTION]... 

...Description [REPLACE-ME]...

Example: $PROGRAM_NAME -h [REPLACE-ME]

Options:
  -h, --help        Show this message and exit
  -v, --verbose     Enable verbose output
TEMPLATE_USAGE
}

###
# Set default color codes for colorful prints.
###
RED_COLOR="\033[0;31m"
GREEN_COLOR="\033[0;32m"
YELLOW_COLOR="\033[1;33m"
BLUE_COLOR="\033[0;34m"
NEUTRAL_COLOR="\033[0m"

###
# Prints all given strings with the given color, appending a newline in the end.
# One should not use this function directly, but rather use "log-level" functions
# such as "info", "error", "success", etc.
# Arguments:
#       $1: Color to print in. Expected to be bash-supported color code
#       $2..N: Strings to print.
###
function cecho {
    local string_placeholders=""
    for ((i = 1; i < $#; i++)); do
        string_placeholders+="%s"
    done

    # shellcheck disable=SC2059
    printf "${1}${string_placeholders}${NEUTRAL_COLOR}\n" "${@:2}"
}

function error {
    cecho "$RED_COLOR" "$@" >&2
}

function warning {
    cecho "$YELLOW_COLOR" "$@"
}

function success {
    cecho "$GREEN_COLOR" "$@"
}

function info {
    cecho "$BLUE_COLOR" "$@"
}

###
# Function's docs [REPLACE-ME]
###
function do_something {
    :
}

###
# Set global variables
###
function set_globals {
    :
}

###
# Parse arguments/options using getopt, the almighty C-based parser.
###
function parse_arguments {
    getopt --test >/dev/null
    if (($? != 4)); then
        error "I'm sorry, 'getopt --test' failed in this environment."
        return 1
    fi

    local short_options=hv
    local long_options=help,verbose

    # -temporarily store output to be able to check for errors
    # -activate quoting/enhanced mode (e.g. by writing out “--options”)
    # -pass arguments only via   -- "$@"   to separate them correctly
    if ! PARSED=$(
        getopt --options="$short_options" --longoptions="$long_options" \
            --name "$PROGRAM_PATH" -- "$@"
    ); then
        # getopt has complained about wrong arguments to stdout
        error "Wrong arguments to $PROGRAM_NAME" && return 2
    fi

    # read getopt’s output this way to handle the quoting right:
    eval set -- "$PARSED"

    while true; do
        case $1 in
        -h | --help)
            show_usage
            exit 0
            ;;
        -v | --verbose)
            VERBOSE=true
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            error "Programming error"
            return 3
            ;;
        esac
    done

    # Arguments can be parsed here - Anything left will be now at $1, $2, etc.

    return 0
}

###
# Set default values to be used throughout the script (global variables).
###
function set_defaults {
    VERBOSE=false
}

###
# This is the script's entry point, just like in any other programming language.
###
function main {
    local PROGRAM_PATH
    local PROGRAM_NAME
    local PROGRAM_DIR

    local executing_shell
    executing_shell="$(ps -p $$ -ocomm=)"
    if [[ "$executing_shell" != "$(basename "$0")" && "$executing_shell" != "bash" ]]; then
        error "Please execute me directly, or at least via bash!"
        return 1
    else
        case "$(uname -s)" in
        Linux*) READLINK_PROGRAM="readlink" ;;
        Darwin*) READLINK_PROGRAM="greadlink" ;;
        esac

        PROGRAM_PATH="$($READLINK_PROGRAM -f "${BASH_SOURCE[0]}")"
    fi
    PROGRAM_NAME="$(basename "$PROGRAM_PATH")"
    PROGRAM_DIR="$(dirname "$PROGRAM_PATH")"

    if ! set_defaults; then
        error "Failed setting default values, aborting"
        return 1
    fi

    if ! parse_arguments "$@"; then
        error "Failed parsing arguments, aborting"
        return 2
    fi

    if ! set_globals; then
        error "Failed setting global variables, aborting"
        return 3
    fi

    if ! do_something; then
        error "Failed [REPLACE-ME]"
        return 4
    fi

    success "Successfully [REPLACE-ME]"
    return 0
}

# Call main and don't do anything else
# It will pass the correct exit code to the OS
main "$@"
