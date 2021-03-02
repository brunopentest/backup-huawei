#!/bin/bash

##########################################################################
# Backup-Switch-Huawei-S6720
# Filename: bck-switch-huawei.sh
# Revision: 1.0
# Date: 17/06/2019
# By: Bruno Cavalcante
# Mail: brunopentest@gmail.com
# EX Execute:
# ./bck-switch-huawei.sh 192.168.0.1 backup-sw-huawei
##########################################################################

######################################
# VARIAVEIS ALIMENTADA PELO EXECUTAR
######################################
IP=$1
FILENAME=$2

#########################
# USUARIO E SENHA DO SW
#########################
USER='backup'
PASS='SUASENHA'

######################################################################################################
# ACESSANDO O SWITCH, TRANSFERINDO O ARQUIVO DE CONFIGURAÇÃO
######################################################################################################
wget --ftp-user=$USER --ftp-password=$PASS ftp://$IP/vrpcfg.zip

########################################################################
# COPIANDO, COLOCANDO DATA E HORA E APAGANDO ARQUIVO ANTIGO DO DEBIAN
########################################################################
cd
unzip vrpcfg.zip
cp vrpcfg.cfg /root/bck/huawei/$FILENAME-$(date "+%d.%m.%Y-%H.%M.%S")
rm vrpcfg.cfg
rm vrpcfg.zip

########################################################################
# APAGANDO OS BCK COM MAIS DE 7 DIAS
########################################################################
cd /root/bck/huawei/
find /root/bck/huawei -type f -mtime +6 -exec rm -rf {} \;

exit 0

########################################################################
# FIM DO SCRIPT
########################################################################
