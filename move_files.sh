#!/bin/bash

  #file_count=$(ls log | grep osman | wc -l)
  #mv_count=$(echo "$file_count / 5 " | bc)

  for (( i = 1; i <= 5; i++ )); do
    ls log | grep osman | head -7 > file_list.txt
    while IFS= read -r file; do
    mv log/"$file" tmp/$i
    done < file_list.txt
  done
