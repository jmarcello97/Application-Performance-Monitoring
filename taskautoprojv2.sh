#!/bin/bash

cleanup () {
	pkill -9 APM

	rm "pids.txt" 2> /dev/null
	
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
	rm pids.txt 2> /dev/null
	./APM1 $1 &
	echo "$!" >> pids.txt
	./APM2 $1 &
	echo "$!" >> pids.txt
	./APM3 $1 &
	echo "$!" >> pids.txt
	./APM4 $1 &
	echo "$!" >> pids.txt
	./APM5 $1 &
	echo "$!" >> pids.txt
	./APM6 $1 &
	echo "$!" >> pids.txt
}

#pid=$!
#parameters = (pid)
#getprocstats () {
#	ps -eo pid,ppid,cmd,%mem,%cpu | egrep "$1" > temp.txt
#	lines=$( <temp.txt wc -l )
#	tr -s ' ' ',' <temp.txt > temp2.txt
#	cat temp2.txt > temp.txt
#	rm temp2.txt
#	cat temp.txt | cut -c 2- > temp2.txt
#	cat temp2.txt > temp.txt
#	rm temp2.txt
#	while [ $lines -ne 0 ]
#	do
#		line=$( head -n 1 temp.txt )
#		pid1=$( echo "$line" | cut -d "," -f 1 )
#		path=$( echo "$line" | cut -d "," -f 3 )
#		len=$( echo ${#path} )
#		(( len-= 2 ))
#		name=${path: -$len}
#		mem=$( echo "$line" | cut -d "," -f 5 )
#		cpu=$( echo "$line" | cut -d "," -f 6 )

#		if [ $1 -eq $pid1 ] 
#		then
#			if [ ! -f "$name"_metrics.csv ]
#			then
#				echo "seconds,%CPU,%memory" > "$name"_metrics.csv
#			fi

#			echo "$SECONDS,$cpu,$mem" >> "$name"_metrics.csv
#		fi

#		(( lines-- ))
#		tail -n "$lines" temp.txt > temp2.txt 
#		cat temp2.txt > temp.txt
#		rm temp2.txt 
#	done
#	rm temp.txt
#}

get_system_stats () {
	stat=$(ifstat --interval=1 | grep ens33)

	rx=$(echo $stat | awk '{print $6;}')
	tx=$(echo $stat | awk '{print $8;}')	

	iostat=$(iostat | grep sda)
	
	kbs=$(echo $iostat | awk '{print $4;}')

	df=$(df -m | grep /dev/mapper/centos-root)
	
	util=$(echo $df | awk '{print $4;}')

	echo "$SECONDS,$rx,$tx,$kbs,$util" >> system_metrics.csv 
}

getprocstats () {
	count=1
	while [ $count -ne 7 ]
	do
		apm="APM$count"
		cpu=$(ps aux | grep $apm) 
		cpu=$(echo $cpu | awk '{print $3}')
		mem=$(ps aux | grep $apm)
		mem=$(echo $mem | awk '{print $4}')
		echo "$SECONDS,$cpu,$mem"
		echo "$SECONDS,$cpu,$mem" >> "$apm"_metrics.csv 
		count=$((count+1))
	done
	
}

main () {
	spawn $1
	echo "" > system_metrics.csv
	echo "" > APM1_metrics.csv
	echo "" > APM2_metrics.csv
	echo "" > APM3_metrics.csv
	echo "" > APM4_metrics.csv
	echo "" > APM5_metrics.csv
	echo "" > APM6_metrics.csv
	#all_lines=$( cat "pids.txt" )
	sleep 5	
	while [ true ] 
	do 
		#echo "getting stats"
		get_system_stats $1
		#echo "system stats gotten"
		#for line1 in $all_lines;
		#do
		#	getprocstats $line1
		#done
		getprocstats
		#echo "stats gotten"
		sleep 5
	
	done
}


main $1
