rpenta = 1/sin(72);

// rpenta * 1/2*sqrt(2)*sqrt(-sqrt(5) + 5)
cpenta = rpenta * sqrt(pow(sin(72), 2) + pow(1-cos(72), 2));

// z^2 + (1-cpenta/2)^2 + 1 = cpenta^2
// zc = sqrt(pow(cpenta, 2) - (pow(1-cpenta/2, 2) + 1));
zc = cpenta/2;

module dodecaprism() {
     polyhedron ( points = [
		       [ 1, 1, 0],
		       [ 1,-1, 0],
		       [-1, 1, 0],
		       [-1,-1, 0],
		       [ cpenta/2,0,zc],
		       [-cpenta/2,0,zc]
		       ],
                 faces = [[0,2,1],
                          [1,2,3],
                          [0,1,4],
			  [0,4,2],
			  [2,4,5],
			  [1,3,4],
			  [3,5,4],
			  [2,5,3]
		      ]
             );

};

module dodecahedron(scl) {
  scale(scl) {
    cube(2, center=true);
    translate([0,0,1]) dodecaprism();
    translate([0,0,-1]) rotate([180,0,0]) dodecaprism();
    rotate([-90,90,0]) translate([0,0,1]) dodecaprism();
    rotate([-90,90,180]) translate([0,0,1]) dodecaprism();
    rotate([90,0,0]) rotate([0,90,0]) translate([0,0,1]) dodecaprism();
    rotate([90,0,180]) rotate([0,90,0]) translate([0,0,1]) dodecaprism();
  }
};

dodecahedron();
