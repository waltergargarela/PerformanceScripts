#!/bin/bash


## Script para monitoramento de sistema com o cmd "iostat" ##
#
#name: iostat.sh
#Based
#date: 05/01/05
# Walter Gargarela Junior / Ismar Rainer de Castro
#Changed
#date 30/03/2015
#Walter Gargarela Junior @waltergargarela

## Variaveis do iostat.sh ##

bold=`tput smso;tput bold`
offbold=`tput rmso`
hostname=`uname -n`
PS3="ENTRE COM A OPCAO DESEJADA: "


##Limpa Tela 

clear

## Tela Principal ##

print "${bold} *** IOSTAT.SH *** ${offbold} \n"
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
			gnome-terminal -e /usr/bin/iostat $opcao $intervalo $quant  &
			./iostat.sh
			break # pkill iostat.sh
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
                        ./iostat.sh
                        break # pkill iostat.sh
                        clear
                        ;;

		Man_Iostat)
			 gnome-terminal -e /usr/bin/man iostat &
			./iostat.sh
			break # pkill iostat.sh
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

