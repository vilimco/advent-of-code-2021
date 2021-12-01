#! /bin/bash

input=$(cat source.txt)

prev1Value=-1
prev2Value=-1
prev3Value=-1
prevSum=-1
output=0
for line in ${input[@]}
do
  value=$((line + 0))

  if [ $prev1Value -ge 0 -a $prev2Value -ge 0 -a $prev3Value -ge 0 ]; then
    let sum=prev1Value+prev2Value+value;
    if [ $sum -gt $prevSum ]; then
      let output+=1;
    fi;
  fi

  let prev3Value=prev2Value+0;
  let prev2Value=prev1Value+0;
  let prev1Value=value+0;
  let prevSum=prev1Value+prev2Value+prev3Value;
done

echo "Total results: $output"
