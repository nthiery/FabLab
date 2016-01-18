use <HelixMod.scad>;

size = 30;
jeu = 0.2;
steps = 2;

intersection()
{ 
  polyhedron ( points = [[0, size, -size*sqrt(2)/2],
                         [0, -size,-size*sqrt(2)/2],
                         [size, 0,  size*sqrt(2)/2],
                         [-size, 0, size*sqrt(2)/2],
                         ],
                 faces = [[0,1,2],
                          [0,3,1],
                          [0,2,3],
                          [1,3,2]]
             );
  translate([0, 0, -size*sqrt(2)/2]) {
       half_cylinder_helix (height=size*sqrt(2),
			    twist=360+90,
			    slices=(360+90)/steps,
			    radius=2*size, nb = 6, jeu=jeu);
       }
}

