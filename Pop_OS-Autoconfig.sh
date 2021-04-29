#!/usr/bin/env bash
# ----------------------------- VARIÁVEIS ----------------------------- #

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_VS_CODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
URL_GITHUB_DESKTOP="https://github.com/shiftkey/desktop/releases/download/release-2.7.2-linux1/GitHubDesktop-linux-2.7.2-linux1.deb"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(

 variety
)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
#sudo dpkg --add-architecture i386

## Atualizando o repositório ##
sudo apt update -y

# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VS_CODE"             -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GITHUB_DESKTOP"      -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

##sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y

## Instalando pacotes Flatpak ##

flatpak install flathub com.spotify.Client -y #Spotify
flatpak install flathub org.deluge_torrent.deluge -y #Deluge
flatpak install flathub org.videolan.VLC -y #VLC

## Instalando pacotes Snap ##

# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
