use <../BasicShapes/Dodecahedron.scad>;

cote=40*0.8;
c2=2*cote;
eps=0.4;
d=cote*sqrt(2)/4;
de=d+eps;

supwidth = 1;

module piece() {
  intersection() {
    difference() {
	dodecahedron(cote/2+4*eps);

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


// This is the support
module support () {
intersection() {
  difference() {
    translate([0,0,d/4-eps]) {
      union() {
        rotate([0,0, 45]) cube ([supwidth,4*d-2*eps,d], center=true);
	rotate([0,0,-45]) cube ([supwidth,4*d-2*eps,d], center=true);
       }
    }
    translate([ d,0,d+cote/2]) rotate([0, 45,0]) cube([c2, cote+eps, cote], center=true);
    translate([-d,0,d+cote/2]) rotate([0,-45,0]) cube([c2, cote+eps, cote], center=true);
  }
  translate([-cote/2, -cote, eps/2]) cube([cote,c2,5]);
}
}


translate([0,0,-eps/2]) {
     union() {
	  piece();
	  support();
     }
}



piece();
rotate([0, 180, 0]) piece();
rotate([90, 90, 0]) piece();
rotate([-90, 90, 0]) piece();
rotate([0, 90, 0]) rotate([0, 0, 90]) piece();
rotate([0, -90, 0]) rotate([0, 0, 90]) piece();

