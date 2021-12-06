#! /usr/local/bin/bash

input=$(cat source.txt)
input=($(echo ${input} | tr "," " "))
fish=()
for v in ${input[@]}; do
  let val=v+0;
  fish+=($val)
done;

echo "start: ${fish[@]}"
for i in {1..100}; do
  newFish=()
  fishCopy=()
  let totalInputs=${#fish[@]}-1;
  for j in $(seq 0 $totalInputs); do
    if [ ${fish[j]} -eq 0 ]; then
      newFish+=(8)
      let fish[j]=6;
      continue;
    fi;
    let fish[j]--;
    done
    fish+=(${newFish[@]})
    echo "Day $i...${#fish[*]}"
done

echo "${#fish[*]}"
