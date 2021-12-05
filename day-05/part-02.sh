#! /usr/local/bin/bash

input=($(cat source.txt))

size=1000
map=($(seq 0 1 1000000))

echo "Resetting map"
for i in {0..999999}; do
  let map[i]=0
done

let totalInputs=${#input[@]}-3
for i in $(seq 0 3 $totalInputs); do
  echo "Applying ${input[i + 0]} -> ${input[i + 2]}"
  start=($(echo ${input[i + 0]} | tr "," " "))
  end=($(echo ${input[i + 2]} | tr "," " "))
  let x1=${start[0]}+0
  let y1=${start[1]}+0
  let x2=${end[0]}+0
  let y2=${end[1]}+0

  let xDiff=0
  if [ $x1 -ne $x2 ]; then
    if [ $x1 -lt $x2 ]; then
      let xDiff=1
    else
      let xDiff=-1
    fi
  fi

  let yDiff=0
  if [ $y1 -ne $y2 ]; then
    if [ $y1 -lt $y2 ]; then
      let yDiff=1
    else
      let yDiff=-1
    fi
  fi

  let xMovements=x1-x2
  if [ $x1 -lt $x2 ]; then
    let xMovements=x2-x1
  fi
  let yMovements=y1-y2
  if [ $y1 -lt $y2 ]; then
    let yMovements=y2-y1
  fi

  let actions=xMovements
  if [ $xMovements -lt $yMovements ]; then
    let actions=yMovements
  fi

  let sx=x1
  let sy=y1
  for a in $(seq 0 $actions); do
    let index=sx*size+sy
    let map[index]++
    let sx+=xDiff
    let sy+=yDiff
  done
done

echo "Calculating sum"
let sum=0
for x in $(seq 1 $size); do
  for y in $(seq 1 $size); do
    let index=x-1
    let index*=size
    let index+=y-1
    let v=${map[index]}+0
    if [ $v -gt 1 ]; then
      let sum++
    fi
  done
done

echo "sum: $sum"
