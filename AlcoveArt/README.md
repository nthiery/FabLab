# 3D picture

    sage: L = RootSystem(["A",3,1]).ambient_space()
    sage: L.plot(reflection_hyperplanes=False, bounding_box=85/100) # long time

# 3D Wireframe picture:

    sage: L = RootSystem(["B",3,1]).ambient_space()
    sage: W = L.weyl_group()
    sage: alcoves = [~w for d in range(12) for w in W.affine_grassmannian_elements_of_given_length(d)]
    sage: p = L.plot_fundamental_chamber("classical")
    sage: p += L.plot_alcoves(alcoves=alcoves, wireframe=True)
    sage: p += L.plot_fundamental_weights()
    sage: p.show(frame=False)

# 2D Alcove path for laser cutter

## Création fichier de base dans Sage

    sage: L = RootSystem(["A",2,1]).ambient_space()
    sage: w1 = [0,1,2,0,2,1,2,1,0,2,0,2,1,2,1,2,0,2,0,1,2,1,0,1]
    sage: p = L.plot(alcove_walk=w1, bounding_box=[[-4.5,4.5],[-2.5,6]], fundamental_chamber=False, labels=False)    # long time
    sage: for x in p:
    ....:     if isinstance(x, sage.plot.arrow.Arrow):
    ....:        x._options['arrowsize'] = 3
    sage: p.save("alcove.svg")

==> alcove.svg

### Nettoyage

Virer le fond blanc:

- Sélectionner objet
- Dégrouper 2 fois
- Sélectionner le fond blanc et le supprimer

S'assurer que le dessin est composé uniquement d'à plats, sans contours:

- Tout sélectionner puis dégrouper
- Tout sélectionner
- #Chemin -> Objet en chemin
- Chemin -> Combiner ^K
- Chemin -> Chemin en contour
- Pas de contour
- Fond


Sauvegarder dans alcove-sans-fond.svg

### Blueprint

- Scanner les bouts de bois sur une feuille A4 (par ex.)
- Créer trois calques: BluePrint, Masque, Coupe
- Scan des bouts de bois -> BluePrint
- Dessiner deux petites croix de calibrage (en haut et en bas) -> BluePrint
  (variante: importer un fichier callage.svg comme calque)
- Copier-coller le contenu alcove-sans-fond -> Coupe

### Découpe à la forme du bout de bois

# Dessin frontière

- Dessin frontière dans le calque masque
- Pas de contour, diminuer l'opacité
- Masquer le calque BluePrint

# Ajout de la frontière aux alcoves

- Copie sur place Ctrl-Alt-V -> calque de coupe
- Cacher le calque Masque

- Pas de fond
- Contour: ~2 mm
- Contour en chemin
- Fond, pas de contour

- Sélectionner les alcoves et la frontière (^A)
- Union Ctrl-+

# Intersection avec l'intérieur de la frontière

- Afficher le calque Masque
- Sélectionner masque et alcoves
- Intersection Ctrl-*
- Déplacer dans le calque supérieur (Shift-PgUp)
- Supprimer le calque Masque

# Extraction du contour de coupe

- Opacité: 100%
- Contour en chemin
- Pas de fond
- Contour -> 0,1 px, rouge

# Enlever le cercle extérieur

Chemin -> Séparer Shift-Ctrl-K
Sélectionner la partie extérieure (en zoomant si nécessaire)
Supprimer
Tout sélectionner ^A
Union Ctrl-*

## Vérifier

Afficher le calque Bois
Remonter la croix de calibrage -> Coupe (Shift-PgUp x2)

## Imprimer

Imprimmer le tout sur feuille A4
Positionner la feuille sur la découpeuse

Sélectionner le calque coupe
Sauvegarder -> alcove-tranche-coupe.pdf

Lancer l'impression

TODO:

- s'assurer que la coupe commence par les croix de calage
- Alternative: créer feuille standard de calage, et l'inclure dans le document

Mettre le bois sur la feuille

Relancer l'impression
