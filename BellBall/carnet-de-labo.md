# Carnet de laboratoire

## 2016-10-25: impression ratée

Le fil a fait un noeud ...

## 2016-10-26: balle bleue (c71176dfcbe6f6b3e45a67d1f9bbec7601dc8b41)

Premier prototype utilisable

- Les parois pourraient être plus fines
- Les ouvertures pourraient être plus grandes
- Le socle dépasse
- Il manque un chanfrein pour les vis
- La balle à tendance à se dévisser si on jongle fort avec

## 2016-10-28: impression rouge ratée (26a3760f37c432f52bacfed8361c1530e3ef6e0f)

À trois centimètres d'altitude, la tête s'est apparemment décallée, et
a fini l'impression 1cm plus à droite.

- Largeur tête écrou OK: l'écrou se coince en appuyant un peu fort.
- Épaisseur écrous trop fine (x1.5?)
- Trous de vis trop fins: les vis rentrent, mais en force
- Un brim de 1cm est suffisant
- Il manque le trou dans le socle
- contresocle trop fin
- Prévoir plutôt une vis à tête "plate" plutôt que fraisée

## 2016-10-04: impression rouge pas de vis (46931b77474d9530677c71f47852522d53f7378f)

À corriger:
- [X] guide plus long
- [X] 1mm de plus de marge au fond
- [X] diamètre trou cloche 2 plus large: 0,9+ mm
- [X] diamètre trou ressort: 0.1mm de plus
- [X] la vis peut être plus courte

- la vis ne rentre qu'en force; explication plausible: le jeu aux
  normes de la bibliothèque metric_thread est prévu pour du métal; il
  faut mettre plus de jeu pour de l'impression 3D. Romain utilise
  0.4mm de jeu avec le logiciel Fusion360.



## 2016-11-04: Impression nylon ratée (5346f1376575ae82a03697ed43ee7b3c9c940735)

Référence: https://ultimaker.com/en/community/9577-taulman-bridge-on-a-um2

Paramètres Cura:
- Shell thickness: 0.8
  Layer Height: 0.2
  Travel speed: 100
  Fill density: 100%
  Nozzle size: 0.8
  Print speed: 30
  Support type: Everywhere
  Platform adhesion type: Brim
  Brim line amount: 25
  Support: everywhere
  Bottom layer speed: 20
  Initial layer thickness: 0.3
  Bottom/top thickness: 0.6 (defaut?)
  Enable cooling fan: 0
paramètres Ultimaker (custom material 4):
  Nozzle temp = 245C
  Bed temp = 100C

Je ne suis pas sûr que l'on ait interprété "Base Layer = 0.3 / 20mms" correctement

Résultat:
- Photos de [côté](2016-11-04/1.jpg), [dessus](2016-11-04/2.jpg), [dessous](2016-11-04/3.jpg)
- À partir de h=4cm environ, il s'est passé n'importe quoi (tas de spaghettis)
- À la fin de l'impression (après refroidissement? avant?), le model était décollé
- Le support interne s'est déplacé de .5 cm
- La découpe du matériau n'est pas immédiate: quand la buse passe
  d'une partie à l'autre, cela fait des fils.
- Le matériau grésillait au moment de la dépose du brim

Analyse?
- support trop chaud?

À examiner:
- qualité du gros pas de vis
- flexibilité rebond
- resistance à la chute
- Suggestion Romain pour mieux coller: laque cheveux fructis bambou


# 2016-11-08: impression rouge (42a53e0ae20bddd641823e25de9cbba243d0c2f9)

- Qualité d'impression crade: comme avec le Nylon ci-dessus
  Romain: remettre la rétraction?
- Manque jeu sur le pas de vis de la balle
- Balle intérieure et extérieure serait probablement mieux un peu plus de même épaisseur
  À ajuster quand on aura choisi le bon matériaux
- marteauDiamètreRessort à mettre à 5.5 (les gros ressorts sont mieux)
- Il y avait du support dans le trou de la vis qui était pénible à enlever.
  Mettre un fond conique pour qu'il n'yait pas besoin de support au centre?
- Diminuer le nombre de tours de filets sur la vis principale: la
  balle bleue d'origine a deux tours de filets contre 3 ici, et des
  filets un peu plus épais.
- Filets peu marqués dans le pas extérieur
- Inutile de gérer deux diamètres de trous de cloche

# 2016-11-15: impression rouge (3646d65ca7f48d10cac1459bcf684aca9e5a6855)

- Impression propre: remettre la retraction a marché

- filetage un peut leger manque de la matiere sur l epaisseur du support du filetage
trop de jours entre la matiere
support genant pour la vis de fixation du petit support de la cloche
 je pense qu il faut un  poil plus de matiere
 

# 2016-12-21: impression noire (77876f5e466aca5aee4a9f9549721cf39065aaeb)

- Il y avait du support sur la vis intérieur; un peu pénible à enlever
- Correction possible: mettre un chanfrein en début et fin du pas de vis
  à la fois sur la vis intérieure et extérieure
- la fixation de cloche fonctionne super
- avec un matériau plus souple, il faudra probablement renforcer le tout
  typiquement rétrécir les ouvertures

À faire:
- [ ] Chanfrein
- [ ] arrondir plus les ouvertures
- [ ] trou pour ressort: il faudrait 5.5 mm pour 7mm de profondeur
- [ ] trou de fixation du poids: il faudrat 3mm au lieu de 2.5mm
- [ ] cône au fond du trou dans la vis pour le ressort pour éviter du support
