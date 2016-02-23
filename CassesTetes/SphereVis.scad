use <HelixMod.scad>;

r=30;
eps=0.1;
$fn=120;

sl = $fn;
jeu = 0.2;



module piece () {
intersection ()
{
  sphere(r);
  translate([0,0,-r])
  half_cylinder_helix (2*r, 270, sl, radius=40, nb = 6, jeu=0.1);
/* Yin yang extrude 
translate([0,0,-r])
linear_extrude(height=2*r, twist=300, slices=40, convexity=8) {
  difference () {
    union() {
      translate([0,-r]) square([2*r,2*r]);
      translate([0,r/2,0]) circle(r=r/2-eps);
    }
    translate([0,-r/2,0]) circle(r=r/2+eps);
  }
}
*/
}
}

piece();

/*
t = r*$t;
// t = 0.3*r;
rt = 25;
// intersection ()
{
translate([t, -t,0]) rotate([0,0,rt]) piece();
translate([-t,t,0]) rotate([0,0,180+rt]) piece();
}
*/
