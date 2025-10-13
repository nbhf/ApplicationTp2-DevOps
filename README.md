# ApplicationTp2 - Pipeline CI/CD DevOps

## Description
Application Spring Boot pour le TP DevOps - Pipeline CI/CD avec Jenkins et Docker.

## Prérequis
- Java 21
- Maven 3.9+
- Docker
- Jenkins

## Installation Locale

### Avec Maven
\`\`\`bash
mvn clean package
java -jar target/application-tp2.jar
\`\`\`

### Avec Docker
\`\`\`bash
docker build -t application-tp2:1.0.0 .
docker run -p 8081:8080 application-tp2:1.0.0
\`\`\`

## Endpoints
- GET `/monapi/v1/bonjour` - Retourne "Bonjour"

## Pipeline CI/CD
Le pipeline Jenkins automatise :
1. Clone du dépôt Git
2. Build Maven
3. Tests unitaires
4. Construction de l'image Docker
5. Publication sur Docker Hub

## Auteur
Nour Elhouda Belhadj Fredj & Nada Jarboui - TP2 DevOps