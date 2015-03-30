#!/bin/bash


## Script para monitoramento de sistema com o cmd "vmstat" ##
#
#name: vmstat.sh 
#based
#date: 05/01/05
# Walter Gargarela Junior / Ismar Rainer de Castro
# 
#Changed 
#date 30/03/2015
#Walter Gargarela Junior @waltergargarela

## Variaveis do vmstat.sh ##

bold=`tput smso;tput bold`
offbold=`tput rmso`
hostname=`uname -n`
PS3="ENTRE COM A OPCAO DESEJADA: "


##Limpa Tela 

clear

## Tela Principal ##

echo -e "\n ${bold} *** VMSTAT.SH *** ${offbold} " 
echo -e "\n hostname => ${bold} $hostname ${offbold} "
#print "system details =>\n $detail "
echo  -e "\n #################################### \n"

select applic in Screen_Mode Report_Mode Man_Vmstat Sair
do 
	case $applic in
		Screen_Mode)
			echo -e "\n Comando sugerido vmstat -a 1\n " 
			read -p "Insira a bagaca: " opcao
			read -p "Insira o tempo de intervalo: " intervalo
			read -p "Insira a quantidade de intervalos: " quant
			clear
			/usr/bin/vmstat $opcao $intervalo $quant
			sleep 5
			./vmstat.sh
			break # pkill vmstat.sh
			clear 
			;;

		Report_Mode)
			read -p "insira a opcao do vmstat: " opcao
			read -p "insira o tempo de intervalo: " intervalo
                        read -p "insira a quantidade de intervalos: " quant
			read -p "indique o local e nome do arquivo: " loc_file
                        /usr/bin/vmstat $opcao $intervalo $quant  > $loc_file &
			echo -e "\n salvando arquivo >>$loc_file<< "
                        sleep 5
                        ./vmstat.sh
                        break # pkill vmstat.sh
                        clear
                        ;;

		Man_Vmstat)
			/usr/bin/man vmstat
			./vmstat.sh
			break # pkill vmstat.sh
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

