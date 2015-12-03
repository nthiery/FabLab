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

    sage: L = RootSystem(["A",2,1]).ambient_space()
    sage: w1 = [0,1,2,0,2,1,2,1,0,2,0,2,1,2,1,2,0,2,0,1,2,1,0,1]
    sage: p = L.plot(alcove_walk=w1, bounding_box=[[-4.5,4.5],[-2.5,6]], fundamental_chamber=False); p    # long time
    sage: for x in p:
    ....:     if isinstance(x, sage.plot.arrow.Arrow):
    ....:        x._options['arrowsize'] = 3
    sage: p.save("alcove.svg")

alcove-contour.svg:

Partir de alcove.svg

Tout séléctionner
Convertir en chemin?
Chemin -> Combiner
Fond -> Néant
Contour -> 0,1 px, rouge

Dessin disque
Sélection chemin + disque
Intersection Ctrl-*

Comment gérer les labels?


