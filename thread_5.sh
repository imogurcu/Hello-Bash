#!/bin/bash

  dir_location=$(pwd)

  thread_func(){

    get_pid=$(ps -p $$ -wo pid,stime | awk 'NR == 2 {print $1}')
    get_rtime=$(ps -p $$ -wo pid,stime | awk 'NR == 2 {print $2}')
          #file_name=$(ls tmp/$i | sort | awk 'NR==1')
    for file in "$1"/*; do
      cat $file | awk -v my_ip=$(hostname -I | awk '{print $1}') -v file_name=$(echo $file) '/26/ {print my_ip, file_name, $1, $2 }' >> "$1"_"$get_pid"_"$get_rtime".txt
    done

    for file in "$1"_"$get_pid"_"$get_rtime".txt; do
      cat $file >> osman_output/last_osman_out_"$get_rtime".txt
      cat osman_output/last_osman_out_"$get_rtime".txt | sort -k3 > osman_output/last_osman_sorted_out_"$get_rtime".txt
    done
      sleep 1

  }

  for (( i = 1; i <= 5; i++ )); do
    thread_func "tmp/$i"
  done


  wait
  echo "All done"
