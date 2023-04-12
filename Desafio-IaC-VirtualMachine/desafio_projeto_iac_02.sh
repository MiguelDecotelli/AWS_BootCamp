#!/bin/bash

echo "============ DEFINIÇÕES DO DESAFIO ============"

echo "- Atualizar o servidor"
echo "- Instalar o samba"
echo "- Instalar o apache2"
echo "- Instalar o mysql"
echo "- Instalar o unzip"
echo "- Baixar a aplicação Linux Site DIO"
echo "- copiar os arquivos da aplicação no diretório padrão do apache"
echo "- Subir arquivo de script para um repositório no GitHub"


echo "Atualizando o servidor..."
apt-get update
apt-get upgrade -y
echo "Servidor atualizado!"

echo "Instalando e configurando pacotes:"

echo "Samba..."
apt install samba -y

echo "Apache2..."
apt install apache2 -y

echo "Mysql..."
apt install mysql-server-8.0 -y

echo "Unzip..."
apt install unzip

echo "Instalações concluídas!"

echo "Baixando aplicação na pasta tmp..."
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip -P /tmp
echo "Download concluído!"

echo "Descompactando e movendo arquivos para pasta padrão do Apache..."
unzip /tmp/main.zip -d /tmp
cp -R /tmp/linux-site-dio-main/* /var/www/html

echo "Desafio concluído com sucesso!"