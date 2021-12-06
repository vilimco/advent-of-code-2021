#! /usr/local/bin/bash

input=$(cat source.txt)
input=($(echo ${input} | tr "," " "))

fish=()
for v in ${input[@]}; do
  let val=v+0
  fish+=($val)
done

mkdir data
for i in {1..2332}; do
  echo 0 >>data/$i.txt
done

life() {
  start=$1
  days=$2

  if [ $days -lt 0 ]; then
    echo 0
    return
  fi

  if [ $days -le $start ]; then
    echo 1
    return
  fi

  let index=8*days+start
  let mapValue=$(cat data/$index.txt)+0
  if [ "$mapValue" != "0" ]; then
    echo "$mapValue"
    return
  fi

  local sum=1
  ((generations = (days + 7 - start - 1) / 7))
  let generations--
  for i in $(seq 0 $generations); do
    ((newDay = (days - 1 - start) - i * 7))
    let dayValue=$(life 8 $newDay)+0
    let sum+=dayValue
  done

  echo "$sum" >data/$index.txt

  echo $sum
  return
}

let result=0
for i in ${fish[@]}; do
  let result=$(life $i 256)+result
  echo "Done with $i, $result so far..."
done

echo "Final result: $result"

rm -rf data
