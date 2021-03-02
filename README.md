# scripts
 BACKPEANDO SEUS SWITCH HUAWEI S67XX
 
 #PRIMEIRO HABILITAR O AUTO-SAVE DIARIO DAS CONF DO SWITCH
set save-configuration interval 1440


#DEPOIS CRIE UMA ACL COM PERMIÇÃO APENAS PARA O IP DO LINUX QUE VAI PUXAR O BACKUP DAS CONF
acl name FTP-BACKUP 2001
 rule 5 permit source 10.0.0.1 0
 rule 100 deny


#HABILITE O FTP SERVER DO SWITCH E CHAME A ACL DE ACESSO, COM ISSO O SEU FTP ESTÁ SEGURO.
FTP server enable
FTP acl 2001


#CRIE UM USUARIO PARA LOGAR E PUXAR O ARQUIVO DE CONFIGURAÇÃO DO SWITCH.
aaa
local-user backup password irreversible-cipher SUASENHA
 local-user backup privilege level 15
 local-user backup ftp-directory flash:/
 local-user backup service-type ftp
 
 -------------------------------------------------------------------------------------------------
 
 ENTRE NA MAQUINA LINUX DEBIAN, ;)

#INSTALE OS PACOTES NECESSARIOS
apt install wget zip unzip git -y

#CRIE EXATAMENTE ESSE CAMINHO POIS O SCRIPT VAI JOGAR EXATAMENTE PARA ESSE DIRETORIO
mkdir -p /root/bck/huawei

#CLONE MEU REPOSITORIO DO GITHUB
git clone https://github.com/brunopentest/scripts.git

#ENTRE NO DIRETORIO E Dê PERMISSÃO DE EXEC
cd scripts
cp bck-switch-huawei.sh /root/bck-switch-huawei.sh
cd /root
chmod +x bck-switch-huawei.sh

AGORA EDITE AS VARIAVES USER E PASS DENTRO DO EXECUTAVEL DE ACORDO COM O ACESSO CRIADO NO SWICTH.

#AGORA SÓ COLOCAR O SCRIPT NA CRON
crontab -e

00 03 * * * ./bck-switch-huawei.sh 192.168.0.1 sw-mpls-pe1-bck

#PRONTO SERÁ FEITO UM BACKUP DIARIO ÀS 03:00 DA MANHÃ
#SERÁ APAGADO OS BACKUP COM MAIS DE 7 DIAS.
