#! /usr/local/bin/bash

input=($(cat source.txt | tr "," " "))
# Calculated by https://www.calculatorsoup.com/calculators/statistics/mean-median-mode.php
mean=481

let sum=0

for val in ${input[@]}; do
  let diff=val-mean
  let diff=${diff#-}
  for i in $(seq 1 $diff); do
    let sum+=i
  done
done

echo "sum: $sum"
