#########################################################
clear

echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m ______             _____          _                _____                 _               \e[0m"
echo -e "\e[32m(____  \           / ___ \        (_)              (____ \               (_)              \e[0m"
echo -e "\e[32m ____)  ) _   _   | |   | |  ____  _   ___   ____   _   \ \   ____   ___  _   ____  ____  \e[0m"
echo -e "\e[32m|  __  ( | | | |  | |   | | / ___)| | / _ \ |  _ \ | |   | | / _  ) /___)| | / _  ||  _ \ \e[0m"
echo -e "\e[32m| |__)  )| |_| |  | |___| || |    | || |_| || | | || |__/ / ( (/ / |___ || |( ( | || | | |\e[0m"
echo -e "\e[32m|______/  \__  |   \_____/ |_|    |_| \___/ |_| |_||_____/   \____)(___/ |_| \_|| ||_| |_|\e[0m"
echo -e "\e[32m         (____/                                                             (_____|       \e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"

sleepy 2

clear

echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m _______                   ___  _                                         _        \e[0m"
echo -e "\e[32m(_______)                 / __)(_)                                       | |       \e[0m"
echo -e "\e[32m _         ___   ____   _| |__  _   ____  _   _   ____  _____  ____    __| |  ___  \e[0m"
echo -e "\e[32m| |       / _ \ |  _ \ (_   __)| | / _  || | | | / ___)(____ ||  _ \  / _  | / _ \ \e[0m"
echo -e "\e[32m| |_____ | |_| || | | |  | |   | |( (_| || |_| || |    / ___ || | | |( (_| || |_| |\e[0m"
echo -e "\e[32m \______) \___/ |_| |_|  |_|   |_| \___ ||____/ |_|    \_____||_| |_| \____| \___/ \e[0m"
echo -e "\e[32m                                  (_____|                                          \e[0m"
echo -e "\e[32m          _______  _                                               \e[0m"
echo -e "\e[32m         (_______)| |              _                           _   \e[0m"
echo -e "\e[32m  ___     _       | |__   _____  _| |_  _ _ _   ___    ___   _| |_ \e[0m"
echo -e "\e[32m / _ \   | |      |  _ \ (____ |(_   _)| | | | / _ \  / _ \ (_   _)\e[0m"
echo -e "\e[32m| |_| |  | |_____ | | | |/ ___ |  | |_ | | | || |_| || |_| |  | |_ \e[0m"
echo -e "\e[32m \___/    \______)|_| |_|\_____|   \__) \___/  \___/  \___/    \__)\e[0m"
echo -e "\e[32m                                                                   \e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"

#########################################################

echo ""
echo -e "\e[32mPreencha as informações solicitadas abaixo:\e[0m"
echo ""
read -p "Digite o dominio para acessar o Chatwoot (ex: app.dominio.com): " dominiochat
echo ""
read -p "Digite seu email de admin (ex: contato@dominio.com): " emailchat
echo ""
echo ""
echo "Link do chatwoot: $dominiochat"
echo "Email admin: $emailchat"
echo ""
read -p "As informações estão certas? (y/n): " confirma1
if [ "$confirma1" == "y" ]; then

#########################################################

clear

echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m _                             _                     _                 \e[0m"
echo -e "\e[32m| |                _          | |                   | |                \e[0m"
echo -e "\e[32m| | ____    ___  _| |_  _____ | |  _____  ____    __| |  ___           \e[0m"
echo -e "\e[32m| ||  _ \  /___)(_   _)(____ || | (____ ||  _ \  / _  | / _ \          \e[0m"
echo -e "\e[32m| || | | ||___ |  | |_ / ___ || | / ___ || | | |( (_| || |_| | _  _  _ \e[0m"
echo -e "\e[32m|_||_| |_|(___/    \__)\_____| \_)\_____||_| |_| \____| \___/ (_)(_)(_)\e[0m"
echo -e "\e[32m                                                                       \e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"

sleepy 2

#########################################################

cd

sudo apt update
apt upgrade -y

wget https://get.chatwoot.app/linux/install.sh

sudo timedatectl set-timezone America/Sao_Paulo

chmod +x install.sh

echo -e "yes\n$dominiochat\n$emailchat\nyes\nyes" | ./install.sh --install

#########################################################

cd

echo "Modificando env"

cd /home/chatwoot/chatwoot

sudo mv .env-dev .env

#Guardando postgres_password
postgres_password=$(grep -oP '(?<=POSTGRES_PASSWORD=).+' /home/chatwoot/chatwoot/.env)

#Alterando Idioma e Singup
sed -i 's/# DEFAULT_LOCALE=en/DEFAULT_LOCALE=pt_BR/g' /home/chatwoot/chatwoot/.env
sed -i 's/ENABLE_ACCOUNT_SIGNUP=false/ENABLE_ACCOUNT_SIGNUP=true/g' /home/chatwoot/chatwoot/.env

systemctl daemon-reload && systemctl restart chatwoot.target

#Habilitando configurações ocultas do Chatwoot no banco de dados PostgreSQL
sudo -u postgres psql -d chatwoot_production -c "UPDATE installation_configs SET locked = false;"


#########################################################

cd
cd
cd
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m _                             _              _        \e[0m"
echo -e "\e[32m| |                _          | |            | |       \e[0m"
echo -e "\e[32m| | ____    ___  _| |_  _____ | |  _____   __| |  ___  \e[0m"
echo -e "\e[32m| ||  _ \  /___)(_   _)(____ || | (____ | / _  | / _ \ \e[0m"
echo -e "\e[32m| || | | ||___ |  | |_ / ___ || | / ___ |( (_| || |_| |\e[0m"
echo -e "\e[32m|_||_| |_|(___/    \__)\_____| \_)\_____| \____| \___/ \e[0m"
echo -e "\e[32m                                                       \e[0m"              
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32mAcesse seu Chatwoot: https://$dominio\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32mSenha postgres: $postgres_password\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32mInscreva-se no meu Canal: https://youtube.com/oriondesign_oficial\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32mSugestões ou duvidas: https://wa.me/+5511973052593\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"

#########################################################

elif [ "$confirma1" == "n" ]; then
    echo "Encerrando a instalação."
    exit 0
else
    echo "Resposta inválida. Digite 'y' para confirmar ou 'n' para encerrar a instalação."
    exit 1
fi

