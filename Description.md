Objectif 
Automatiser le déploiement d’une application Node.js connectée à 
MongoDB avec Docker, Docker Compose, et un script shell. 
L'application devra être accessible via le port 3000, avec persistance 
des données MongoDB sur /srv/databases/node/data. 
Etape1 : on navigue dans le dossier du projet :  
J'ai reçu le dossier myapp contenant les fichiers de l'application. Je l'ai 
extrait et ouvert dans mon terminal : 
Etape2 : Configuration du Dockerfile :  
J'ai complété le fichier Dockerfile pour construire une image Docker de 
l'application Node.js : 
Commentaires :  
il Utilise une image officielle Node.js 18 
il Définit le répertoire de travail 
il copie  
il copie  
les fichiers package.json et installer les dépendances 
le reste du code 
Il copie le code dans l'image 
Il expose le port 3000 
Il démarre l’application avec node app.js 
Etape 3 : Configuration du docker-compose.yml :  
Ce fichier docker-compose.yml définit deux services Docker : 
mongo-devops : un service MongoDB configuré avec une base appdb2025, un 
utilisateur devopsghassen, et des données persistantes montées sur 
/srv/databases/node/data 
node-backend : le service Node.js qui se connecte à MongoDB via une variable 
d’environnement DATABASE 
Le fichier docker-compose.yml a été rédigé conformément aux consignes du test : -Le service node-backend utilise l'image Docker construite localement(Build: 
.) -Le service mongo-devops configure une instance MongoDB sécurisée avec 
un utilisateur, mot de passe et base initiale -La connexion entre les deux services est assurée par la variable 
d’environnement DATABASE -MongoDB est démarré avant l'application grâce à depends_on 
Etape 4 : on itilialise git et dépot  :  
J'ai initialisé un répertoire Git local (testdevops)  et poussé le projet sur un dépôt 
GitHub public : 
le lien : https://github.com/ghasseen/testdevops  
Le code source est désormais accessible en ligne, prêt à être cloné 
automatiquement dans le script docker-deploy.sh. 
Étape 5 : Script docker-deploy.sh: 
J'ai écrit un script bash pour automatiser toutes les étapes(vous le 
trouvez dans mon repertoire )  : clonage, build, push, lancement ; 
j'ai le pousser dans mon repertoire git :  
Ensuite je rends mon script executable et j'execute : 
le fichier docker-deploy.sh va execute automatiquement toutes les instruction(je 
veux vous explique instruction par instruction ; aprés l'execution de 
./docker-deploy.sh )  
Cloner l'application depuis Git into un dossier que j'ai nommé nodeapp :  
build et push de l'image: 
Chaque image Docker est composée de plusieurs couches (layers), et Docker les 
pousse une par une vers Docker Hub, il y'a des layers volumineuses donc le 
serveur ralentit (retrying) :  
Problème :  
push lent sur Docker Hub 
Les images avec des gros fichiers provoquaient des « retrying » 
Solution :  
l'utilisation de buildkit :  -Nouveau moteur de build introduit par Docker -Meilleure gestion du cache -Push/pull plus efficaces - Moins de problèmes avec les images volumineuses 
Resultat  
L’image Docker de l’application Node.js a été poussée avec succès sur Docker 
Hub. 
Les couches (layers) ont été transmises ou reconnues comme existantes. Cela 
prouve que l’image est propre, bien buildée, et peut être partagée. 
Lancement de l’application avec Docker Compose 
Création des conteneurs 
Un réseau Docker nommé nodeapp_default a été créé automatiquement. 
Le conteneur MongoDB (mongoc) a démarré avec succès. 
Ensuite, my-node-app (l’application Node.js) s’est lancé correctement. 
**** Le depends_on dans docker-compose.yml a bien joué son rôle pour l’ordre 
de démarrage.**** 
Après exécution du script, Docker Compose a lancé MongoDB et l’application 
Node.js avec succès. 
Lancement des conteneurs : 
Test de l'application via navigateur ou curl : 
Interface web disponible sur : http://localhost:3000 ; L’application est accessible 
et retourne un HTTP 200 : preuve de bon fonctionnement. 
