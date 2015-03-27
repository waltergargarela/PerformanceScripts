#!/bin/bash



bold=`tput smso;tput bold`
offbold=`tput rmso`
hostname=`uname -n`
#detail=`/usr/bin/uname -X|sed '6,8d'`
PS3="ENTRE COM A OPCAO DESEJADA: "



select applic in SAR IOSTAT MPSTAT VMSTAT Sair
	do
	case $applic in
		SAR)
			#/usr/bin/lxterminal -t "SAR.KSH" -e ../sbin/sar.ksh &
			sar
			./teste.sh
			break # pkill perf_script.ksh
			clear
			;;
		IOSTAT)
			#/usr/bin/lxterminal -t "IOSTAT.KSH" -e ../sbin/iostat.ksh &
			clear
			iostat -t -h  2 
			#./teste.sh
			#break # pkill perf_script.ksh
			#clear
			;;
		MPSTAT)
			/usr/bin/lxterminal -t "MPSTAT.KSH" -e ../sbin/mpstat.ksh &
			./perf_script.ksh
			break # pkill perf_script.ksh
			clear
			;;
		VMSTAT)
			/usr/bin/lxterminal -t "VMSTAT.KSH" -e ../sbin/vmstat.ksh &
			./perf_script.ksh
			break # pkill perf_script.ksh
				clear
			;;
		Sair)
			break
			;;
		*)
			print "Entre com uma opcao valida."
			;;
	esac
done
clear
