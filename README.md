# Loyalty Points Kaufland App

Dieser Repository enthält das Projekt, das im Rahmen des Praxissemesters der Universität zu Köln erarbeitet wurde. Die Anforderungen bekommen wir (das Team) von Kauflands Stakeholders.

## Flowchart

![Bildschirmfoto_2022-11-04_um_14.30.27](/uploads/049c5360efcd5c36a706ce95b8c1a760/Bildschirmfoto_2022-11-04_um_14.30.27.png)


## Weitere Informationen

Link zu unserem [Prototypen](https://www.figma.com/proto/rgDxiet46evjP3kw9BERp5/Kaufland-App?scaling=scale-down&page-id=0%3A1&node-id=1%3A2&starting-point-node-id=1%3A2&show-proto-sidebar=1)


### Definitionen
Im folgenden definieren wir einen User := Gültig registrierter und eingeloggter Benutzer mit einer gültigen und aktuellen Kauflandcard im Kaufland Onlineshop.

1 Loyalty Point := 0,01€


### Prioritäten
- 100 := Could
- 200 := Should
- 300 := Must

### Informationen zum Zurechtfinden im Code

- Die relevanten Views zu unseren Features im Home Tab sind zu finden unter View/Home/SwiftUIViews; weitere Änderungen sind im HomeViewController und im zughörigen Storyboard zu finden
- Änderungen für Features im Account Tab sind zu finden unter View/Account: im AccountViewController, AccountViewModel und im Ordner Cell/StreakAndLP; außerdem im Ordner Utility in der Datei Constants
- Die Funktion der Streak ist zu finden unter Model/ModelExtensions/StreakViewModel
- Das Levelsystem is zu finden unter Model/ModelExtensions/Levelsystem

