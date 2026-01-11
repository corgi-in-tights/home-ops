#!/usr/bin/env bash
set -Eeuo pipefail

# Log messages with different levels
function log() {
    local level="$1" msg="$2"
    shift 2 || true

    local color reset="\033[0m"
    case "${level}" in
        debug) color="\033[34m" ;;
        info)  color="\033[36m" ;;
        warn)  color="\033[33m" ;;
        error) color="\033[31m" ;;
        *)     color="\033[0m"  ;;
    esac

    local upper
    upper=$(echo "${level}" | tr '[:lower:]' '[:upper:]')

    local extra=""
    for arg in "$@"; do extra+=" ${arg}"; done

    echo -e "${color}[${upper}]${reset} ${msg}${extra}" >&2

    if [[ "${level}" == "error" ]]; then
        exit 1
    fi
}

# Check if required environment variables are set
function check_env() {
    local envs=("${@}")
    local missing=()
    local values=()

    for env in "${envs[@]}"; do
        if [[ -z "${!env-}" ]]; then
            missing+=("${env}")
        else
            values+=("${env}=${!env}")
        fi
    done

    if [ ${#missing[@]} -ne 0 ]; then
        log error "Missing required env variables" "envs=${missing[*]}"
    fi

    log debug "Env variables are set" "envs=${values[*]}"
}

# Check if required CLI tools are installed
function check_cli() {
    local deps=("${@}")
    local missing=()

    for dep in "${deps[@]}"; do
        if ! command -v "${dep}" &>/dev/null; then
            missing+=("${dep}")
        fi
    done

    if [ ${#missing[@]} -ne 0 ]; then
        log error "Missing required deps" "deps=${missing[*]}"
    fi

    log debug "Deps are installed" "deps=${deps[*]}"
}
