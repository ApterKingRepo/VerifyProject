#!/bin/bash
module=`cat ../Config/Config`
OLD_IFS="$IFS"
IFS=","
arr=($module)
IFS="$OLD_IFS"
for each in ${arr[@]}
do
    sed -i `/use_frameworks!/a pod \'Verify+$each\'` ../Podfile
done
