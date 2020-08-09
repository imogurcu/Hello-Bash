#!/bin/bash
  max_size=512

  dir_location=$(pwd)

  ./sync_files.sh

  size=$(du log/ | awk '{print $1}')

  i=1
  while [[ $max_size -ge $size ]]; do
    echo Disk Size : "$size" KB
    touch $dir_location/log/osman$i.txt
    echo osman"$i".txt writing...

      for j in {1..1000}; do
        range=10;
        number="";

          for k in {0..8}; do
              r=$RANDOM;
              let "r %= $range";
              number="$number""$r";
          done

            str=$(echo {a..z} | tr ' ' "\n" | shuf | xargs | tr -d ' ' | cut -b 1-5)
            echo "$number $str" >> $dir_location/log/osman$i.txt
      done

      size=$(du log | awk 'NR==1 {print $1}')
      i=$(( $i + 1 ))
  done

  ./zip_unzip_files.sh

  ./move_files.sh

  ./thread_5.sh
