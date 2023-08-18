#########################################################

read -p "Digite o dominio para acessar o Chatwoot (ex: app.dominio.com): " dominiochat
echo ""
read -p "Digite seu email de admin (ex: contato@dominio.com): " emailchat
echo ""

#########################################################

clear

cd

echo "Atualizando a VPS"
sudo apt update
apt upgrade -y

echo "Baixando install.sh do typebot"
wget https://get.chatwoot.app/linux/install.sh

echo "Dando permições ao arquivo"
chmod +x install.sh

echo "iniciando instalação"
echo -e "yes\n$dominiochat\n$emailchat\nyes\nyes" | ./install.sh --install

#########################################################
