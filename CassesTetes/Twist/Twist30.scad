use <Rod.scad>;

c=40;
r=2;
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

turn=30;

module hull_if_lt (i, j) {
     if (i < j) hull() {children(); }
     else {children(); }
}

module piece() {
  //rotate([turn,0,0]) translate([c/2, 0, 0]) cube([r,c,c], center=true);
  for (i=[-1:step:1])
    hull_if_lt(i, 0.1) {   
    for (a=[0:2:2])
      rotate ([a*90-turn, 0, 0]) {
        rotate([i*turn, 0, 0])
          translate([(1+i)*c/2, (1+i)*c/2, (1+i)*c/2]) {
            // rotate([180, 0, 0]) translate([0,0,-r/2])
            rotate([175, 0, 0]) translate([0,-2*r,3*r])
		 cylinder(r=r, h=(1+i)*c-6*r);
	    // if (i < -0.2) {
	    //   rotate([182,0,0]) translate([0,0,(1+i)*c/2-r/2])
	    //   rotate([-88,0,0]) cylinder(r=3*r*(i+1)+1, h=(1+i)*c-1);
	    //  }
	}
      }
    }
}

//t=0.96;
t = 0.5;

color([1,0,0]) translate([-(2-t)*c, 0, 0]) rotate([90+turn*t, 0, 0]) piece();
color([1,0,0]) translate([ (2-t)*c, 0, 0]) rotate([90+turn*t, 0, 180]) piece();
color([0,1,0]) translate([0, -(2-t)*c, 0]) rotate([0, turn*t, 0])  rotate([0,0,90]) piece();
color([0,1,0]) translate([0,  (2-t)*c, 0]) rotate([0, -turn*t, 0]) rotate([0,0,-90]) piece();
color([0,0,1]) translate([0, 0, -(2-t)*c]) rotate([0, 0, turn*t])  rotate([0,-90,0]) piece();
color([0,0,1]) translate([0, 0,  (2-t)*c]) rotate([0, 0, -turn*t]) rotate([0, 90,0]) piece();


// piece();
/*
intersection() {
translate([-(2-t)*c, 0, 0]) rotate([turn*t, 0, 0]) piece();
translate([0, -(2-t)*c, 0]) rotate([0, turn*t, 0]) rotate([0,0,90]) piece();
}
*/
