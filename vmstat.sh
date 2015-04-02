#!/bin/ksh


## Script para monitoramento de sistema com o cmd "vmstat" ##
#
#name: vmstat.ksh
#date: 05/01/05
# Walter Gargarela Junior / Ismar Rainer de Castro


## Variaveis de ambientes ##
PATH=/usr/bin:/usr/sbin:/usr/local/bin:/opt/sfw/bin
MANPATH=$MANPATH:/usr/dt/man:/usr/local/man:/opt/sfw/man

export PATH MANPATH

## Variaveis do vmstat.ksh ##

bold=`tput smso;tput bold`
offbold=`tput rmso`
hostname=`uname -n`
detail=`/usr/bin/uname -X|sed '6,8d'`
PS3="ENTRE COM A OPCAO DESEJADA: "

## Variaveis "vmstat" Screen_Mode ##

TTY=`tty |sed "s:\/dev\/::g"`
ID_DISP=`who |grep pts/12|nawk '{print $6}'|sed "s:(::g"|sed "s:)::g"`
DISPLAY=localhost$ID_DISP

export DISPLAY


##Limpa Tela 

clear

## Tela Principal ##

print "${bold} *** VMSTAT.KSH *** ${offbold} \n"
print "hostname => ${bold} $hostname ${offbold} \n"
#print "system details =>\n $detail "
print "####################################"

select applic in Screen_Mode Report_Mode Man_Vmstat Sair
do 
	case $applic in
		Screen_Mode)
			read opcao?"insira a opcao do vmstat: "
			read intervalo?"insira o tempo de intervalo: "
			read quant?"insira a quantidade de intervalos: "
			/usr/dt/bin/dtterm -name VMSTAT.KSH--Screen_Mode -e /usr/bin/vmstat $opcao $intervalo $quant  &
			./vmstat.ksh
			break # pkill vmstat.ksh
			clear 
			;;

		Report_Mode)
			read opcao?"insira a opcao do vmstat: "
			read intervalo?"insira o tempo de intervalo: "
                        read quant?"insira a quantidade de intervalos: "
			read loc_file?"indique o local e nome do arquivo: "
                        /usr/bin/vmstat $opcao $intervalo $quant  >../output/vmstat/$loc_file &
			echo "salvando arquivo >>$loc_file<< em: ../output/vmstat/"
                        sleep 5
                        ./vmstat.ksh
                        break # pkill vmstat.ksh
                        clear
                        ;;

		Man_Vmstat)
			 /usr/dt/bin/dtterm -name VMSTAT.KSH-Man_Vmstat -e /usr/bin/man vmstat &
			./vmstat.ksh
			break # pkill vmstat.ksh
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

