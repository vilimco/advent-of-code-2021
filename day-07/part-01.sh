#! /usr/local/bin/bash

input=($(cat source.txt | tr "," " "))
# Calculated by https://www.calculatorsoup.com/calculators/statistics/mean-median-mode.php
median=345

let sum=0

for val in ${input[@]}; do
  let diff=val-median
  let diff=${diff#-}
  let sum+=diff
done

echo "sum: $sum"
