#!/bin/bash

file='input.txt'
IFS=''
command=false
start=0
end=0
count=0
i=0
while read -r line; do
  if [ ${#line} -lt 1 ]; then
    continue
  fi

  if [ ${command} = false ] && [ "${line:1:1}" == "1" ]; then
    command=true
    for ((m = 1; m <= ((i - 1) / 4); m++)); do
      columnVar=column_${m}
      declare -g "column_${m}"="$(echo ${!columnVar} | rev)"
    done
    continue
  fi

  if [ ${command} = false ]; then
    i=1
    j=1
    while [ ${i} -lt ${#line} ]; do
      if [ "${line:${i}:1}" != " " ]; then
        columnVar=column_${j}
        if [[ -n ${!columnVar} ]]; then
          declare -g "column_${j}"="${!columnVar}${line:${i}:1}"
        else
          declare -g "column_${j}"="${line:${i}:1}"
        fi
      fi
      j=$((j + 1))
      i=$((i + 4))
    done
  else
    if [[ ${line} =~ move.([0-9]+) ]]; then
      count="${BASH_REMATCH[1]}"
    fi
    if [[ ${line} =~ from.([0-9]+) ]]; then
      start="${BASH_REMATCH[1]}"
    fi
    if [[ ${line} =~ to.([0-9]+) ]]; then
      end="${BASH_REMATCH[1]}"
    fi
    columnStart=column_${start}
    columnEnd=column_${end}
    startPosition=${!columnStart}
    startPosition=$((${#startPosition} - ${count}))
    declare -g "column_${end}"="${!columnEnd}$(echo ${!columnStart:${startPosition}:${count}} | rev)"
    declare -g "column_${start}"="${!columnStart:0:${startPosition}}"
  fi
done <$file
echo "result: "
for ((m = 1; m <= ((i - 1) / 4); m++)); do
  columnVar=column_${m}
  column=${!columnVar}
  echo ${column:(-1)}
done
