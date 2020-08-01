#!/bin/bash
prod_directory='put in your directory'
stage_directory='put in your directory'
for file in $(find $prod_directory -maxdepth 1 -amin +5 -name "*.tar.gz" -printf "%f\n")
do
hash_filename=${file/.tar.gz/.hash}
file_size=$(du -h $prod_directory/$file)
existing=$(find $stage_directory -name $file)
  if [[ ${existing} == "" ]]
  then
    echo $file $file_size >> $stage_directory/file_audit
    cp $prod_directory/$file $stage_directory/$file
    md5sum $stage_directory/$file > $stage_directory/$hash_filename
  fi
done
