use <../HelixMod.scad>;

size = 60;
sl = 50;
jeu = 0.25;
rot = [30,20];

module draw_piece(i) {
    intersection(convexity=6)
    {
	rotate(rot) cube([size,size,size],center=true);
	rotate([0,0,90*i])
	     translate([0,0,-size])
	     quarter_cylinder_helix (height=(2*size),
				     twist=500,
				     slices= sl,
				     radius=(2*size), nb = 6, jeu=jeu);
    }
};

// for (i=[0:1:3]) # draw_piece(i);

draw_piece(3);
