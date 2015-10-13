# Robot suiveur de ligne à base d'Arduino

Page en construction!

## Contexte

Ce robot a été conçu à titre d'illustration pour un
[atelier](atelier.md) de la fête de la science du Laboratoire de
Recherche en Informatique à l'Université Paris Sud.

C'est un robot simple qui suit une route dont les bords ont été
dessinés au feutre épais sur une feuille blanche (ou un tableau blanc).

## Choix de conception

- Être abordable par le plus grand nombre au niveau du coût et de la
  difficulté de mise en oeuvre. Par exemple qu'un enfant de fin de
  primaire puisse comprendre les idées principales pendant l'atelier
  puis réaliser le même robot, ou mieux un autre robot, avec l'aide
  d'un adulte, quitte à y consacrer un peu de temps.

- Utiliser du matériel et du logiciel libre

- Mettre en jeu tous les aspects: mécanique, électronique,
  informatique

- Ne (presque) pas nécessiter de soudure.

Le choix s'est porté sur la plateforme Arduino: un mini ordinateur
conçu pour interagir avec des circuits électroniques. Mais beaucoup
d'autres plateformes auraient été possibles; par exemple:

- Raspberry Pi: même concept que l'arduino, mais avec un ordinateur
  plus évolué (système d'exploitation complet sous GNU/Linux). Prise
  en main plus complexe, mais les possibilités de programmation sont
  nettement plus riches.

- Timéo: mécanique et électronique toute faite. Pratique pour se
  concentrer sur la partie programmation. Bien adapté par exemple pour
  des séquences pédagogiques courtes.

- Lego mindstorm: composants électroniques et mécaniques compatibles
  lego, d'où une simplicité de mise en oeuvre. Mais nettement plus
  cher et plus fermé.

- ...

## Matériel

Voici Les composants que j'ai utilisé pour fabriquer ce robot. La
plupart d'entre eux -- y compris l'arduino, se trouvent dans tout bon
magasin d'électronique. Certains demandent de passer par un revendeur
spécialisé; il y en a plusieurs en France; en l'occurence je suis
passé par Snootlab, et pour information j'ai indiqué la référence chez
eux.

| Reference | Nom                                                                       | Prix unitaire | Quantité | Total   |
| ADA-00858 | Petit moteur stepper avec réducteur 5V 512 pas                            | 6,00 €        |        2 | 12,00 € |
| ADA-01438 | Adafruit Motor/Stepper/Servo Shield pour Arduino v2 Kit - v2.0 CMS montés | 21,60 €       |        1 | 21,60 € |
| KIT-00001 | Kit 2+2 connecteurs empilables Arduino                                    | 1,71 €        |        1 | 3,42 €  |
| KIT-00011 | Kit connecteurs empilables Arduino 1.0                                    | 1.91€         |        1 | 1.91€   |
| POW-00004 | Bloc support 4 piles AA pour Arduino                                      | 3,71 €        |        1 | 3,71 €  |
| KIT-01025 | Kit de communication IR                                                   | 5,00 €        |        1 | 5,00 €  |
| SEN-00005 | Photoresistance 4mm                                                       | 2,00 €        |        2 | 4,00 €  |

À ajouter: résistances, led, ...

## Montage

- [ ] Souder les connecteurs empilables (KIT-000011) sur la plaque Adafruit
- ...

## TODO

- Stackable headers 2x10 + 1x5

- Test robot avec batterie chargée
- Remplacement moteur avec câble cassé

- Test nouveau modèle de capteur
- Insertion résistance dans le circuit
- Recharge bateries 9V
- Test fonctionnement 6V

## Tests led

Using a 1kOhm or 10kOhm resistance?
1kOhm for inside room?
https://learn.adafruit.com/photocells/using-a-photocell
