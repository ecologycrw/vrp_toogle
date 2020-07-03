# Introdução:

Este sistema foi desenvolvido para uma melhor imersão em relação ao toogle em sua cidade. Com o Toogle Blip v1, você consegue adicionar de forma organizada quais os grupos poderão usar dessa função.

# Instalação: Toogle Blip v1

Esse sistema foi desenvolvido em cima do framework vRPEX.

- Faça o download e descompacte o ```vrp_toogle``` em seu computador;
- Abra o seu recources/ ou em alguma pasta que você queira;
- Copia o ```vrp_toogle``` para o diretorio da pasta desejada.
- Localize o ```server.cfg``` do seu servidor e adicione o start vrp_toogle, para que o mesmo seja iniciado com o seu servidor.

# Como funciona?

O ```Toogle Blip v1``` é baseado em sistema de blips, ou seja: o jogador só conseguirá entrar ou sair de serviço, caso o mesmo vá até a coordenada estabelecida por você e pressione a tecla ```E```.
O sistema irá verificar se ele tem ou não a ```permissão``` de acessar o ```blip``` e irá identificar qual o grupo ele pertence e se esse grupo está setado no arquivo no ```local grupos```.

# Configurações

## Adicione as localizações e permissões do grupos.

###### [CLIENT.LUA]
> Vá até o client.lua e localize a variavel ```locais``` em seguida insira o [id], seguido da coodenada odne ficará o blip e no final a permissão para acesso naquela coordenada que você acabou de adicionar.

|         Variável       |         Descrição        |
|---|---|
| id  |  Faça na ordem de index, ou seja, se tem 2 blips, coloque ```['id'] = 1``` e ```['id'] = 2```, assim por diante.  |
| x  |  Coordenada X  |
| y  |  Coordenada Y  |
| z  |  Coordenada Z  |
| h  |  Coordenada H - Usada para informar o posicionamento do blip  |
| perm  |  Permissão para acessar o blip  |

## Adicione os grupos que tem no seu servidor.

###### [SERVER.LUA]
> Vá até o server.lua localize a variavel ```local grupos``` e adicione os grupos onde:

|         Variável       |         Descrição        |
|---|---|
| profissão  |  Digite o nome da profissão dentro das aspas ""  |
| blips  |  Caso queira que o grupo gere blips de localizações pelo mapa, digite ```1``` para **true** e ```0``` para **false**  |

- ⛔ Importante: Adicione a permissão ```toogle.permissao``` em todos os grupos que estarão em serviço e coloque um ```if not vRP.hasPermission(user_id,"toogle.permissao") then``` no /roupas /jaqueta/ /blusa, para caso o jogador esteja em serviço e os mesmos não consiga mudar de roupa estando serviço;

## Adicione os uniformes para cada grupo.

###### [SERVER.LUA]
> Vá até o server.lua localize a variavel ```local uniformes``` onde [""], deverá ser colocado o nome do seu uniforme. Exemplo: ["Policia"]

- A numeração das roupas, normalmente você encontra no script do ```/vroupas```

## Observações

- Coloque o nome do uniforme igual ao nome do grupo, para que não haja conflitos e acabe não funcionando como deve.
- Sempre que for criar um grupo de ```Paisana```, coloque > Paisana, com o p maiusculo. Exemplo > ```PaisanaBOPE```
- Recomendado desativar o comando ```/preset``` e o ```/toogle```.

:+1: Sistema  desenvolvido por ```Ecologycrw``` e pegando como base a lógica do ```pairs``` desenvolvida pelo !Felipe :shipit:

