#!/bin/bash
#   Gerador de Crachá em Shell Script e Yad
#   version: v1.0.0
#   developer: Walderlan Sena <eu@walderlan.xyz>
#   site: https://www.github.com/WalderlanSena/yad

# Verificando se o yad está instalado no sistema
if [ -e /usr/bin/yad ] # Se o programa existe
then
    # Define a localização do layout do crachá a ser gerado
    layoutCracha=$(pwd)/"viewCh01.sh"

    # Inicio do script, formulario de captura dos dados
    FORM=$(
            yad     --center --title="Gerador de Crachar Automático v1.0.0" \
                    --text="Preencha todos os campos" --justify=center      \
                    --width=600                                             \
                    --height=300                                            \
                    --fixed                                                 \
                    --image="img/pass.png"                                  \
                    --window-icon=img/list.png                              \
                    --form                                                  \
                    --field="Nome :" ""                                     \
                    --field="Email:" ""                                     \
                    --field="Nivel:":CB Administrador!Cliente!Técnico       \
                    --field="Cargo:" ""                                     \
                    --field="Foto:":FL "$HOME/Imagens"                      \
                    --field="Salvar Crachá":DIR "$HOME"                     \
                    --button="Gerar chachá"                                                
    ) # end function FORM

    # Capturando dados e verificandos dados cadatrados

    nome=$(echo  "$FORM"  | cut -d "|" -f 1)
    email=$(echo "$FORM"  | cut -d "|" -f 2)
    nivel=$(echo "$FORM"  | cut -d "|" -f 3)
    cargo=$(echo "$FORM"  | cut -d "|" -f 4)
    foto=$(echo  "$FORM"  | cut -d "|" -f 5)
    salve=$(echo "$FORM"  | cut -d "|" -f 6)

    # Verifica se o arquivo referênciando como foto existe
    if ! [ -e "$foto" ]
        then
            # Caso a mesma não exista recebe uma imagem padrão
            foto=img/semfoto.png
    fi #end if
    
    # Importando modelo de crachá
    if ! [ -e $layoutCracha ]
        then
            yad --center                                                \
                --title="Atenção:: Erro 001 ao gerar o crachá"          \
                --width=500                                             \
                --heigth=200                                            \
                --fixed                                                 \
                --no-buttons                                            \
                --text="Erro ao gerar ao crachá" --text-align="center"                               
        else
            if  [ -n $nome ] || [ -n $email ] || [ -n $cargo ]
                then
                    # Importando layout para a script
                    source $layoutCracha
                    # Criando e salvando um novo crachar em um local especifico
                    echo $MODEL > "$salve"/Cracha-"$nome".html
                    clear # Limpando a tela do terminal
                    yad     --title="Parabéns, Crachá Gerado !"            \
                            --center                                       \
                            --width=350                                    \
                            --height=110                                   \
                            --fixed                                        \
                            --progress-text="Concluido 100%  !"            \
                            --percentage=99                                \
                            --progress --pulsate --auto-kill               \
                            --text-align=center                            \
                            --button=Fechar                                \
                            --text="Crachá do(a) $nome gerado com sucesso"
            else
                yad --center                                            \
                --title="Atenção:: 002 erro ao gerar o crachá"          \
                --width=500                                             \
                --heigth=200                                            \
                --fixed                                                 \
                --button gtk-info                                       \
                --text="Preecha todos os campos..." --text-align="center"    
            fi #enf if
    fi #end if
else
    echo "Desculpe o Yad não foi encontrado !
          Em distro baseadas em Debian utilize para instalar:
          sudo apt-get install yad"
fi  #end if