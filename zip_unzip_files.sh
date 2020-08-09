#!/bin/bash

dir_location=$(pwd)

ZIP_CONTROL=$dir_location/log/txt_logs.zip

if [ -e "$ZIP_CONTROL" ]
then
    rm $dir_location/log/txt_logs.zip
else
    cd log
    zip txt_logs.zip *.txt
    cd ..
fi

unzip -d $dir_location/log/unzipped_files $dir_location/log/txt_logs.zip
