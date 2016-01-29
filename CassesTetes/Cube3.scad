use <HelixMod.scad>;

size = 40;
sl = 120;
jeu = 0.2;

rot = [45,35.26,0];

module piece () {
  intersection()
  {
    rotate(rot) cube([size,size,size],center=true);
    translate([0,0,-size*sqrt(3)/2])
    slice_cylinder_helix (angle=120,
			  height=size*sqrt(3),
                            twist=360-60,
                            slices= sl,
                            radius=size, nb = 6, jeu=jeu);
  }
};


piece();

/*
color ([1,0,0]) piece();
rotate([0,0,120]) color ([0,1,0]) piece();
rotate([0,0,-120]) color ([0,0,1]) piece();
*/
