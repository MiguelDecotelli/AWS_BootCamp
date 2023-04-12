@@ -0,0 +1,52 @@
#!/bin/bash

echo "============DEFINIÇÕES DO DESAFIO============"
echo "- Excluir arquivos e diretórios criados anteriormente;"
echo "- Todo provisionamento deve ser feito em um arquivo do tipo Bash Script;"
echo "- O dono de todos os diretórios criados será o usuário root;"
echo "-Todos os usuários terão permissão total dentro do diretório publico"
echo "- Os usuários de cada grupo terão permissão total dentro de seu respectivo diretório;"
echo "- Os usuários não poderão ter permissão de leitura, escrita e execução em diretórios de departamentos que eles não pertencem;"
echo "- Subir arquivo de script criado para sua conta no GitHub"

echo "============RESOLUÇÃO DO DESAFIO============"


echo "Criando diretórios..."
mkdir /publico /adm /ven /sec
echo "diretórios criados!"


echo "Criando grupos..."
groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC
echo "Grupos Criados!"

echo "Definindo propriedades dos grupos..."
chown root:GRP_ADM /adm/
chown root:GRP_VEN /ven/
chown root:GRP_SEC /sec/
echo "Propriedades definidas!"

echo "Alterando permissões de acesso..."
chmod 777 /publico
chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
echo "Permissões alteradas!"


echo "Criando usuários..."
useradd carlos -c "Carlos Maçaranduba" -m -s /bin/bash -G GRP_ADM
useradd maria -c "Maria do Rosário" -m -s /bin/bash -G GRP_ADM
useradd joao -c "João McClaine" -m -s /bin/bash -G GRP_ADM
useradd debora -c "Debora Bloch" -m -s /bin/bash -G GRP_VEN
useradd sebastiana -c "Sebastiana das Candongas" -m -s /bin/bash -G GRP_VEN
useradd roberto -c "Roberto Carlos" -m -s /bin/bash -G GRP_VEN
useradd josefina -c "Josefina de Jesus" -m -s /bin/bash -G GRP_SEC
useradd amanda -c "Amanda Meirelles" -m -s /bin/bash -G GRP_SEC
useradd rogerio -c "Rogério Moore" -m -s /bin/bash -G GRP_SEC
echo "Usuários criados!"