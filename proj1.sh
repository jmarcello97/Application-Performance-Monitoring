#!/bin/bash

cleanup () {
	pkill -9 APM
	
	#alternative cleanup code

	#ps aux | grep APM > cleanuptemp.txt
	#num_lines=$(wc -l cleanuptemp.txt | awk '{print $1}')
	#echo $num_lines
	#while [ $num_lines -ne 0 ]
	#do
	#	line=$(head -n 1 cleanuptemp.txt | awk '{print $2}')
	#	kill $line
	#	tail -n +2 cleanuptemp.txt > temp2.txt
	#	cp temp2.txt cleanuptemp.txt
		
	# 	num_lines=$(( $num_lines-1 ))
	#done
}
trap cleanup EXIT

spawn () {
	./APM1 $1 &
	./APM2 $1 &
	./APM3 $1 &
	./APM4 $1 &
	./APM5 $1 &
	./APM6 $1 &
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

get_system_stats () {
	stat=$(ifstat | grep ens33)

	rx=$(echo $stat | awk '{print $6;}')
	tx=$(echo $stat | awk '{print $8;}')	

	iostat=$(iostat | grep sda)
	
	kbs=$(echo $iostat | awk '{print $4;}')

	df=$(df -m | grep /dev/mapper/centos-root)
	
	util=$(echo $df | awk '{print $4;}')

	echo "$SECONDS,$rx,$tx,$kbs,$util" >> system_metrics.csv 
}

main () {
	spawn $1
	echo "" > system_metrics.csv
	sleep 5	
	while [ 1 = 1 ] 
	do 
		if [ $(($SECONDS % 5)) -eq 0  ]
		then 
			get_system_stats $1
		fi
	
	done
}


main $1
