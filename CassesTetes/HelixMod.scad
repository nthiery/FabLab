module half_cylinder_helix (
    height, twist, slices, radius, nb,
    jeu = 0.1,
    zz=0.01)
{
    steps = [-3/2, -1, -2/3, -1/3, -1/6, -1/10, -1/20, 0,
    	     1/20, 1/10, 1/6, 1/3, 2/3, 1, 3/2];
    shape = concat([for (i = [0:1:len(steps)-1])
			     [steps[i]*radius, jeu + zz * ((i % 2 == 0) ? 1 : 0)]],
		   [[3/2*radius, 3/2*radius+jeu],[-3/2*radius, 3/2*radius+jeu]]);

    intersection() {
	 linear_extrude(height=height, twist=twist, slices=slices, convexity=6) {
	      polygon(points=shape);
	 }
	 cylinder(h = height, r = radius, $fn=nb);
    }
}

half_cylinder_helix (40, 360, 20, radius=40, nb = 16, jeu=0.1);

module quarter_cylinder_helix (
    height, twist, slices, radius, nb,
    jeu = 0.1,
    zz=0.01)
{
     intersection() {
	  half_cylinder_helix(height, twist, slices, radius, nb, jeu, zz);
	  rotate([0,0,-90])
	  half_cylinder_helix(height, twist, slices, radius, nb, jeu, zz);
     }
};

color([1,0,0]) translate([0,0,-40])
quarter_cylinder_helix (40, 360, 20, radius=40, nb = 16, jeu=0.1);
