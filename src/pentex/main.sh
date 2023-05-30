#!/bin/bash

INPUT_PATH="$1"
OUTPUT_PATH="$1.pdf"

export PENTEX_HEADER_FILE="$H"
# Default value when `h` and `H` are both empty
if [[ -z "$h" ]] && [[ -z "$H" ]]; then
    export h=std:article-std
fi
if [[ -n "$h" ]]; then
    pkg_reg="$(cut -d: -f1 <<< "$h")"
    pkg_name="$(cut -d: -f2 <<< "$h")"
    case "$pkg_reg" in
        npm)
            export PENTEX_HEADER_FILE="node_modules/$pkg_name/$pkg_name.H.tex"
            echo "[INFO] Remember to run 'npm update' often to get lastest version of '$pkg_name'."
            if [[ ! -e "$PENTEX_HEADER_FILE" ]]; then
                pentex-pkg get "$pkg_reg:$pkg_name"
            fi
            ;;
        std)
            [[ "$NO_AUTO_INST" != y ]] && npm install pentex-std-lib
            export PENTEX_HEADER_FILE="node_modules/pentex-std-lib/styles/$pkg_name.H.tex"
            ;;
        *)
            echo "[ERROR] Un supported package registry '$pkg_reg'"
            ;;
    esac
fi




# Set default values
function setdefault () {
    [[ -z "${!1}" ]] && export "$1"="$2"
}
setdefault "papersize" "A4"
setdefault "fontsize" "11pt"
setdefault "geometry" "textwidth=35em"

PANDOC_STD_ARGS=(
    -N
    -H "$PENTEX_HEADER_FILE"
    "--pdf-engine=xelatex"
    "--shift-heading-level-by=-1"
    -V fontsize:"$fontsize"
    -V papersize:"$papersize"
    -V geometry:"$geometry"
)



shift

function echo_and_run() {
    echo "$@"
    [[ "$nomake" != y ]] && "$@"
}
echo_and_run pandoc -i "$INPUT_PATH" -f gfm -o "$OUTPUT_PATH" "${PANDOC_STD_ARGS[@]}" "$@"
