---
layout: page
title: "Carnet de labo kit blouses Covid 19"
---

## Mode d'emploi de découpe

Depuis inkscape, exporter en PDF deux fichiers:
- BlousesVXXX-manches.pdf (juste le calque Découpe Manches)
- BlousesVXXX-corps.pdf (juste le calque Découpe Corps)
Options:
  - Utiliser les dimensions de la page de l'objet
  - Convertir les textes en chemin (?)

Déposer dans le dossier Blouse-Delaet-Thiery de l'ordinateur
Importer dans Corel Draw les deux fichiers
Tout sélectionner, et choisir "hairline" pour la largeur des traits
Imprimer (^P)

TODO: À compléter!


## Essais de découpe

CO2, Vector only, Auto focus: non Power Comp: non, Speed Comp: non

- Coton bio, 2 couches
- Vitesse 30% puis réduction progressive à 15%
- Power 30%
- Freq: 50%

Coupe propre des courbes.
Coupe très rapide en ligne droite et insuffisante au dessus de 15%.

### Essai

- Coton bio, 4 couches

### Essai

- Coton bio, 8 couches
- Épaisseur: jusqu'à 1 cm environ
- Vitesse: 7%
- Power: 100%
- Fréquence: 50%

Résultat:
- 6-8 couches découpées
- flash de flamme toutes les 4 ou 5 secondes
- pas de problème apparent de focalisation


### Essai Manches V0.7

- Coton bio 2 couches; non repassé, un peu froissé (<=2mm?), pli non marqué (~1cm)
- Vitesse: 30%
- Power: 75%
- Fréquence: 50%

3min30s

Ordre de découpe non respecté, mais temps de déplacements pas élevés
~10s par label

Flamèches toutes les quelques secondes dans les découpes en hauteur
(1cm dû à pli non applati); défocalisation? Pas de flamèches là ou le
tissu est plaqué.

Découpe insuffisante pour la deuxième couche là surtout là où il y
avait de l'épaisseur.

### Essai Corps V0.7

- Coton 2 couches; non repassé, mais juste un peu froissé (<=3mm?), sans pli
- Vitesse: 25%
- Power: 100%
- Fréquence: 50%

2min

Ordre de découpe non respecté, mais temps de déplacements pas élevés
~10s par label

Flamèches à chaque marque de pli; départ de flamme.

Découpe ok, sauf ourlets et à la marque de pli

calage à gauche foiré: objet non calé à gauche dans la page sur Corel
Draw 5cm de trop de largeur sur le col

### Essai Manche V0.7

- Coton 2 couches; repassé grossièrement
- Vitesse: 25%
- Power: 75%
- Fréquence: 50%

flamèches régulières dans les coupes en biais ou en cas d'épaisseur

le tissu a tendance à s'envoler. Solution possible: découper d'abord
tous les lettrages

3min 50

### Essai Corps V0.8

- Coton 4 couches; bien repassé
- Vitesse: 15%
- Power: 80%
- Fréquence: 50%

3min 50

### Essai Manches V0.8

- Coton hopital 8 couches, prérepassé, plis re-repassés
- Vitesse 7%
- Power: 100%
- Fréquence: 50%

Réorganiser la découpe pour rentrer dans 80cmx70cm

8 min 10

Ça passe. Un peu brutal

### Essai Corps V0.8

- Coton hopital 4 couches, prérepassé, plis re-repassés
- Vitesse 12%
- Power: 80%
- Fréquence: 50%

Plein de place en haut

Coupe nickel

### Essai Corps V0.9

- Coton hopital 4 couches, bien plié, prérepassé grossièrement, un peu humidifié
- Vitesse 20% puis 25%
- Power: 100%
- Fréquence: 25%

4 minutes 07 puis 3 min 44 (avec 3 carrés) 

Coupe nickel sauf quelques points, principalement en bordure
Une flamèche; une braise de 5s

Plus de flamèches au deuxième essai (repassage moins bon?) coupe du
bord haut carrés foireuse pour la couche du dessous.

### Essai Blouse V0.10

- Coton hopital 4 couches, bien plié, prérepassé grossièrement
- Vitesse 20% puis 25%
- Power: 100%
- Fréquence: 25%

Manche + biais: 3 minutes

## Historique

### Blouse V0.5

Version reçue de Sylvie


### Blouse V0.6

Nettoyage traits de découpe corps
- (1pt, rouge, pas de fond, ...)

Retournement pour que le col soit côté gauche. Motivation: le point de
référence de la découpeuse est en haut à gauche, et c'est plus facile
de caller le tissu côté col. Le lettrage est inversé, mais de toutes
les façons il l'est forcément sur l'une des deux couches.

Temps de découpe: ~ 5 minutes pour le corps

Racourcissement trait de découpe vertical du dos (sortait du cadre)

### Blouse V0.7

- Réglage de la taille de la feuille pour coller à la taille de table
  de découpe. Suppression calque correspondant.

- Ajout calque pour les commentaires

- Déplacement des manches dans la zone de découpe

- Nettoyage traits de découpe manche

- Suppression des points dans les marqueurs pour gagner du temps de
  coupe.

- Tentative d'optimisation découpe: fusion des chemins entre eux;
  tentative d'ordonner la coupe des chemins pour réduire les trajets.
  Pour cela, jouer avec l'ordre z d'Inkscape: sélectionner les objets
  un par un, et appuyer sur Home. Puis tout désélectionner et circuler
  à travers les objets avec tab pour vérifier l'ordre.

### Blouse V0.8

- [x] Manche en droit fil pour plus de confort
- [x] Suppression trait de découpe dos pour bénéficier des ourlets existants

### Blouse V0.9

- [x] Redistribution pour rentrer dans le tissu de l'hôpital
- [x] Y compris: descente du corps pour utiliser la couture bas
- [x] Y compris: modificaions repères m pour gagner un peu d'espace
- [x] Agrandissement repère 1y1
- [x] Correctif alignements corps / manches: les étiquettes et même le
      bord ne s’alignaient pas exactement.

### Blouse V0.10

Modifications faites dans BlouseV0.9.svg ... Donc BlouseV0.9 perdu.

- [x] Texte en surface nulle pour coupe plus rapide et moins de départ
      de flamme
- [x] 3x4 manches par drap au lieu de 2x4 + petit biais
- [x] Symmetrisation manche

### Blouse V1.0

### Blouse V1.1

### Blouse V1.2

- [x] Zone ourlet poignets
- [x] Placement manches droit fil
- [x] Marqueurs 2m2 -> 2t2 pour les manches
- [x] Découpe en V en bas des manches
- [x] Marqueurs pour la couture de V

Le trapèze descend trop bas, risque de sortir de la zone de coupe et
bruler le tissu replié en bas de la machine

### Blouse V1.3

- [x] Coupe du corps en deux passes: d'abord carrés + lanière
- [x] Remontée du corps (et du coup de la construction de la manche)
- [x] Cela libère de place pour le triangle sous l'épaule long
- [x] Construction par symétrie de la partie arrière du côté par symétrie
- [x] Correctif: le repère H avait été monté pour le corps et pas la manche
- [x] Correctif: repère 1F1 accidentellement nommé 1f1
- [x] Correctif: avec du biais de col+dos, le dos doit être 1cm moins haut

## À étudier

- Les marqueurs pourraient être plus petits pour une découpe plus rapide
- Trait de prédécoupe des repères?

## Plans

### Biais

De combien de biais avons nous vraiment besoin?

Pour chaque manche: un biais 2x 5cm x 35cm
Pour le col: un biais de 5cm x ~~70cm~~ 95cm

### Masques

1 masque:
- 3 carrés de 21x21cm
- 2 bandes de 80cm x 5cm droit fil

