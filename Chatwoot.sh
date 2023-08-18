##########################################################
#
#read -p "Digite o dominio para acessar o Chatwoot (ex: app.dominio.com): " dominiochat
#echo ""
#read -p "Digite seu email de admin (ex: contato@dominio.com): " emailchat
#echo ""
#
##########################################################
#
#clear
#
#cd
#
#echo "Atualizando a VPS"
#sudo apt update
#apt upgrade -y
#
#echo "Baixando install.sh do typebot"
#wget https://get.chatwoot.app/linux/install.sh
#
#echo "Dando permições ao arquivo"
#chmod +x install.sh
#
#echo "iniciando instalação"
#echo -e "yes\n$dominiochat\n$emailchat\nyes\nyes" | ./install.sh --install
#
#########################################################

cd

echo "Modificando env"
#sudo mv .env .env-dev

cd /home/chatwoot/chatwoot

#Guardando postgres_password
postgres_password=$(grep -oP '(?<=POSTGRES_PASSWORD=).+' /home/chatwoot/chatwoot/.env)

#Alterando idioma e Singup
sed -i 's/#DEFAULT_LOCALE=en/DEFAULT_LOCALE=pt_BR/g' /home/chatwoot/chatwoot/.env
sed -i 's/ENABLE_ACCOUNT_SIGNUP=false/ENABLE_ACCOUNT_SIGNUP=true/g' /home/chatwoot/chatwoot/.env

systemctl daemon-reload && systemctl restart chatwoot.target

#momento que na documentação seria criando conta (não irei fazer agora)

sudo -i -u postgres psql
\c chatwoot_production
update installation_configs set locked = false;
\q


