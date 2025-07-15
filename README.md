# 🏛️ Partizip App

Eine moderne Community-Plattform für Events und Bürgerbeteiligung, entwickelt mit Microservices-Architektur.

## 📖 Über das Projekt

Partizip ist eine umfassende Plattform, die es Bürgern ermöglicht, sich aktiv an lokalen Events und Community-Aktivitäten zu beteiligen. Die Anwendung bietet eine benutzerfreundliche Oberfläche für Event-Management, Community-Bildung und Echtzeitkommunikation.

## 🏗️ Architektur

Das Projekt basiert auf einer modernen Microservices-Architektur mit folgenden Komponenten:

| Service | Port | Beschreibung |
|---------|------|--------------|
| **API Gateway** | 3000 | Zentrale Schnittstelle und Routing für alle Services |
| **User Service** | 3001 | Benutzerverwaltung, Authentifizierung und Profilverwaltung |
| **Community Service** | 3002 | Community-Management, Posts und Interaktionen |
| **Event Service** | 3003 | Event-Erstellung, -Verwaltung und Benachrichtigungen |
| **MySQL Database** | 3307 | Zentrale, persistente Datenhaltung |
| **MQTT Broker** | 1883 | Echtzeitkommunikation zwischen Services |

## 🚀 Technologien

### Backend
- **Framework**: Spring Boot 3.x (Java 17+)
- **API Gateway**: Spring Cloud Gateway
- **Database**: MySQL 8.0 mit JPA/Hibernate
- **Message Broker**: Eclipse Mosquitto (MQTT)
- **Containerization**: Docker & Docker Compose
- **Monitoring**: Spring Boot Actuator

### Frontend
- **Framework**: React Native mit Expo
- **State Management**: Redux/Context API
- **UI Components**: React Native Elements
- **Navigation**: React Navigation

### DevOps
- **Containerization**: Docker
- **Orchestration**: Docker Compose
- **Health Checks**: Integrierte Health-Monitoring
- **Logging**: Centralized Logging

## 📋 Voraussetzungen

### Systemanforderungen
- **Docker Desktop** (v20.10+)
- **Docker Compose** (v2.0+)
- **Freie Ports**: 3000-3003, 3307, 1883, 8083

### Für Entwicklung
- **Node.js** (v16+) für Frontend-Entwicklung
- **Java** (v17+) für Backend-Entwicklung
- **Git** für Versionskontrolle

## 🛠️ Installation und Setup

### 1. Repository klonen
```bash
git clone <repository-url>
cd PartizipApp
```

### 3. Backend Services starten
```bash
cd backend
docker-compose up -d
```

### 4. Installation überprüfen
```bash
# Service-Status prüfen
docker-compose ps

# Logs anzeigen
docker-compose logs -f

# Health-Checks ausführen
curl http://localhost:3000/actuator/health
```

## 🔧 Problembehebung

### ❌ Container-Konflikt beheben
```bash
# Alle Container stoppen und entfernen
docker-compose down
docker container prune -f
docker volume prune -f

# Services neu starten
docker-compose up -d
```

### 🔄 Services neustarten
```bash
# Einzelnen Service neustarten
docker-compose restart <service-name>

# Alle Services neustarten
docker-compose restart
```

### 📊 Debugging
```bash
# Service-Logs anzeigen
docker-compose logs -f <service-name>

# Container-Status prüfen
docker-compose ps -a

# Netzwerk-Diagnose
docker network ls
docker network inspect backend_partizip-network
```

## 🗄️ Datenbank-Konfiguration

### Verbindungsdetails
```properties
Host: localhost
Port: 3307
Database: partizip_db
Username: partizip_user
Password: partizip_pass
```

### Tabellen-Schema
- **users**: Benutzerdaten und Authentifizierung
- **communities**: Community-Informationen
- **events**: Event-Details und Metadaten
- **posts**: Community-Posts und Inhalte
- **participants**: Event-Teilnahmen

## 📨 MQTT-Konfiguration

### Verbindungsdetails
```properties
Host: localhost
MQTT Port: 1883
WebSocket Port: 8083
```

### Topics
- `events/created` - Neue Events
- `events/updated` - Event-Updates
- `communities/posts` - Neue Posts
- `users/notifications` - Benutzerbenachrichtigungen

## 🎯 Entwurfsmuster

### 1. 👁️ Beobachter-Muster (Observer)
- **Einsatz**: MQTT-basierte Kommunikation zwischen Services
- **Implementierung**: Event-Service publiziert Events, andere Services abonnieren
- **Vorteile**: Lose Kopplung, Echtzeit-Benachrichtigungen

### 2. 🏛️ Fassaden-Muster (Facade)
- **Einsatz**: API Gateway als zentrale Schnittstelle
- **Implementierung**: Gateway routet Anfragen an entsprechende Services
- **Vorteile**: Vereinfachte Client-Kommunikation, zentrale Authentifizierung

### 3. 🏭 Fabrikmethode (Factory Method)
- **Einsatz**: UserService mit UserDto, UserDtoCreater, User
- **Implementierung**: Flexible Objekterstellung basierend auf Eingabedaten
- **Vorteile**: Erweiterbarkeit, Kapselung der Erstellungslogik

## 🔄 Entwicklung

### Backend-Services bauen
```bash
cd backend

# Alle Services bauen
docker-compose build

# Einzelnen Service bauen
docker-compose build <service-name>

# Services mit neuem Build starten
docker-compose up -d --build
```

### Development-Modus
```bash
# Services im Development-Modus starten
docker-compose -f docker-compose.dev.yml up -d

# Live-Reload für Services aktivieren
docker-compose exec <service-name> ./gradlew bootRun
```

## 🧪 Testing

### Health Checks
```bash
# API Gateway
curl http://localhost:3000/actuator/health

# User Service
curl http://localhost:3001/actuator/health

# Community Service
curl http://localhost:3002/actuator/health

# Event Service
curl http://localhost:3003/actuator/health
```

### Integration Tests
```bash
# MQTT-Verbindung testen
mosquitto_pub -h localhost -t test/topic -m "Hello World"
mosquitto_sub -h localhost -t test/topic

# Datenbank-Verbindung testen
docker-compose exec mysql-db mysql -u partizip_user -p partizip_db
```

## 📁 Projektstruktur

```
PartizipApp/
├── backend/
│   ├── api-gateway-service/          # API Gateway Service
│   │   ├── src/main/java/
│   │   └── Dockerfile
│   ├── user-service/                 # User Management Service
│   │   ├── src/main/java/
│   │   └── Dockerfile
│   ├── community-service/            # Community Management Service
│   │   ├── src/main/java/
│   │   └── Dockerfile
│   ├── event-service/                # Event Management Service
│   │   ├── src/main/java/
│   │   └── Dockerfile
│   ├── mosquitto/                    # MQTT Broker Configuration
│   │   ├── mosquitto.conf
│   │   ├── data/
│   │   └── log/
│   ├── init-scripts/                 # Database Initialization Scripts
│   └── docker-compose.yml           # Service Orchestration
├── frontend/                         # React Native App
│   ├── src/
│   ├── package.json
│   └── Dockerfile
├── docs/                            # Documentation
└── README.md
```

## 🚀 Deployment

### Produktionsumgebung
```bash
# Produktions-Build erstellen
docker-compose -f docker-compose.prod.yml build

# Services in Produktion starten
docker-compose -f docker-compose.prod.yml up -d
```

### Monitoring
```bash
# Service-Metriken abrufen
curl http://localhost:3000/actuator/metrics

# Prometheus-Metriken (falls konfiguriert)
curl http://localhost:3000/actuator/prometheus
```

## 🤝 Mitwirkende

- **Entwicklerteam SWT2**
- **Projektleiter**: [Name]
- **Backend-Entwickler**: [Name]
- **Frontend-Entwickler**: [Name]
- **DevOps-Engineer**: [Name]



**💡 Hinweis**: Stellen Sie sicher, dass alle Container ordnungsgemäß gestartet sind und die Health-Checks erfolgreich sind, bevor Sie die Anwendung verwenden.

**🔧 Wartung**: Führen Sie regelmäßig `docker-compose down && docker system prune` aus, um nicht verwendete Container und Images zu entfernen.
