# Partizip App

Eine moderne Community-Plattform für Events und Bürgerbeteiligung, entwickelt mit Microservices-Architektur.

## 🏗️ Architektur

Das Projekt basiert auf einer Microservices-Architektur mit folgenden Komponenten:

- **API Gateway** (Port 3000) - Zentrale Schnittstelle für alle Services
- **User Service** (Port 3001) - Benutzerverwaltung und Authentifizierung
- **Community Service** (Port 3002) - Community-Management und Posts
- **Event Service** (Port 3003) - Event-Management und Benachrichtigungen
- **MySQL Database** (Port 3307) - Zentrale Datenhaltung
- **MQTT Broker** (Port 1883) - Echtzeitkommunikation zwischen Services

## 🚀 Technologien

- **Backend**: Spring Boot (Java)
- **Frontend**: React Native (Expo)
- **Database**: MySQL 8.0
- **Message Broker**: Eclipse Mosquitto (MQTT)
- **Containerization**: Docker & Docker Compose
- **API Gateway**: Spring Cloud Gateway

## 📋 Voraussetzungen

- Docker Desktop
- Docker Compose
- Node.js (für Frontend-Entwicklung)
- Java 11+ (für Backend-Entwicklung)

## 🛠️ Installation und Setup

### 1. Repository klonen
```bash
git clone <repository-url>
cd PartizipApp
```

### 2. Backend Services starten
```bash
cd backend
docker-compose up -d
```

### 3. Services überprüfen
```bash
docker-compose ps
```

### 4. Logs anzeigen
```bash
docker-compose logs -f
```

## 🔧 Problembehebung

### Container-Konflikt beheben
Wenn Sie einen Container-Namenskonflikt erhalten:
```bash
docker-compose down
docker container prune
docker-compose up -d
```

### Services neustarten
```bash
docker-compose restart <service-name>
```

## 📡 API Endpunkte

### API Gateway (Port 3000)
- Health Check: `GET /actuator/health`

### User Service (Port 3001)
- Health Check: `GET /actuator/health`
- User Management: `/users/**`

### Community Service (Port 3002)
- Health Check: `GET /actuator/health`
- Community Management: `/communities/**`

### Event Service (Port 3003)
- Health Check: `GET /actuator/health`
- Event Management: `/events/**`

## 🗄️ Datenbank

- **Host**: localhost
- **Port**: 3307
- **Database**: partizip_db
- **Username**: partizip_user
- **Password**: partizip_pass

## 📨 MQTT Broker

- **Host**: localhost
- **Port**: 1883 (MQTT)
- **WebSocket Port**: 8083

## 🎯 Entwurfsmuster

Das Projekt implementiert verschiedene Entwurfsmuster:

### 1. Beobachter-Muster (Observer)
- **Einsatz**: MQTT-basierte Kommunikation zwischen Services
- **Zweck**: Lose Kopplung und Echtzeit-Benachrichtigungen

### 2. Fassaden-Muster (Facade)
- **Einsatz**: API Gateway als zentrale Schnittstelle
- **Zweck**: Vereinfachte Client-Kommunikation

### 3. Fabrikmethode (Factory Method)
- **Einsatz**: UserService mit UserDto, UserDtoCreater, User
- **Zweck**: Flexible Objekterstellung

## 🔄 Entwicklung

### Backend Services bauen
```bash
cd backend
docker-compose build
```

### Einzelnen Service neu bauen
```bash
docker-compose build <service-name>
```

### Logs eines Services anzeigen
```bash
docker-compose logs -f <service-name>
```

## 🧪 Testing

### Health Checks
Alle Services verfügen über Health-Check-Endpunkte:
```bash
curl http://localhost:3000/actuator/health  # API Gateway
curl http://localhost:3001/actuator/health  # User Service
curl http://localhost:3002/actuator/health  # Community Service
curl http://localhost:3003/actuator/health  # Event Service
```

## 📁 Projektstruktur

```
PartizipApp/
├── backend/
│   ├── api-gateway-service/
│   ├── user-service/
│   ├── community-service/
│   ├── event-service/
│   ├── mosquitto/
│   └── docker-compose.yml
├── frontend/
└── README.md
```

## 🤝 Mitwirkende

- Entwicklerteam SWT2

## 📄 Lizenz

Dieses Projekt ist für Bildungszwecke entwickelt.

---

**Hinweis**: Stellen Sie sicher, dass alle Container ordnungsgemäß gestartet sind, bevor Sie die Anwendung verwenden.