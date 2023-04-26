---
jupytext:
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.14.2
kernelspec:
  display_name: Python 3 (ipykernel)
  language: python
  name: python3
---

# Traitement d'une image en vue de brodage

+++ {"user_expressions": []}

TODO:
- [x] Découpage en aplats de couleur
- [x] Conversion en svg
- [x] Nettoyage points isolés
- [ ] Conversion en gcode (instructions machine)

+++ {"user_expressions": []}

## Chargement et recadrage image d'origine

```{code-cell} ipython3
:tags: []

from PIL import Image, ImageFilter
import numpy as np

img = Image.open("manga.png")
img = img.crop(box=(10,70,830,693))
img
```

+++ {"user_expressions": []}

## Découpage et vectorisation

+++ {"tags": [], "user_expressions": []}

### Utilitaires

```{code-cell} ipython3
:tags: []


```

```{code-cell} ipython3
:tags: []

import subprocess
import webcolors
from svgutils.compose import SVG, Figure

def vectorize(bitmap, width=None, color="white"):
    input = color + ".pbm"
    output = color + ".svg"
    Image.fromarray(np.logical_not(bitmap)).save(input)
    subprocess.run(["potrace", input, "--width", width, "--svg", "--group", "--turdsize", "20", "--color", webcolors.name_to_hex(color), "-o", output])
    return SVG(output)

def remove_noise(M):# =  (rougeur < 100) & (clarte >  696)
    return M
    img = Image.fromarray(M)
    N = np.array(img.convert("L").filter(ImageFilter.BoxBlur(3)))
    return M & (N>=20)
```

+++ {"user_expressions": []}

### Variante 1: Définition des aplats par seuillages manuels

```{code-cell} ipython3
:tags: []

# Extraction des canaux de couleurs et des attributs

M = np.array(img)
R = M[:,:,0]
G = M[:,:,1]
B = M[:,:,2]
A = M[:,:,3]
rougeur = R*2.0 - G*1.0 - B*1.0
clarte = R*1.0 + G*1.0 + B*1.0
```

```{code-cell} ipython3
:tags: []

# Définition des aplats par seuillage et vectorisation
width="5cm"
layers = [
    vectorize( (rougeur > 215) & (clarte >  160),                     width=width, color="red"),
    vectorize( (rougeur > 215) & (clarte == 160),                     width=width, color="darkred"),
    vectorize( (rougeur < 100) & (clarte >  696),                     width=width, color="white"),
    vectorize( (rougeur < 100) & (clarte >  60 ) & ( clarte <= 696 ), width=width, color="gray")
]

# Reconstruction de l'image à partir de chacun des aplats
svg = Figure(layers[0].width, layers[0].height, *[layer for layer in layers])
svg.save("manga.svg")
svg
```

```{code-cell} ipython3
:tags: []

webcolors.name_to_rgb("darkgray")
```

+++ {"user_expressions": []}

## Variante 2: définition des aplats par une liste de couleurs 

```{code-cell} ipython3
:tags: []

colors = [
          "red", 
          #"darkred",
          "white",
          #"dimgray", 
          "lightgray",
          #"gray",
          "black",
]
rename_colors = {
    #"gray": "white"
}
          

nearest_colors = np.argmin(np.linalg.norm(np.array([M[:,:,:3] - webcolors.name_to_rgb(color) 
                                                    for color in colors]),
                                          axis=3),
                           axis=0)

# Définition des aplats par couleur la plus proche et vectorisation
width="20cm"
layers = [
    vectorize( nearest_colors == i, width=width, color=rename_colors.get(color, color) )
    for i, color in enumerate(colors) if color != "black"
]

# Reconstruction de l'image à partir de chacun des aplats
svg = Figure(layers[0].width, layers[0].height, *[layer for layer in layers])
svg.save("manga.svg")
svg
```

+++ {"user_expressions": []}

## Expériences

+++ {"tags": []}

### Appliquette d'expérimentation pour déterminer les seuils adéquats

```{code-cell} ipython3
@interact
def f(seuil_rougeur = IntSlider(200, -512, 512), seuil_clarte = IntSlider(100, 0,  768)):
    return Image.fromarray( (rougeur < seuil_rougeur) & ( clarte > seuil_clarte) )
```

+++ {"jp-MarkdownHeadingCollapsed": true, "tags": []}

### Suppression du fond

```{code-cell} ipython3
# Image.fromarray(clarte > 40)
```

```{code-cell} ipython3
A2 = A.copy()
A2[ clarte < 50 ] = 0
Image.fromarray(A2)

M2 = M.copy()
M2[:,:,3] = A2

Image.fromarray(M2)
```

+++ {"tags": []}

### Tentative de nettoyage des points isolés par floutage

Pas adapté à notre besoin:
- étale les contours
- il reste des points

```{code-cell} ipython3
---
jupyter:
  source_hidden: true
tags: []
---
Mflou = np.array(img.filter(ImageFilter.BLUR))*1.0
clarte = Mflou[:,:, 0:3].sum(axis=2)
clarte
```

```{code-cell} ipython3
Image.fromarray(clarte > 20)
```

+++ {"tags": []}

### Appliquette pour explorer les seuils de l'image

```{code-cell} ipython3


from ipywidgets import interact, IntSlider

@interact
def f(seuil=IntSlider(50,0,765)):
    A2 = A.copy()
    A2[ clarte < seuil ] = 0
    Image.fromarray(A2)

    M2 = M.copy()
    M2[:,:,3] = A2

    return Image.fromarray(M2)
```

## Aplats et reconstruction par bitmap

```{code-cell} ipython3
# Définition des aplats par seuillage 
rouge_clair = (rougeur > 215) & ( clarte > 160)
rouge_sombre = (rougeur > 215) & (clarte == 160)
blanc = (rougeur < 100 ) & ( clarte > 696 )
gris_sombre = (rougeur < 100 ) & (clarte > 60 ) & ( clarte <= 696 )

# Sauvegarde et vectorisation

import webcolors
#couches = {}
#couces['blanc'] = 
Image.fromarray(np.logical_not(blanc)).save("blanc.pbm")
!potrace blanc.pbm --svg -o blanc.svg
Image.fromarray(np.logical_not(gris_sombre)).save("gris_sombre.pbm")
!potrace gris_sombre.pbm --svg -o gris_sombre.svg
Image.fromarray(np.logical_not(rouge_clair)).save("rouge_clair.pbm")
!echo potrace rouge_clair.pbm --svg --color {webcolors.name_to_hex("Pink")} -o rouge_clair.svg
Image.fromarray(np.logical_not(rouge_sombre)).save("rouge_sombre.pbm")
!potrace rouge_sombre.pbm --svg -o rouge_sombre.svg

# Reconstruction de l'image à partir de chacune des couches pour vérification visuelle
N = M.copy()
N [:,:,: ] = 0
N [rouge_clair, 0:3 ] = [ 255, 50, 50 ]
N [rouge_sombre, 0:3 ] = [ 100, 0, 0 ]
N [blanc, 0:3] = [255,255,255]
N [gris_sombre, 0:3] = [100, 100, 100]
N [ rouge_clair | rouge_sombre | blanc | gris_sombre, 3] = 255
Image.fromarray(N)
```
