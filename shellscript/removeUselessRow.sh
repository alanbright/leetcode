#! /bin/bash
exefilename=$(basename $0)
absolute_path=`dirname $(readlink -f "$0")`/

if [ ! -z $1 ];then
    dir=$1
    echo choose path $dir , you can use relative path
else
    dir=$absolute_path
    echo run this shellscript without argument, use script current place as default path
fi

#got # of csv file
csvNum=$(ls ${dir}/*.csv|wc -l)

#got all .csv file name in $1 directory (it will keep proper directory to each file)
csvAllFileName=$(ls ${dir}/*.csv)

echo csvNum $csvNum

#echo csvAllFileName $csvAllFileName

loop=0
while [ $loop -lt $csvNum ]
do
    loop=$(( $loop + 1 ))

    #got one of csv filename
    tempFileName=$(ls $csvAllFileName|tail -n +$loop|head -n 1)
    #echo tempFileName $tempFileName

    #and check the first keyword
    #checkString=$(less $tempFileName|awk -F ',' '{print $1}'|head -n 1) # this is too slow
    checkString=$(head -n 1 $tempFileName|awk -F ',' '{print $1}')
    #echo checkString $checkString

    # if first keyword is 'Product', we already handled this file. skip
    if [ "$checkString" == 'Product' ];then
        echo 'file manipulated already, skip'
    else
        echo 'remove useless rows'
        sed -i -e '1d' -e '3,7d' $tempFileName
    fi
done
