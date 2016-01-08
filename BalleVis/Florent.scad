use <Thread_Library.scad>

length=20;
epaisseur=5;

pitch=8;		// axial distance from crest to crest
pitchRadius=40; 	// radial distance from center to mid-profile
threadHeightToPitch=0.2;// ratio between the height of the profile and the pitch
			// std value for Acme or metric lead screw is 0.5
profileRatio=0.2;	// ratio between the lengths of the raised part of the profile and the pitch
			// std value for Acme or metric lead screw is 0.5
threadAngle=30; 	// angle between the two faces of the thread
			// std value for Acme is 29 or for metric lead screw is 30
RH=true; 		// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
clearance=0.05;		// radial clearance, normalized to thread height
backlash=0.05; 		// axial clearance, normalized to pitch
stepsPerTurn=64; 	// number of slices to create per turn

module inter () {
  intersection() {
     trapezoidThread(
	length=length+5,        // axial length of the threaded rod
	pitch=pitch,
	pitchRadius=pitchRadius,
	threadHeightToPitch=threadHeightToPitch,
	profileRatio=profileRatio,
	threadAngle=threadAngle,
	RH=RH,
	clearance=clearance,
	backlash=backlash,
	stepsPerTurn=stepsPerTurn
	);
     cube ([2*(pitch+pitchRadius+1), 2*(pitch+pitchRadius+1), length*2], center=true);
  }
}


module exter () {
     trapezoidNut(
	length=length,        // axial length of the threaded rod
        radius=4*pitchRadius,              // outer radius of the nut
	pitch=pitch,
	pitchRadius=pitchRadius,
	threadHeightToPitch=threadHeightToPitch,
	profileRatio=profileRatio,
	threadAngle=threadAngle,
	RH=RH,
	clearance=clearance,
	backlash=backlash,
	stepsPerTurn=stepsPerTurn,
        countersunk=0.5        // depth of 45 degree chamfered entries, normalized to pitch
        );

}

rsphere = pitchRadius+2*epaisseur;

difference () { union () {

union() {
     difference () {
	  union() {
	       inter();
	       rotate([0,0,180]) inter ();
	  }
	  # translate ([0,0,-1])
	      cylinder (r=pitchRadius-epaisseur,h=40, $fn=stepsPerTurn);
     }
     difference() {
	  intersection () {
	       sphere(r=rsphere,$fn=stepsPerTurn);
	       translate([0,0,-(rsphere+1)]) cube(2*rsphere+2,center=true);
	  }
	  intersection () {
	       sphere(r=rsphere-epaisseur, $fn=stepsPerTurn);
	       translate([0,0,-(rsphere+1)-length]) cube(2*rsphere+2,center=true);
	  }
	  # translate ([0,0,-length-0.1])
	      cylinder (r=pitchRadius-epaisseur,h=40, $fn=stepsPerTurn);
     }
}

// translate ([80, 0, 0])

union () {
     intersection () {
	  exter();
	  rotate([0,0,180]) exter ();
	  sphere(r=rsphere,$fn=stepsPerTurn);
     }
     difference() {
	  intersection () {
	       sphere(r=rsphere,$fn=stepsPerTurn);
	       translate([0,0,rsphere+1+length]) cube(2*rsphere+2,center=true);
	  }
	  sphere(r=rsphere-epaisseur, $fn=stepsPerTurn);
     }
}


} translate([0,0,-100]) cube ([100,100,200]); }
