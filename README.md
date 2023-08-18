# Auto Instalador do Chatwoot

Este auto instalador foi testado usando uma VPS vazia da Contabo (4vCores + 8Gb Ram) com **Ubunto 20.04**
Nessa versão você pode estar escolhendo as portas na instalação o que possibilita a integração com outras aplicações com qualquer outra aplicação.

### 📌 Observações importantes:

Instalação feita em "###";

Recomendo criar uma snapshot da sua vps para evitar qualquer problema que possa vir acontecer;

Antes de instalar, é de extrema importancia que você crie 1 registro no DNS, sendo ele “app" (não é obrigatório ser "app", você pode escolher outro nome). O registro é do tipo **A**, apontando para o **ip da sua VPS**, com **Proxy desativado** e **TTL Auto** (ou o valor que vier).
<details>
  <summary>Sobre o registro app</summary>
  <i>É através dele que conseguiremos acessar o Endpoint (lembrando que não é obrigatório ser "api", você pode escolher outro nome que não estiver em uso)</i><br><br>
  • Tipo: <b>A</b><br>
  • Entrada: <b>app</b><br>
  • Conteúdo: <b>IP do servidor</b><br><br>
  <img src="https://file.notion.so/f/s/c14b5ac1-d43a-4f18-bd76-4f10bd4262f1/Untitled.png?id=9855df72-743c-439d-b865-ec8391b93cc4&table=block&spaceId=f554c1aa-b56c-4ac0-88b1-4679371e6777&expirationTimestamp=1692072000000&signature=whfO8e8AETlGp2JEWdt0ML-i1QIlPr4kejWSGPXk-qY&downloadName=Untitled.png">
</details>

<hr/>

## 📀 Instalando Chatwoot
### Copie o seguinte comando e cole em seu terminal

Normal
```
sudo apt install -y git && git clone https://github.com/oriondesign2015/AutoInstaladorChatwoot.git && cd AutoInstaladorChatwoot && chmod +x Chatwoot.sh && ./Chatwoot.sh
```

Ao executar esse código, ele pedirá para você fornecer as seguintes informações:
  - A VER

Após preencher os campos corretamente ele já iniciará a instalação e configurações da Evolution.

>
> No final fa instalação, pode ser que apareça uma mensagem pedindo para digitar "Y" e dar "ENTER" para finalizar a instalação da Evolution API.
>

<hr/>

### 💡 Ficou com alguma dúvida?

Entre em contato comigo através do WhatsApp [clicando aqui](http://wa.me/+5511973052593).

<hr/>

### ❤️ Agradecimentos

Agradoço especialmente o <a href="https://github.com/DeividMs">Deivid Santos</a> por ter me ensinado e incentivado a usar o GitHub, alem de me ensinar muitas outras coisas do universo da programação.
