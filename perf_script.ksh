#!/bin/ksh


## Script para monitoramento de sistema de sistemas Sun/Solaris  ##
#
#name: perf_script.ksh
#date: 05/01/05
# Walter Gargarela Junior / Ismar Rainer de Castro


## Variaveis de ambientes ##
PATH=/usr/bin:/usr/sbin:/usr/local/bin:/opt/sfw/bin
MANPATH=$MANPATH:/usr/dt/man:/usr/local/man:/opt/sfw/man

export PATH MANPATH

## Variaveis do perf_script.ksh ##

bold=`tput smso;tput bold`
offbold=`tput rmso`
hostname=`uname -n`
detail=`/usr/bin/uname -X|sed '6,8d'`
PS3="ENTRE COM A OPCAO DESEJADA: "

## Variaveis "perf_script" Screen_Mode ##

TTY=`tty |sed "s:\/dev\/::g"`
ID_DISP=`who |grep pts/12|nawk '{print $6}'|sed "s:(::g"|sed "s:)::g"`
DISPLAY=localhost$ID_DISP

export DISPLAY


##Limpa Tela 

clear

## Tela Principal ##

print "${bold} *** Performance Script *** ${offbold} \n"
print "hostname => ${bold} $hostname ${offbold} \n"
#print "system details =>\n $detail "
print "##########################################"
print " Selecione um dos utilitarios do Solaris"
print "       para monitorar o sistema "
print "##########################################"
select applic in SAR IOSTAT MPSTAT VMSTAT Sair
do 
	case $applic in
		SAR)
			/usr/dt/bin/dtterm -name SAR.KSH -e ../sbin/sar.ksh &
			./perf_script.ksh
			break # pkill perf_script.ksh
			clear 
			;;

		IOSTAT)
			/usr/dt/bin/dtterm -name IOSTAT.KSH -e ../sbin/iostat.ksh &
                        ./perf_script.ksh
                        break # pkill perf_script.ksh
                        clear
                        ;;

		MPSTAT)
			/usr/dt/bin/dtterm -name MPSTAT.KSH -e ../sbin/mpstat.ksh &
                        ./perf_script.ksh
                        break # pkill perf_script.ksh
                        clear
                        ;;

		VMSTAT)
			/usr/dt/bin/dtterm -name VMSTAT.KSH -e ../sbin/vmstat.ksh &
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

