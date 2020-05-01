---
layout: project
machines: laser_cutter
title: Covid19: prédécoupe laser de blouses pour les soignants
authors: [blandine, delaet, nthiery]
sources: [BlousesV1.3.svg]
images: [2015-12-16-alcoves.jpg]
date: 2020/04/30
material: coton
---

Du fait le l'épidémie de Covid19, l'hôpital d'Arpajon et des Ehad des
environs ont fait un appel à l'aide pour produire plus d'un millier de
blouses blanches lavables en coton [de type très
couvrant](BlousePourHopital.JPG). Pour répondre à ce besoin, un réseau
d'une centaine de bénévoles --
[Bénéblouses](https://www.artdelecoute.com/445336164) -- s'est monté. 
L'hôpital fournit le tissu (draps, ...).

La reproduction du patron et la découpe à la main prennent à peu près
40 minutes (et pas mal d'ampoules), soit a peu près la moitié du temps
de production. L'idée a alors germé d'**utiliser la la grande découpeuse
laser (1016 x 711 mm) du FabLab Digiscope (Laboratoire de Recherche en
Informatique, Université Paris Sud/Saclay), pour industrialiser la
découpe du tissu et fournir des kits prêts à coudre aux
couturièr.es**.

Ce projet est mené depuis le 9 avril par Blandine, Sylvie Delaët,
Nicolas Thiéry. Il y a fallu environ 10 jours de conception
prototypage puis 10 jours de préproduction au cours desquels 80 kits
ont été produits avant d'atteindre la phase de production. Au total,
140 kits ont été produits à ce jour. En exploitant les chutes, 100
kits de masques ont été produit.

## Modes d'emploi

- [kits blouse](ModeDEmploiKitBlouse.md)
- [kits masque](ModeDEmploiKitMasque.pdf)

## Objectifs

- Suivre le [patron](patronCouturesNonComprisesAreproduire.jpg) conçu
  par les soignants.

- Minimiser les coutures, pour faire gagner du temps aux couturières,
  mais aussi pour minimiser la consommation de fil qui est apparemment
  une denrée limitée. Pour le tissu, il y a moins besoin d'optimiser.

- Maximiser la productivité au FabLab, d'une part du fait du nombre
  limité de volontaires qualifiés, et d'autre part parce que l'accès
  au FabLab est limité (plages horaires, autorisations) et la
  découpeuse laser pourrait servir pour d'autres projets.

Pour les Ehpad, les contraintes sanitaires sont moins fortes; les
blouses sont en effet utilisées pour couvrir les visiteurs: tissu de
couleur ok; moins couvrant ok; ...

## Productivité

Les draps fournis mesurent 1.78m x 3.2m (TODO: mettre la référence)

Un carton de 20 draps donne 30 kits de blouse et 80 kits de masques:

- 15 draps à replier puis repasser:
  - 15x1x2 = 30   corps de blouse
  - 15x1x4 = 30x2 boucles de blouse
  - 15x4x4 = 80x3 carrés de masque
  - 15x1x4 = 30x2 lanières de masque

- 5 draps à replier puis repasser:
  -  5x3x4 = 30x2 manches
  -  5x6x4 = 50x2+10 lanières de masque
     À confirmer: il faut recouper les chutes séparément.

Il reste à produire 30 biais de 70cm pour cou+épaule pour plus de
confort et réduire le besoin de fourniture de biais en complément. Il
est possible d'en produire environ 100 dans un drap, en sacrifiant un
drap tous les trois cartons.

Temps de découpe:
- Draps corps: 2+3 minutes
- Draps manche: 3 x 2 minutes + ??? lanières

Maintenant que les phase de conception et de préproduction sont
terminées il est possible -- en s'organisant bien et avec pas mal de
concentration -- pour une personne seule d'exploiter les temps de
découpe pour préparer les draps et conditionner les kits. En comptant
une minute de mise en place pour chaque découpe, cela donne un temps
de fabrication pour un carton de 30 kits de:

    15 * (2+1+3+1) + 5* (3 * (2+1) + 2+1) = 165 minutes

Il faut aussi décompter les temps de livraison, relation sociales,
organisation de l'accès au FabLab, préparation des biais, etc. Du
coup, préparer deux cartons (60 kits) par journée de travail est
réaliste.

## Production et livraisons

Cartons de draps reçus: 3+5+1

| Date  | Version  | kits blouses  | kits masques | Commentaires                        |
| ---   | -------- | ------------- | ------------ | ------------                        |
|   /04 | V0.9     | 24            | 0            | 1 carton de 2x6 kits de 2 blouses   |
|   /04 | V0.10    | 72            | 0            | 3 cartons de 2x6 kits de 2 blouses  |
| 30/04 | V1.3beta | 30            | 0            | 1 carton de 2x6+3 kits de 2 blouses |
| 30/04 | V1.3     | 30            | 80           | 1 carton de 2x6+3 kits de 2 blouses |

## Projets similaires

Patrons protection médicale pour personnel soignant (surblouse,
pyjama) validés CHU Paris:

https://drive.google.com/drive/folders/1EfqRlpa1mkeg3x9N9Fk_O0WYd06L2cRE
