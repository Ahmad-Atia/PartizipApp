Verhaltensmuster (Behavioral Patterns).


1. Beobachter-Muster (Observer)
Name: Beobachter-Muster

Motivation:
Das Muster ist sinnvoll, wenn ein Service (z.B. Event-Service) Änderungen oder Ereignisse erzeugt, die andere Services oder Komponenten (z.B. Community-Service, Frontend) benachrichtigen sollen, ohne diese direkt zu kennen. So bleibt die Kopplung gering und neue Listener können einfach hinzugefügt werden.

Umsetzung im Design:
Im partizip-Projekt wird das Beobachter-Muster z.B. durch die Integration von MQTT umgesetzt. Der Event-Service veröffentlicht Nachrichten (Events) über MQTT, und andere Services oder Clients können diese abonnieren und darauf reagieren. Die Services sind dabei lose gekoppelt und müssen sich nicht gegenseitig kennen.


Strukturmuster (Structural Patterns) 

2. Fassaden-Muster (Facade)
Name: Fassaden-Muster

Motivation:
Das Muster wird verwendet, um eine einfache Schnittstelle zu einem komplexen System bereitzustellen. Im partizip-Projekt gibt es mehrere Microservices (User, Event, Community), die jeweils eigene APIs haben. Der API-Gateway-Service dient als Fassade und bietet eine zentrale, vereinfachte Schnittstelle für alle Clients.

Umsetzung im Design:
Der API-Gateway-Service nimmt alle Anfragen entgegen und leitet sie an die jeweiligen Microservices weiter. Die Konfiguration der Routen erfolgt in der api-gateway-service über die application.yml. So müssen sich Clients nicht mit den einzelnen Services beschäftigen, sondern nutzen nur den Gateway.



Erzeugungsmuster (Creational Patterns)

Fabrikmethode (Factory Method)
Name: Fabrikmethode

Motivation:
Im UserService muss aus verschiedenen Datenquellen oder Eingabeformaten (z.B. UserDto) ein User-Objekt erzeugt werden. Die genaue Struktur oder Initialisierung des User-Objekts kann variieren, je nach Kontext (z.B. Registrierung, Update).

Umsetzung im Design:
Im UserService wird die Fabrikmethode durch die Klassen UserDto, UserDtoCreater und User umgesetzt.

Die Klasse UserDtoCreater übernimmt die Aufgabe, aus einem UserDto das passende User-Objekt zu erzeugen.
So wird die Logik der Objekterstellung gekapselt und kann flexibel angepasst werden, ohne den UserService selbst zu ändern.


Datenschicht
bussinesslogikschicht 
Präsentationsschicht

