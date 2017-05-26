#!/bin/bash
module=`cat ../Config/Config | xargs echo`
OLD_IFS="$IFS"
IFS=","
arr=($module)
IFS="$OLD_IFS"
file="../Podfile"
for each in ${arr[@]}
do
    sed -i "" "/use_frameworks!/a\ 
        pod 'Verify+${each}'
    " $file
done
