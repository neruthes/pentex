#!/bin/bash

function CMD_get() {
    # echo getting "$@"
    PKGID="$1"
    pkg_reg="$(cut -d: -f1 <<< "$PKGID")"
    pkg_name="$(cut -d: -f2 <<< "$PKGID")"
    case $pkg_reg in
        npm)
            echo "[INFO] npm install $pkg_name"
            npm install "$pkg_name"
            ;;
        *)
            echo "[ERROR] No such registry '$pkg_reg'"
            exit 1
    esac
}


CMDLIST="get"
if [[ " $CMDLIST " == *" $1 "* ]]; then
    # echo "cmd $1 is ok"
    mycmd="CMD_$1"
    shift 
    "$mycmd" "$@"
else
    echo "[ERROR] Unsupported subcommand"
    exit 1
fi
