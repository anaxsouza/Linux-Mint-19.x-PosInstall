#!/usr/bin/env bash
# ----------------------------- VARIÁVEIS ----------------------------- #

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
gnome-shell-extensions
gnome-tweaks
)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO --------------------------------------------------------------------------------------------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## Download e instalaçao de programas externos ##
#mkdir "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_VS_CODE"             -P "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_GITHUB_DESKTOP"      -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
#sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## Instalando pacotes Flatpak ##

flatpak install flathub com.spotify.Client -y #Spotify
flatpak install flathub de.haeckerfelix.Fragments #Fragments
flatpak install flathub org.filezillaproject.Filezilla -y #Filezilla
flatpak install flathub io.github.jeffshee.Hidamari #Hidamari
flatpak install flathub com.axosoft.GitKraken #GitKraken

## Instalando pacotes Snap ##

sudo apt install snapd
sudo snap install authy

## Instalando VScode ##

sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add –
sudo add-apt-repository “deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main”
sudo apt-get update
sudo apt install code

##Instalando Papirus

sudo add-apt-repository ppa:papirus/papirus
sudo apt install papirus-icon-theme

# ------------------------------------------------------------------------------------------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
