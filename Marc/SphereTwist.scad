micote = 30;
rsphere = micote *sqrt(3);

cote = 2*micote;


module piece () {
difference () {
intersection () {
  sphere(rsphere, $fn=60);
  rotate([45,0,0]) translate([-cote,0,0]) cube(2*cote);
  rotate([45,0,90]) translate([-cote,0,0]) cube(2*cote);
}
  cube(cote, center=true);
}

rotate([0,0,45])
translate([0,0,-cote/2])
     linear_extrude(height=cote, twist=90) translate([0,5, 0]) square([5,20]);

rotate([0,0,180+45])
translate([0,0,-cote/2])
     linear_extrude(height=cote, twist=90) translate([0,5, 0]) square([5,20]);
//translate([0,5, -cote/2]) cube([5,20,cote]);

//translate([0,5, -cote/2]) cube([5,20,cote]);
//rotate([0,0,180]) translate([0,5, -cote/2]) cube([5,20,cote]);
};

/*
piece ();
color([1,0,0]) rotate([0, 180, 0]) piece();
color([0,1,0]) rotate([90, 90, 0]) piece();
rotate([-90, 90, 0]) piece();
color([0,0,1]) rotate([0, 90, 0]) rotate([0, 0, 90]) piece();
rotate([0, -90, 0]) rotate([0, 0, 90]) piece();
*/


module assemble(t) {

  module double () {
  rotate([0,0, 45*t+45]) translate([0,0,  cote/2*(1-t) ]) piece();
  rotate([0,0,-45*t-45]) translate([0,0,-(cote/2*(1-t))]) rotate([0, 180, 0]) piece();
};

  color([0,1,0]) double ();
  color([1,0,0]) rotate([90, 90, 0]) double();
  rotate([0, 90, 0]) rotate([0, 0, 90]) double();
}

assemble (0.1);
