cote=40;
c2=2*cote;
eps=0.5;
d=cote*sqrt(2)/4;
de=d+eps;


module piece() {
  intersection() {
    difference() {
        sphere(cote*sqrt(3)/2, $fn=200);

	translate([0,  cote/4, 0]) rotate([45, 0, 0]) cube([c2, de, de], center=true);
	translate([0, -cote/4, 0]) rotate([45, 0, 0]) cube([c2, de, de], center=true);

	translate([ d,0,d+cote/2]) rotate([0, 45,0]) cube([c2, cote+eps, cote], center=true);
	translate([-d,0,d+cote/2]) rotate([0,-45,0]) cube([c2, cote+eps, cote], center=true);

	translate([-d,0,-d+eps/2]) rotate([0, 45,0]) cube([c2, cote/2, cote], center=true);
	translate([ d,0,-d+eps/2]) rotate([0,-45,0]) cube([c2, cote/2, cote], center=true);
    }
  translate([-cote/2, -cote, eps/2]) cube([cote,c2,c2]);
  }
}

bla=d-2*eps;

translate([0,0,-eps/2]) {
     union() {
piece();
// This is the support 
intersection() {
  union() {
    translate([0,0,d/4-eps]) rotate([0,0, 45]) cube ([1,3*d-2*eps,d], center=true);
    translate([0,0,d/4-eps]) rotate([0,0,-45]) cube ([1,3*d-2*eps,d], center=true);
    translate([ bla, bla, 0]) cube(6, center=true);
    translate([ bla,-bla, 0]) cube(6, center=true);
    translate([-bla, bla, 0]) cube(6, center=true);
    translate([-bla,-bla, 0]) cube(6, center=true);
  }
  translate([-cote/2, -cote, eps/2]) cube([cote,c2,c2]);
}
}
}
/*
// #cube(cote, center=true);
rotate([0, 180, 0]) piece();
rotate([90, 90, 0]) piece();
rotate([-90, 90, 0]) piece();
rotate([0, 90, 0]) rotate([0, 0, 90]) piece();
rotate([0, -90, 0]) rotate([0, 0, 90]) piece();
*/
