#! /usr/local/bin/bash

# Read and map internal array
input=$(cat source.txt)

inputElementsSize=0
commands=()
for line in ${input[@]}
do
  commands+=("$line")
  let inputElementsSize+=1;
done

# Execute code
depth=0
pos=0
aim=0
for (( i=0; i<$inputElementsSize; i+=2 ))
do
  command=${commands[i]}
  let amount=${commands[i+1]}+0
  case $command in

    forward)
      let pos+=amount;
      let depth+=aim*amount
      ;;

    down)
      let aim+=amount
      ;;

    up)
      let aim-=amount
      ;;
  esac
done

let output=$pos*$depth
echo "$pos $depth $output"
