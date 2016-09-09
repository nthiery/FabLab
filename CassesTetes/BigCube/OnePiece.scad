use <BigCubeGeneric.scad>;

// Shape parameters
cote=20;
c2=2*cote;
eps=0.5;
d=cote*sqrt(2)/4;
de=d+eps;
$fn=100;

module support () {
translate([0,0,-eps/2]) intersection() {
  difference() {
    translate([0,0,d/4-eps]) {
      union() {
        rotate([0,0, 45]) cube ([supwidth,4*d-2*eps,d/2], center=true);
	rotate([0,0,-45]) cube ([supwidth,4*d-2*eps,d/2], center=true);
       }
    }
    translate([ d,0,d+cote/2]) rotate([0, 45,0]) cube([c2, cote+eps, cote], center=true);
    translate([-d,0,d+cote/2]) rotate([0,-45,0]) cube([c2, cote+eps, cote], center=true);
  }
  translate([-cote/2, -cote, eps/2]) cube([cote,c2,5]);
}
}


// Choice of the vertex of the cube
// module shape(cote) { shapeBar(cote); } lbar=cote;
// module shape(cote) { shapeCylinder(cote); } lbar=1.22*cote;
// module shape() { shapeDodecahedron(cote); } lbar=cote;
// module shape(cote) { shapeOctahedron(cote); } lbar=3*cote/2;
module shape(cote) { sphere(cote*sqrt(3)/2); } lbar=cote*1.21;
// module shape(cote) { shapeTruncatedCube(cote); } lbar=5*cote/4+eps;

// Choice of the edges of the cube
// module link() { }
// module link() { linkBar(); }
// module link() { linkBar(r=cote/3); }
// module link() { linkBar(r=cote/3, fn=48); }

// Draw one piece
translate([0,0,-eps/2]) bipiece(cote);

supwidth = 1.2;
translate([0, lbar,0]) support();
translate([0,-lbar,0]) support();
