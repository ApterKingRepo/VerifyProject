#!/bin/bash
module=`cat ../Config/Config`
OLD_IFS="$IFS"
IFS=","
arr=($module)
IFS="$OLD_IFS"
for each in ${arr[@]}
do
    sed -i `$a import Verify+$each` ../Config/Config.swift
done
