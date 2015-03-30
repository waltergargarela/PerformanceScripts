#!/bin/bash


## Script para monitoramento de sistema com o cmd "sar ##
#
#name: sar.sh 
#based
#date: 05/01/05
# Walter Gargarela Junior / Ismar Rainer de Castro
# 
#Changed 
#date 30/03/2015
#Walter Gargarela Junior @waltergargarela

## Variaveis do sar.sh ##

bold=`tput smso;tput bold`
offbold=`tput rmso`
hostname=`uname -n`
PS3="ENTRE COM A OPCAO DESEJADA: "


##Limpa Tela 

clear

## Tela Principal ##

echo -e "\n ${bold} *** SAR.SH *** ${offbold} " 
echo -e "\n hostname => ${bold} $hostname ${offbold} "
#print "system details =>\n $detail "
echo  -e "\n #################################### \n"

select applic in Screen_Mode Report_Mode Man_Sar Sair
do 
	case $applic in
		Screen_Mode)
			echo -e "\n Comando básico sugerido: sar 1 " 
			echo -e "\n Comando sugerido para capturar infos por processador: sar -P ALL 1 " 
			echo -e "\n >>${bold} CUIDADO ${offbold}<< Comando para obter infos completas do sistema: sar -A 1\n " 
			read -p "Insira a opcao: " opcao
			read -p "Insira o tempo de intervalo: " intervalo
			read -p "Insira a quantidade de intervalos: " quant
			clear
			/usr/bin/sar $opcao $intervalo $quant
			sleep 5
			./sar.sh
			break # pkill sar.sh
			clear 
			;;

		Report_Mode)
			read -p "insira a opcao do sar: " opcao
			read -p "insira o tempo de intervalo: " intervalo
                        read -p "insira a quantidade de intervalos: " quant
			read -p "indique o local e nome do arquivo: " loc_file
                        /usr/bin/sar $opcao $intervalo $quant  > $loc_file &
			echo -e "\n salvando arquivo >>$loc_file<< "
                        sleep 5
                        ./sar.sh
                        break # pkill sar.sh
                        clear
                        ;;

		Man_Sar)
			/usr/bin/man sar
			./sar.sh
			break # pkill sar.sh
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

