# Robot suiveur de ligne à base d'Arduino

Page en construction!

## Contexte

Ce robot a été conçu à titre d'illustration pour un
[atelier](atelier.md) de la fête de la science du
[Laboratoire de Recherche en Informatique](www.lri.fr)
à l'[Université Paris Sud](www.u-psud.fr).

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

Le choix s'est porté sur la plateforme [Arduino](arduino.cc): un mini
ordinateur conçu pour interagir avec des circuits électroniques. Mais
beaucoup d'autres plateformes auraient été possibles; par exemple:

- [Raspberry Pi](https://www.raspberrypi.org/): même concept que
  l'Arduino, mais avec un ordinateur plus évolué (système
  d'exploitation complet sous GNU/Linux). Prise en main plus complexe,
  mais les possibilités de programmation sont nettement plus riches.

- [Thymio](https://www.thymio.org/fr:thymio): mécanique et
  électronique toute faite. Pratique pour se concentrer sur la partie
  programmation. Bien adapté par exemple pour des séquences
  pédagogiques courtes.

- [Lego Mindstorms](https://fr.wikipedia.org/wiki/Lego_Mindstorms):
  composants électroniques et mécaniques compatibles lego, d'où une
  grande simplicité de mise en oeuvre. Mais nettement plus cher et on
  est plus enfermé dans la gamme d'un fabriquant.

- ...

## Matériel

Voici Les composants que j'ai utilisé pour fabriquer ce robot. La
plupart d'entre eux -- y compris l'arduino, se trouvent dans tout bon
magasin d'électronique. Certains nécessitent de passer par un
revendeur spécialisé; il y en a plusieurs en France; en l'occurence je
suis passé par [Snootlab](snootlab.com); à titre purement indicatif
j'ai précisé la référence et le prix chez eux au moment de mon achat.

| Reference | Nom                                                                       | Prix unitaire | Quantité | Total   |
| --------- | ---------------------                                                     | ------------  | -------- | ------: |
| SPK-12757 | SparkFun RedBoard, compatible Arduino                                     | 23,40 €       |        1 | 23,40 € |
| ADA-01438 | Adafruit Motor/Stepper/Servo Shield pour Arduino v2 Kit - v2.0 CMS montés | 21,60 €       |        1 | 21,60 € |
| ADA-00858 | Petit moteur stepper avec réducteur 5V 512 pas                            | 6,00 €        |        2 | 12,00 € |
| KIT-00001 | Kit 2+2 connecteurs empilables Arduino                                    | 1,71 €        |        1 | 1,71 €  |
| KIT-00011 | Kit connecteurs empilables Arduino 1.0                                    | 1.91 €        |        1 | 1.91 €  |
| POW-00004 | Bloc support 4 piles AA pour Arduino                                      | 3,71 €        |        1 | 3,71 €  |
| KIT-01010 | Kit 10 cordons 15cm                                                       | 3,50 €        |        2 | 7,00 €  |
| SEN-00005 | Photoresistance 4mm                                                       | 2,00 €        |        2 | 4,00 €  |
| RES-00029 | Ruban de 10 résistances 1 KOhms                                           | 0,90 €        |        1 | 0,90 €  |
| OPT-00003 | 10 Led 3mm vertes diffuses x10                                            | 1,51 €        |        1 | 1,51 €  |
| OPT-00003 | 10 Led 3mm rouge diffuses x10                                             | 1,51 €        |        1 | 1,51 €  |
| KIT-01028 | Plaque d'essai                                                            | 3,50 €        |        1 | 3,50 €  |
| --------- | ---------------                                                           | -----------   |      --- | ---:     |
| Total     |                                                                           |               |          | 82,75 € |

Oups, c'est au final plus cher que ce que j'avais annoncé pendant les
ateliers.

À cela se rajoute la structure mécanique. En l'occurence du légo
technique, mais une structure en carton pourrait faire l'affaire
(projet à venir: un plan pour la découpeuse laser).

Les roues ont été découpées au laser dans un fond de cageot de
fraises; voici le [plan](wheel.eps).

Dans l'optique d'explorer d'autres montages, il peut être rapidement
rentable d'acheter l'un des nombreux kits de démarrage.

## Montage

- [ ] Souder les connecteurs empilables (KIT-000011) sur la plaque Adafruit
- [ ] Réordonner les câbles sur les prises des moteurs pas à pas
- [ ] Utiliser les connecteurs empilables supplémentaires pour faire
      des prises débranchables pour la plaque Adafruit
- [ ] 


TODO: compléter et ajouter les photos

## Tests led

Using a 1kOhm or 10kOhm resistance?
1kOhm for inside room?
https://learn.adafruit.com/photocells/using-a-photocell
