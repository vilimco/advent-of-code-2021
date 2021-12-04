#! /usr/local/bin/bash

input=($(cat source.txt))
numbers=$(echo ${input[0]} | tr "," " ")

maxSum=0
let atTurn=0
bChar="a"

let totalItems=${#input[@]}+0
for i in $(seq 1 25 $totalItems); do
  bingo=()
  for j in {0..24}; do
    bingo+=(${input[i + j]})
  done

  let turn=0
  for number in ${numbers[@]}; do
    newBingo=()
    let turn++
    for bn in ${bingo[@]}; do
      if [ "$number" = "$bn" ]; then
        newBingo+=($bChar)
      else
        newBingo+=($bn)
      fi
    done

    bingo=(${newBingo[@]})
    hasMatch=0
    for j in {0..4}; do
      # row checkup
      if [ "${bingo[j * 5]}" = $bChar -a "${bingo[j * 5 + 1]}" = $bChar -a "${bingo[j * 5 + 2]}" = $bChar -a "${bingo[j * 5 + 3]}" = $bChar -a "${bingo[j * 5 + 4]}" = $bChar ]; then
        hasMatch=1
      fi

      # column checkup
      if [ "${bingo[0 * 5 + j]}" = $bChar -a "${bingo[1 * 5 + j]}" = $bChar -a "${bingo[2 * 5 + j]}" = $bChar -a "${bingo[3 * 5 + j]}" = $bChar -a "${bingo[4 * 5 + j]}" = $bChar ]; then
        hasMatch=1
      fi
    done

    if [ $hasMatch -eq 1 ]; then
      if [ $turn -gt $atTurn ]; then
        sum=0
        for bn in ${bingo[@]}; do
          if [ "$bn" != $bChar ]; then
            let sum+=$bn
          fi
        done

        let atTurn=turn
        let maxSum=sum*number
      fi
      break
    fi
  done
done

echo "$maxSum"
