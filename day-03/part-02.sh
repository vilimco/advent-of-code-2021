#! /usr/local/bin/bash

oxygen=($(cat source.txt))

searchIndex=0
searchLimit=12

while [ ${#oxygen[@]} -gt 1 -a $searchIndex -lt $searchLimit ]
do
  common1=0
  common0=0
  for row in ${oxygen[@]}
  do
    line=($(echo "$row" | grep -o .))
    if [ "${line[searchIndex]}" = "1" ]; then
        let common1++
      else
        let common0++
    fi
  done

  filterValue="1"
  if [ $common1 -lt $common0 ]; then
      filterValue="0"
  fi

  newOxygen=()
  for row in ${oxygen[@]}
  do
    line=($(echo "$row" | grep -o .))
    if [ "${line[searchIndex]}" = "$filterValue" ]; then
        newOxygen+=($row)
    fi
  done

  oxygen=(${newOxygen[@]})
  let searchIndex++;
done
finalOxygen=$((2#${oxygen[0]}))

co2=($(cat source.txt))
searchIndex=0
while [ ${#co2[@]} -gt 1 -a $searchIndex -lt $searchLimit ]
do
  common1=0
  common0=0
  for row in ${co2[@]}
  do
    line=($(echo "$row" | grep -o .))
    if [ "${line[searchIndex]}" = "1" ]; then
        let common1++
      else
        let common0++
    fi
  done

  filterValue="0"
  if [ $common1 -lt $common0 ]; then
      filterValue="1"
  fi

  newCo2=()
  for row in ${co2[@]}
  do
    line=($(echo "$row" | grep -o .))
    if [ "${line[searchIndex]}" = "$filterValue" ]; then
        newCo2+=($row)
    fi
  done

  co2=(${newCo2[@]})
  let searchIndex++;
done

finalCo2=$((2#${co2[0]}))

let output=finalOxygen*finalCo2
echo "$output"
