#!/bin/bash

# ===========================================================
#  Script docker-deploy.sh – Test DevOps Été 2025
# Objectif : Automatiser le déploiement d'une application Node.js + MongoDB
# Auteur : Ghassen
# ===========================================================

# Les variables
REPO_URL="https://github.com/ghasseen/testdevops.git"     # Lien vers mon repository Git
APP_DIR="nodeapp"                                          # Dossier de destination du clone
DOCKER_IMAGE="ghasseen/nodeapp2025"                        # Nom de l'image Docker à créer
APP_PORT=3000                                              # Port HTTP de l'application

#  Nettoyer s'il y a déjà un dossier cloné
if [ -d "$APP_DIR" ]; then
  echo "🧹 Suppression de l'ancien dossier $APP_DIR..."
  rm -rf "$APP_DIR"
fi

#  Cloner l'application depuis Git
echo " Clonage du dépôt Git depuis : $REPO_URL"
git clone "$REPO_URL" "$APP_DIR"
cd "$APP_DIR" || { echo " Le dossier n'existe pas"; exit 1; }

#  Construire l’image Docker locale
echo "🔧 Construction de l’image Docker : $DOCKER_IMAGE"
docker build -t "$DOCKER_IMAGE" .

#  Pusher l’image sur Docker Hub
echo " Connexion à Docker Hub"
docker login
echo " Push de l’image Docker vers Docker Hub..."
docker push "$DOCKER_IMAGE"

#  Lancer les services via Docker Compose
echo " Lancement de l’application avec Docker Compose..."
docker-compose up -d

# Attendre que l’app démarre
echo " Attente de 5 secondes..."
sleep 5

#  Vérifier le fonctionnement de l’application
echo " Vérification HTTP sur http://localhost:$APP_PORT"
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$APP_PORT)

if [ "$RESPONSE" -eq 200 ]; then
  echo " Application Node.js fonctionnelle ! (HTTP 200)"
else
  echo " Erreur : Application non disponible (HTTP $RESPONSE)"
fi
