use <HelixMod.scad>;

jeu = 0.2;
steps = 10;
zz=0.01;

intersection()
{ 
  polyhedron ( points = [[0, 20, -20*sqrt(2)/2],
                         [0, -20,-20*sqrt(2)/2],
                         [20, 0,  20*sqrt(2)/2],
                         [-20, 0, 20*sqrt(2)/2],
                         ],
                 faces = [[0,1,2],
                          [0,3,1],
                          [0,2,3],
                          [1,3,2]]
             );
  translate([0, 0, -20*sqrt(2)/2]) {
       half_cylinder_helix (height=20*sqrt(2),
			    twist=360+90,
			    slices=(360+90)/steps,
			    radius=40, nb = 6, jeu=jeu);
       }
}

