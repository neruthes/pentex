#!/bin/bash

echo "[INFO] Now going to make '$1'"


cmdlist="pentex pentex-pkg"
case $1 in
    test2)
        bash "$0" test
        minoss docs/*.pdf
        cfoss docs/*.pdf
        ;;
    test)
        bash "$0" easy
        nomake=y h="npm:pentex-example-article" pentex docs/PenTeX.md --toc --number-sections
        H="examples/pentexstd.H.tex" pentex docs/PenTeX.md --toc --number-sections
        ;;
    build)
        mkdir -p build
        for cmd in $cmdlist; do
            find "src/$cmd" -type f | sort | while read -r fn; do
                cat "$fn"
            done > "build/$cmd"
        done
        ;;
    install_home)
        DEST="$HOME/.local/bin" bash "$0" install
        ;;
    install)
        [[ -z "$DEST" ]] && die "[ERROR] Env var DEST is empty"
        mkdir -p "$DEST"
        for cmd in $cmdlist; do
            echo "[INFO] Installing script '$cmd' in '$DEST/$cmd'"
            install -m755 "build/$cmd" "$DEST/$cmd"
        done
        ;;
    easy)
        bash "$0" build
        bash "$0" install_home
        ;;
    *)
        echo "[ERROR] No rule to make '$1'"
esac
