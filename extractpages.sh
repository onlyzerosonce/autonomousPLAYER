#!/bin/bash

usage() {
        echo "$0 {first page} {last page} {input pdf file} {output pdf file}"
}

extract() {
  gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
     -dFirstPage=$1 -dLastPage=$2 \
     -sOutputFile=$4 $3
}


EXPECTED_ARGS=4
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  usage
  exit $E_BADARGS
else
  extract $1 $2 $3 $4
fi
