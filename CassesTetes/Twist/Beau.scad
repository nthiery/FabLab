c = 40;
d=3;

module on_cube(s) {
  i = 1;
  // for (i=[-1:2:1])
    for (j=[-1:2:1])
      for (k=[-1:2:1])
	  translate([i*s/2,j*s/2,k*s/2]) children(0);
}

module piece() {
  //cube(c, center=true);
  for (i=[-1:0.01:3])
    rotate([i*90, 0, 0]) on_cube(c+i*c) sphere(d);
  // cube(2*c, center=true);
}

t=0;

color([1,0,0]) translate([-(2-t)*c, 0, 0]) rotate([90*t, 0, 0]) piece();
color([0,1,0]) translate([ (2-t)*c, 0, 0]) rotate([90*t, 0, 180]) piece();
color([0,0,1]) translate([0, -(2-t)*c, 0]) rotate([0, 90*t, 0]) rotate([0,0,90]) piece();
color([1,1,0]) translate([0,  (2-t)*c, 0]) rotate([0, 90*t, 0]) rotate([0,0,-90]) piece();
color([1,0,1]) translate([0, 0, -(2-t)*c]) rotate([0, 0, 90*t]) rotate([0,-90,0]) piece();
color([0,1,1]) translate([0, 0,  (2-t)*c]) rotate([0, 0, 90*t]) rotate([0, 90,0]) piece();
