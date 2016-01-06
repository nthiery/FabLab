use <HelixMod.scad>;

size = 40;
sl = 100;
jeu = 0.2;
rot = [0,0,0];

// for (i=[0:1:3])
i = 1;
translate([0,0,0]) intersection()
{
    rotate(rot) cube([size,size,size],center=true);
    rotate([0,0,90*i])
    translate([0,0,-size/2])
    quarter_cylinder_helix (height=size,
                            twist=360,
                            slices= sl,
                            radius=(2*size), nb = 6, jeu=jeu);
};
