use <HelixMod.scad>;

size = 40;
sl = 120;
jeu = 0.2;
rot = [0,0,0];

// for (i=[0:1:3])
i = 1;
intersection()
{
    rotate(rot) cube([size,size,size],center=true);
    rotate([0,0,90*i])
    translate([0,0,-size/2])
    quarter_cylinder_helix (height=size,
                            twist=360,
                            slices= sl,
                            radius=size, nb = 6, jeu=jeu);
};
translate([-size/2,0,-size]) cube([size/2,1,size/2]);
