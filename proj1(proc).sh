#!/bin/bash

spawn () {
	./APM1 $1 &
	#./APM2 $2 &
	#./APM3 $3 &
	#./APM4 $4 &
	#./APM5 $5 &
	#./APM6 $6 &
}

#pid=$!

getprocstats () {
	ps -eo pid,ppid,cmd,%mem,%cpu | egrep "$1" > temp.txt
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
		if [ $1 -eq $pid1 ] || [ $1 -eq $ppid ]
		then
			echo "$line" >> output.txt
		fi

		(( lines-- ))
		tail -n "$lines" temp.txt > temp2.txt 
		cat temp2.txt > temp.txt
		rm temp2.txt 
	done
	#kill $1 1> /dev/null
	rm temp.txt
}

get_network_stats () {
	stat=$(ifstat | grep ens33)

	rx=$(echo $stat | awk '{print $6;}')
	tx=$(echo $stat | awk '{print $8;}')	

	echo $rx
	echo $tx
}

main () {
	spawn $1
	get_network_stats	
	#while 
	#do
	#	sleep 5
		#getprocstats "APM1"
	#done
}

main $1
