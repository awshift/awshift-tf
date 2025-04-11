#!/bin/bash

# Arrêt en cas d'erreur
set -e

echo "🚀 Début de l'installation..."

# Détection de l'OS
if grep -qi "amazon linux" /etc/os-release; then
    OS="amazon-linux"
elif grep -qi "ubuntu" /etc/os-release; then
    OS="ubuntu"
else
    echo "❌ Système non supporté"
    exit 1
fi

echo "🔍 OS détecté : $OS"

# Mettre à jour le système
echo "📦 Mise à jour du système..."
if [ "$OS" = "amazon-linux" ]; then
    sudo yum update -y
elif [ "$OS" = "ubuntu" ]; then
    sudo apt update -y && sudo apt upgrade -y
fi

# Installer Node.js & npm
echo "⚙️ Installation de Node.js et npm..."
if [ "$OS" = "amazon-linux" ]; then
    curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
    sudo yum install -y nodejs
elif [ "$OS" = "ubuntu" ]; then
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Vérifier l'installation
node -v && npm -v

# Configuration du pare-feu
echo "🌐 Configuration du pare-feu..."
if [ "$OS" = "amazon-linux" ]; then
    sudo firewall-cmd --add-port=3000/tcp --permanent
    sudo firewall-cmd --reload
elif [ "$OS" = "ubuntu" ]; then
    sudo ufw allow 3000
fi

# Cloner l'application et installer les dépendances
echo "📥 Clonage du projet..."
cd /home/ubuntu
git clone https://github.com/awshift/awshift-tf.git
cd awshift-tf
git fetch origin
git checkout -b dev origin/dev

cd app/awshift

echo "📦 Installation des dépendances..."
npm install

AWS_REGION=${AWS_REGION}
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

# Démarrer l'application
echo "🚀 Lancement de l'application..."
npm run dev "next dev"

echo "✅ Installation terminée ! L'application tourne sur le port 3000."
