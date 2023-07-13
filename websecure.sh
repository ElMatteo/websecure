#!/bin/bash
#Checking if apache is installed
echo "\n\n \e[0;31m --[< WEB SECURE BY MATTEO29C >]-- \e[0m"
sleep 1
echo "\e[1;33mChecking if apache2 is installed... \e[0m"
sleep 1
if dpkg -s apache2 >/dev/null 2>&1; then
    echo "\e[1;33mapache2 is already installed. Skipping this step.\e[0m"
else
    #Installing apache2
    echo "\e[1;33mapache2 not found.\e[0m"
    sleep 1
    echo "\e[1;33mInstalling apache2...\e[0m\n\n"
    sleep 1
    apt-get install apache2 -y
    echo "\n\n\e[1;33mapache2 is now installed !\e[0m"
fi
file="/etc/apache2/apache2.conf"
ttw="#Cache le contenu de ServerTokens, le nom de domaine et le port utilisé.\nServerSignature Off\n#Cache les informations dans le header\nServerTokens Prod\n\n<Directory /var/www/html>\n   Options -Indexes\n</Directory>"
#Check user permissions
if [ ! -w "$file" ]; then
  echo "\e[0;33mVous n'avez pas les permissions pour écrire dans le fichier $file.\e[0m"
  exit 1
fi
echo "\e[1;33mSecuring apache2...\e[0m"
sleep 2
#Securing apache2
echo "$ttw" >> "$file"
sed -i 's/KeepAliveTimeout 5/KeepAliveTimeout 10/' /etc/apache2/apache2.conf
sed -i 's/Timeout 300/Timeout 30/' /etc/apache2/apache2.conf
echo "MaxClients 300" >> "$file"
echo "\e[1;33mApache2 is now secured, up and running !\e[0m"

#Restarting apache2 to apply moficiations
systemctl restart apache2
