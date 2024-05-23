c=40;
r=3;
step=0.01;

/*
module on_cube(s) {
  i = 1;
  // for (i=[-1:2:1])
    for (j=[-1:2:1])
      for (k=[-1:2:1])
          translate([i*s/2,j*s/2,k*s/2]) children(0);
}

module piece() {
  translate([c/2, 0, 0]) cube([2*r,c,c], center=true);
  for (i=[0:step:1])
      rotate([i*90, 0, 0]) on_cube(c+i*c) sphere(r);
  //  rotate([(i+step)*90, 0, 0]) on_cube(c+(i+step)*c) sphere(r);
  // cube(2*c, center=true);
}
*/

turn=90;

module piece() {
  // translate([c/2, 0, 0]) cube([2*r,c,c], center=true);
  for (a=[0:1:3])
    rotate ([a*90, 0, 0])
      for (i=[-1:step:1]) {
        rotate([i*turn, 0, 0])
          translate([(1+i+step)*c/2,
                     (1+i+step)*c/2,
                     (1+i+step)*c/2])
                sphere(r);
      }
}

t=0.3;
// t = $t;


translate([-(2-t)*c, 0, 0]) rotate([turn*t, 0, 0]) piece();
color([1,0,0]) translate([ (2-t)*c, 0, 0]) rotate([turn*t, 0, 180]) piece();
translate([0, -(2-t)*c, 0]) rotate([0, turn*t, 0]) rotate([0,0,90]) piece();
color([0,1,0]) translate([0,  (2-t)*c, 0]) rotate([0, -turn*t, 0]) rotate([0,0,-90]) piece();
translate([0, 0, -(2-t)*c]) rotate([0, 0, turn*t]) rotate([0,-90,0]) piece();
color([0,0,1]) translate([0, 0,  (2-t)*c]) rotate([0, 0, -turn*t]) rotate([0, 90,0]) piece();

/*
intersection() {
translate([-(2-t)*c, 0, 0]) rotate([turn*t, 0, 0]) piece();
translate([0, -(2-t)*c, 0]) rotate([0, turn*t, 0]) rotate([0,0,90]) piece();
}
*/
