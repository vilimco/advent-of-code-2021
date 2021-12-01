#! /bin/bash

input=$(cat source.txt)

prevValue=-1
output=0
for line in ${input[@]}
do
  value=$((line + 0))

  if [ $prevValue -ge 0 ]; then
    if [ $value -gt $prevValue ]; then
      let output+=1;
    fi;
  fi

  let prevValue=value+0;
done

echo "Total results: $output"
