#!/bin/bash
module=`cat ../Config/Config`
OLD_IFS="$IFS"
IFS=","
arr=($module)
IFS="$OLD_IFS"
file="../Config/Config.swift"
for each in ${arr[@]}
do
    sed -i "" "$ a\
    	import Verify+${each}
    " $file
done
