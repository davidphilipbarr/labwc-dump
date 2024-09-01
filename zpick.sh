#!/usr/bin/env bash

find_color() {
    printf "%d" "0x${1}"
}

_get() {
    col_in="$1"
    if ! type zenity >/dev/null 2>&1; then
      echo -e '<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" version="1.1"  height="48px" width="48px" viewBox="0 0 48 48">
  <path d="m 0 0 48 0 0 48 -48 0 z" style="fill:'$col_in';stroke:none;"/>
</svg>' > $TEMPDIR/col.svg
    fi
    BCOL=${col_in/\#/}
    BR=${BCOL:0:2}; BG=${BCOL:2:2}; BB=${BCOL:4:2};
    BHR=$(find_color $BR)
    BHG=$(find_color $BG)
    BHB=$(find_color $BB)
    ZC='rgb('$BHR','$BHG','$BHB')'
    BHR=$(dc -e'3k '$BHR' 255 / p')
    BHG=$(dc -e'3k '$BHG' 255 / p')
    BHB=$(dc -e'3k '$BHB' 255 / p')
    X=''
    [ ${BHR:0:1} = '.' ] && X=0
    [ ${BHG:0:1} = '.' ] && X=0
    [ ${BHB:0:1} = '.' ] && X=0
    ZF=''$X$BHR' '$X$BHG' '$X$BHB''
    if type zenity >/dev/null 2>&1; then
      out=$(zenity --title="Color Picker" --icon="select-color" --list  --editable --print-column=2 \
      --text=" Copy and paste color found\n to your application:" \
      --column="Color Space" --column="Color" \
     "Color Hex" "$col_in" \
     "Color RGB" "$ZC" \
     "Color sRGB" "$ZF" \
     --ok-label="Color")
    case "$out"  in
       '#'*|rgb*)zenity --title="Color Picker" --color-selection --color="$out" >/dev/null 2>&1;;
       ?*)zenity --info --title="Info" --text="Only Hex or rgb() is supported to show the Color dialog" >/dev/null 2>&1;;
       '');;
    esac   
    else
      yad --title="Color Picker" --name="select-color" --form \
      --image="$TEMPDIR/col.svg" --text=" Copy and paste color found\n to your application:" \
      --field="Color Hex" "$col_in" \
      --field="Color RGB" "$ZC" \
      --field="Color sRGB" "$ZF" \
      --button="Color!select-color":'sh -c "yad --color --init-color='$col_in'" >/dev/null 2>&1' \
      --button="Ok!gtk-ok":0 >/dev/null 2>&1
    fi 
    return 0
}

export -f find_color _get

if ! type zenity >/dev/null 2>&1; then
    export TEMPDIR
    TEMPDIR=$(mktemp -d /tmp/colpickXXXX)
fi

# cleanup
trap "rm -rf $TEMPDIR" EXIT

_get $(hyprpicker)
