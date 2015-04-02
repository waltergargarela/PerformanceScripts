#!/bin/ksh


## Script para monitoramento de sistema com o cmd "sar" ##
#
#name: sar.ksh
#date: 05/01/05
# Walter Gargarela Junior / Ismar Rainer de Castro


## Variaveis de ambientes ##
PATH=/usr/bin:/usr/sbin:/usr/local/bin:/opt/sfw/bin
MANPATH=$MANPATH:/usr/dt/man:/usr/local/man:/opt/sfw/man

export PATH MANPATH

## Variaveis do sar.ksh ##

bold=`tput smso;tput bold`
offbold=`tput rmso`
hostname=`uname -n`
detail=`/usr/bin/uname -X|sed '6,8d'`
PS3="ENTRE COM A OPCAO DESEJADA: "

## Variaveis "sar" Screen_Mode ##

TTY=`tty |sed "s:\/dev\/::g"`
ID_DISP=`who |grep pts/12|nawk '{print $6}'|sed "s:(::g"|sed "s:)::g"`
DISPLAY=localhost$ID_DISP

export DISPLAY


##Limpa Tela 

clear

## Tela Principal ##

print "${bold} *** SAR.KSH *** ${offbold} \n"
print "hostname => ${bold} $hostname ${offbold} \n"
#print "system details =>\n $detail "
print "####################################"

select applic in Screen_Mode Report_Mode Man_Sar Sair
do 
	case $applic in
		Screen_Mode)
			read opcao?"insira a opcao do sar: "
			read intervalo?"insira o tempo de intervalo: "
			read quant?"insira a quantidade de intervalos: "
			/usr/dt/bin/dtterm -name SAR.KSH--Screen_Mode -e /usr/bin/sar $opcao $intervalo $quant  &
			./sar.ksh
			break # pkill sar.ksh
			clear 
			;;

		Report_Mode)
			read opcao?"insira a opcao do sar: "
			read intervalo?"insira o tempo de intervalo: "
                        read quant?"insira a quantidade de intervalos: "
			read loc_file?"indique o nome do arquivo: "
                        /usr/bin/sar $opcao $intervalo $quant  >../output/sar/$loc_file &
			echo "salvando arquivo >>$loc_file<< em: ../output/sar/"
			sleep 5
                        ./sar.ksh
                        break # pkill sar.ksh
                        clear
                        ;;

		Man_Sar)
			 /usr/dt/bin/dtterm -name SAR.KSH--Man_Sar -e /usr/bin/man sar &
			./sar.ksh
			break # pkill sar.ksh
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

