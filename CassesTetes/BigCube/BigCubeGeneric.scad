use <Octahedron.scad>;

module shapeCylinder() {
     rotate([90, 0, 0])
	  cylinder(r=sqrt(2)/2*cote, h=3*cote, center=true);
};

module shapeOctahedron() {
     octahedron(cote*3/2);
}

module shapeBar() {
     cube([3*cote, 2*cote, cote], center=true);
}

module shapeTruncatedCube() {
     intersection() {
	  octahedron(cote*3/2);
	  cube(3*cote/2, center=true);
     }
}


module piece() {
  difference() {
     intersection()
     {
	  shape();
	  translate([-cote/2, -c2, eps/2]) cube([cote,2*c2,c2]);
     }

     translate([0,  cote/4, 0]) rotate([45, 0, 0]) cube([c2, de, de], center=true);
     translate([0, -cote/4, 0]) rotate([45, 0, 0]) cube([c2, de, de], center=true);

     translate([ d,0,d+cote/2]) rotate([0, 45,0]) cube([c2, cote+eps, cote], center=true);
     translate([-d,0,d+cote/2]) rotate([0,-45,0]) cube([c2, cote+eps, cote], center=true);

     translate([-d,0,-d+eps/2]) rotate([0, 45,0]) cube([c2, cote/2, cote], center=true);
     translate([ d,0,-d+eps/2]) rotate([0,-45,0]) cube([c2, cote/2, cote], center=true);
  }
}

module linkBar(fn=4, r=cote/2) {
          intersection() {
     	  rotate([90, 0, 0])
     	       cylinder(r=r, h=lbar*2-cote-eps, center=true, $fn=fn);
     	  translate([-cote, -lbar, eps/2]) cube([c2,lbar*2,c2]);
     }
}

module bipiece() {
     translate([0, -lbar, 0]) piece();
     translate([0, lbar, 0]) rotate ([0,0,180]) piece();
     link();
}

//bipiece();


module assemble(cote, lbar, t) {

  module quad () {
     translate([0,0,  cote/2*(1-t) ]) bipiece();
     translate([0,0,-(cote/2*(1-t))]) rotate([0, 180, 0]) bipiece();
  };

  module direct() {
     translate ([ lbar, 0,  lbar]) quad();
     translate ([ lbar, 0, -lbar]) quad();
     translate ([-lbar, 0,  lbar]) quad();
     translate ([-lbar, 0, -lbar]) quad();
  }

  direct ();
  rotate([90, 90, 0]) direct();
  rotate([0, 90, 0]) rotate([0, 0, 90]) direct();
  
}


// Shape parameters
cote=40;
c2=2*cote;
eps=0.5;
d=cote*sqrt(2)/4;
de=d+eps;
$fn=50;

// Choice of the vertex of the cube
module shape() { shapeBar(); } lbar=cote;
// module shape() { shapeCylinder(); } lbar=1.22*cote;
// module shape() { shapeOctahedron(); } lbar=3*cote/2;
// module shape() { sphere(cote*sqrt(3)/2); } lbar=cote*1.21;
// module shape() { shapeTruncatedCube(); } lbar=5*cote/4+eps;

// Choice of the edges of the cube
module link() { }
// module link() { linkBar(); }
// module link() { linkBar(r=cote/3); }
// module link() { linkBar(r=cote/3, fn=48); }

// Draw one piece
// bipiece();

// Assemble the cube
time = 0.5; // 0 = beggining of the move, 1 = end of the move
assemble(cote, lbar, time) { bipiece(); };

// Animation
// assemble(cote, lbar, $t) { bipiece(); };
