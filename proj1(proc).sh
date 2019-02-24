#!/bin/bash

./"$1" "$2" &

pid=$!

function getprocstats () {
	ps -eo pid,ppid,cmd,%mem,%cpu | egrep "$pid" > temp.txt
	lines=$( <temp.txt wc -l )
	tr -s ' ' ',' <temp.txt > temp2.txt
	cat temp2.txt > temp.txt
	rm temp2.txt
	cat temp.txt | cut -c 2- > temp2.txt
	cat temp2.txt > temp.txt
	rm temp2.txt
	while [ $lines -ne 0 ]
	do
		line=$( head -n 1 temp.txt )
		pid1=$( echo "$line" | cut -d "," -f 1 )
		ppid=$( echo "$line" | cut -d "," -f 2 )
		if [ $pid -eq $pid1 ] || [ $pid -eq $ppid ]
		then
			echo "$line" >> output.txt
		fi

		(( lines-- ))
		tail -n "$lines" temp.txt > temp2.txt 
		cat temp2.txt > temp.txt
		rm temp2.txt 
	done
	kill $pid 2> /dev/null
	rm temp.txt
}

getprocstats
