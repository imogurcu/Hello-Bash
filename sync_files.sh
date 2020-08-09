#!/bin/bash

max_size=$1

OSMAN_CONTROL=$(pwd)

if [ -s "$OSMAN_CONTROL/log" ]; then
    rm -r $OSMAN_CONTROL/log
    mkdir $OSMAN_CONTROL/log
    if [[ -s "$OSMAN_CONTROL/tmp" ]]; then
      rm -r $OSMAN_CONTROL/tmp
      mkdir $OSMAN_CONTROL/tmp
      for (( i = 1; i <= 5; i++ )); do
        mkdir $OSMAN_CONTROL/tmp/$i
      done
    fi
    if [[ -s "$OSMAN_CONTROL/osman_output" ]]; then
      rm -r $OSMAN_CONTROL/osman_output
      mkdir $OSMAN_CONTROL/osman_output
    fi
else
    mkdir $OSMAN_CONTROL/log
    mkdir $OSMAN_CONTROL/tmp
    mkdir $OSMAN_CONTROL/osman_output
fi

if [[ -f "$OSMAN_CONTROL/file_list.txt" ]]; then
  rm -r $OSMAN_CONTROL/file_list.txt
  touch $OSMAN_CONTROL/file_list.txt
else
  touch $OSMAN_CONTROL/file_list.txt
fi
