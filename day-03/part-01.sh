#! /usr/local/bin/bash

input=$(cat source.txt)

commons=(0 0 0 0 0 0 0 0 0 0 0 0)
totalItems=0
for row in ${input[@]}
do
  let totalItems++;
  line=($(echo "$row" | grep -o .))
  for i in {0..12}
  do
    if [ "${line[i]}" = "1" ]; then
      let commons[i]+=1;
    fi
  done
done

gamma=""
epsilon=""
let halfItems=totalItems/2;
for val in ${commons[@]}
do
    if [ $val -gt $halfItems ]; then
        gamma+="1"
        epsilon+="0"
      else
        gamma+="0"
        epsilon+="1"
    fi
done

finalGamma=$((2#$gamma))
finalEpsilon=$((2#$epsilon))
let output=finalGamma*finalEpsilon;
echo "$output"
