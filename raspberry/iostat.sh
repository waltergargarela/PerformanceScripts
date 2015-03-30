#!/bin/bash


## Script para monitoramento de sistema com o cmd "iostat" ##
#
#name: iostat.ksh
#based
#date: 05/01/05
# Walter Gargarela Junior / Ismar Rainer de Castro
# 
#Changed 
#date 30/03/2015
#Walter Gargarela Junior @waltergargarela


## Variaveis do iostat.ksh ##

bold=`tput smso;tput bold`
offbold=`tput rmso`
hostname=`uname -n`
PS3="ENTRE COM A OPCAO DESEJADA: "


##Limpa Tela 

clear

## Tela Principal ##

echo -e "\n ${bold} *** IOSTAT.SH *** ${offbold} " 
echo -e "\n hostname => ${bold} $hostname ${offbold} "
#print "system details =>\n $detail "
echo  -e "\n #################################### \n"

select applic in Screen_Mode Report_Mode Man_Iostat Sair
do 
	case $applic in
		Screen_Mode)
			echo -e "\n Comando sugerido iostat -h 1\n " 
			read -p "Insira a opcao: " opcao
			read -p "Insira o tempo de intervalo: " intervalo
			read -p "Insira a quantidade de intervalos: " quant
			clear
			/usr/bin/iostat $opcao $intervalo $quant
			sleep 5
			./iostat.sh
			break # pkill iostat.ksh
			clear 
			;;

		Report_Mode)
			read -p "insira a opcao do iostat: " opcao
			read -p "insira o tempo de intervalo: " intervalo
                        read -p "insira a quantidade de intervalos: " quant
			read -p "indique o local e nome do arquivo: " loc_file
                        /usr/bin/iostat $opcao $intervalo $quant  > $loc_file &
			echo -e "\n salvando arquivo >>$loc_file<< "
                        sleep 5
                        ./iostat.sh
                        break # pkill iostat.ksh
                        clear
                        ;;

		Man_Iostat)
			/usr/bin/man iostat 
			./iostat.sh
			break # pkill iostat.ksh
			clear
			;;

		Sair)
			break
			;;
		*)
			echo "Entre com uma opcao valida."
	                ;;
        esac
done
clear

