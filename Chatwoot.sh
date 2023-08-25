#########################################################
#
# LOADING
#

loading() {
    local duration=2
    local width=$2 
    local interval=0.02
    local progress=0     

    while [ $progress -le 100 ]; do
        local bar=$(printf "[%-${width}s]" $(printf "=%.0s" $(seq 1 $(($progress * $width / 100)))))
        printf "\rCarregando Auto Instalador... $bar%3d%%" $progress
        sleep $interval
        progress=$((progress + 1))
    done

    clear
}

width=100

loading1() {
    local duration=2
    local width=$2 
    local interval=0.02
    local progress=0     

    while [ $progress -le 100 ]; do
        local bar=$(printf "[%-${width}s]" $(printf "=%.0s" $(seq 1 $(($progress * $width / 100)))))
        printf "\rIniciando Instalação... $bar%3d%%" $progress
        sleep $interval
        progress=$((progress + 1))
    done

    clear
}


clear

loading 2 $width

clear

echo ""
echo -e "\e[93m===============================================\e[0m"
echo -e "\e[93m=                                             =\e[0m"
echo -e "\e[93m= Preencha as informações solicitadas abaixo  =\e[0m"
echo -e "\e[93m=                                             =\e[0m"
echo -e "\e[93m===============================================\e[0m"
echo ""
read -p "Digite o dominio para acessar o Chatwoot (ex: app.dominio.com): " dominiochat
echo ""
#read -p "Digite o nome da sua empresa (ex: OrionDesign): " empresachatwoot
#echo ""
read -p "Digite seu email de admin (ex: contato@dominio.com): " emailchat
echo ""

read -p "Você deseja configurar o e-mail de envio? (y/n): " confirma2
if [ "$confirma2" == "y" ]; then
read -p "Digite seu email de envio (ex: contato@dominio.com): " emailchatenvio
echo ""
read -p "Digite o Dominio do seu SMTP (ex: oriondesign.art.br | ex: gmail.com): " dominiosmtpchatwoot
echo ""
read -p "Digite o Host SMTP (ex: smtp.hostinger.com): " smtpchatwoot
echo ""
read -p "Digite a Porta SMTP (ex: 465): " portachatwoot
echo ""
read -p "Senha do seu Email (se for Gmail precisa ser senha de aplicativo): " senhaemailchatwoot
echo ""

#
# FIM DE PERGUNTAS PARA VARIAVEIS
#
#########################################################
#
# VERIFICAÇÃO DE DADOS
#

clear
echo "Email admin: $emailchatenvio"
echo "Dominio SMTP: $dominiosmtpchatwoot"
echo "Host SMTP: $smtpchatwoot"
echo "Porta SMTP: $portachatwoot"
echo "Senha do Email: $senhaemailchatwoot"
elif [ "$confirma2" == "n" ]; then
    echo "Prosseguindo a instalação."
    exit 0
echo ""
echo "Link do chatwoot: $dominiochat"
echo "Nome da empresa: $empresachatwoot"

echo ""
echo ""
read -p "As informações estão certas? (y/n): " confirma1
if [ "$confirma1" == "y" ]; then

#
# FIM DE VERIFICAÇÃO DE DADOS
#
#########################################################
#
# MENSAGEM DE INSTALANDO
#

clear


echo -e "\e[32m|Instalando\e[0m"


loading1 2 $width

#
# FIM DE MENSAGEM DE INSTALANDO
#
#########################################################
#
# INSTALANDO DEPENDENCIAS
#

cd

sudo apt update

apt upgrade -y

sudo timedatectl set-timezone America/Sao_Paulo

wget https://get.chatwoot.app/linux/install.sh

chmod +x install.sh

clear

echo -e "yes\n$dominiochat\n$emailchat\nyes\nyes" | ./install.sh --install

#
# FIM DE BAIXANDO CHATWOOT E EXECUTANDO
#
#########################################################
#
# EDITANDO .ENV + GUARDANDO POSTGRES
#

cd

cd /home/chatwoot/chatwoot

#postgres_password=$(grep -oP '(?<=POSTGRES_PASSWORD=).+' /home/chatwoot/chatwoot/.env)

sed -i "s/# DEFAULT_LOCALE=en/DEFAULT_LOCALE=pt_BR/g" /home/chatwoot/chatwoot/.env
#sed -i "s/ENABLE_ACCOUNT_SIGNUP=false/ENABLE_ACCOUNT_SIGNUP=true/g" /home/chatwoot/chatwoot/.env
#sed -i "s/^MAILER_SENDER_EMAIL=.*/MAILER_SENDER_EMAIL='$empresachatwoot <$emailchatenvio>'/" /home/chatwoot/chatwoot/.env
sed -i "s/^FRONTEND_URL=.*/FRONTEND_URL=https://$dominiochat/" /home/chatwoot/chatwoot/.env
if [ "$confirma2" == "y" ]; then
sed -i "s/^SMTP_DOMAIN=.*/SMTP_DOMAIN=$dominiosmtpchatwoot/" /home/chatwoot/chatwoot/.env
sed -i "s/^SMTP_ADDRESS=.*/SMTP_ADDRESS=$smtpchatwoot/" /home/chatwoot/chatwoot/.env
sed -i "s/^SMTP_PORT=.*/SMTP_PORT=$portachatwoot/" /home/chatwoot/chatwoot/.env
sed -i "s/^SMTP_USERNAME=.*/SMTP_USERNAME=$emailchatenvio/" /home/chatwoot/chatwoot/.env
sed -i "s/^SMTPOR_PASSWD=.*/SMTP_PASSWORD=$senhaemailchatwoot/" /home/chatwoot/chatwoot/.env
sed -i "s/^SMTP_AUTHENTICATION=.*/SMTP_AUTHENTICATION=login/" /home/chatwoot/chatwoot/.env
sed -i "s/^FORCE_SSL=.*/FORCE_SSL=true/" /home/chatwoot/chatwoot/.env

systemctl daemon-reload && systemctl restart chatwoot.target

#
# FIM DE EDITANDO .ENV + GUARDANDO POSTGRES
#
#########################################################
#
# HABILITANDO CONFIGURAÇÕES OCULTAS DO CHATWOOT
#

sudo -u postgres psql -d chatwoot_production -c "UPDATE installation_configs SET locked = false;"

#
# FIM DE HABILITANDO CONFIGURAÇÕES OCULTAS DO CHATWOOT
#
#########################################################
#
# MENSAGEM DE INSTLADO + DADOS
#

cd
cd
cd

echo -e "\e[32m                  Instalado                                    \e[0m"              
echo -e "\e[32mAcesse seu Chatwoot: https://$dominiochat\e[0m"
echo -e "\e[32m\e[0m"

#
# FIM DE MENSAGEM DE INSTLADO + DADOS
#
#########################################################
#
# USUARIO PREENCHEU DADOS ERRADOS
#

elif [ "$confirma1" == "n" ]; then
    echo "Encerrando a instalação, por favor, inicie a instalação novamente."
    exit 0
else
    echo "Resposta inválida. Digite 'y' para confirmar ou 'n' para encerrar a instalação."
    exit 1
fi

#
# FIM DE USUARIO PREENCHEU DADOS ERRADOS
#
#########################################################
