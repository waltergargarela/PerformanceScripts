#!/bin/ksh


## Script para monitoramento de sistema com o cmd "iostat" ##
#
#name: iostat.ksh
#date: 05/01/05
# Walter Gargarela Junior / Ismar Rainer de Castro


## Variaveis de ambientes ##
PATH=/usr/bin:/usr/sbin:/usr/local/bin:/opt/sfw/bin
MANPATH=$MANPATH:/usr/dt/man:/usr/local/man:/opt/sfw/man

export PATH MANPATH

## Variaveis do iostat.ksh ##

bold=`tput smso;tput bold`
offbold=`tput rmso`
hostname=`uname -n`
detail=`/usr/bin/uname -X|sed '6,8d'`
PS3="ENTRE COM A OPCAO DESEJADA: "

## Variaveis "iostat" Screen_Mode ##

TTY=`tty |sed "s:\/dev\/::g"`
ID_DISP=`who |grep pts/12|nawk '{print $6}'|sed "s:(::g"|sed "s:)::g"`
DISPLAY=localhost$ID_DISP

export DISPLAY

##Limpa Tela 

clear

## Tela Principal ##

print "${bold} *** IOSTAT.KSH *** ${offbold} \n"
print "hostname => ${bold} $hostname ${offbold} \n"
#print "system details =>\n $detail "
print "####################################"

select applic in Screen_Mode Report_Mode Man_Iostat Sair
do 
	case $applic in
		Screen_Mode)
			read opcao?"insira a opcao do iostat: "
			read intervalo?"insira o tempo de intervalo: "
			read quant?"insira a quantidade de intervalos: "
			/usr/dt/bin/dtterm -name IOSTAT.KSH--Screen_Mode -e /usr/bin/iostat $opcao $intervalo $quant  &
			./iostat.ksh
			break # pkill iostat.ksh
			clear 
			;;

		Report_Mode)
			read opcao?"insira a opcao do iostat: "
			read intervalo?"insira o tempo de intervalo: "
                        read quant?"insira a quantidade de intervalos: "
			read loc_file?"indique o local e nome do arquivo: "
                        /usr/bin/iostat $opcao $intervalo $quant  >../output/iostat/$loc_file &
			echo "salvando arquivo >>$loc_file<< em: ../output/iostat/"
                        sleep 5
                        ./iostat.ksh
                        break # pkill iostat.ksh
                        clear
                        ;;

		Man_Iostat)
			 /usr/dt/bin/dtterm -name IOSTAT.KSH--Man_Iostat-e /usr/bin/man iostat &
			./iostat.ksh
			break # pkill iostat.ksh
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

