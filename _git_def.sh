#!/bin/bash

BS="\033[1m"
BE="\033[0m"

exit_on_error() {
    exit_code=$1
    if [ $exit_code -ne 0 ]; then
        >&2 echo -e $BS"Command failed with exit code ${exit_code}."$BE
        exit $exit_code
    fi
}