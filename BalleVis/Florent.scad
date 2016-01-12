use <Thread_Library.scad>


// Dimension de la cloche d'après texto Vincent.
diamExt=74;
haut=49;
diamHaut=35;
module cloche () {
     cylinder(d1=diamExt, d2=diamHaut, h=haut);
}

pitchRadius=43; 	// rayon du milieu du pas de vis
length=20;              // longeur de la vis
epaisseur=4;            // epaisseur de la balle



pitch=8;		// axial distance from crest to crest
threadHeightToPitch=0.2;// ratio between the height of the profile and the pitch
			// std value for Acme or metric lead screw is 0.5
profileRatio=0.25;	// ratio between the lengths of the raised part of the profile and the pitch
			// std value for Acme or metric lead screw is 0.5
threadAngle=30; 	// angle between the two faces of the thread
			// std value for Acme is 29 or for metric lead screw is 30
RH=true; 		// true/false the thread winds clockwise
clearance=0.05;		// radial clearance, normalized to thread height
backlash=0.05; 		// axial clearance, normalized to pitch
stepsPerTurn=64; 	// number of slices to create per turn

rsphere = pitchRadius+epaisseur;
echo ("Rayon de la balle : ", rsphere);


module vis_inter () {
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


module vis_exter () {
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


module balle_interieur() {
     union() {
	  translate ([0,0,-length/2])
	       difference () {
	       union() {
		    vis_inter();
		    rotate([0,0,180]) vis_inter ();
	       }
	       translate ([0,0,-1])
		    cylinder (r=pitchRadius-epaisseur,h=40, $fn=stepsPerTurn);
	  }
	  difference() {
	       intersection () {
		    sphere(r=rsphere,$fn=stepsPerTurn);
		    translate([0,0,-(rsphere+1)-length/2])
			 cube(2*rsphere+2,center=true);
	       }
	       intersection () {
		    sphere(r=rsphere-epaisseur, $fn=stepsPerTurn);
		    translate([0,0, -(rsphere+1)-length/2-1.5*epaisseur])
			 cube(2*rsphere+2,center=true);
	       }
	       translate ([0,0,-length/2-1.5*epaisseur-0.1])
		    cylinder (r=pitchRadius-epaisseur,h=length+0.2,
			      $fn=stepsPerTurn);
	  }
     }
}


module balle_exterieur() {
     union () {
	  intersection () {
	       translate ([0,0,-length/2]) vis_exter();
	       translate ([0,0,-length/2]) rotate([0,0,180]) vis_exter ();
	       sphere(r=rsphere,$fn=stepsPerTurn);
	  }
	  difference() {
	       intersection () {
		    sphere(r=rsphere,$fn=stepsPerTurn);
		    translate([0,0,rsphere+1+length/2])
			 cube(2*rsphere+2,center=true);
	       }
	       sphere(r=rsphere-epaisseur, $fn=stepsPerTurn);
	  }
     }
}


translate ([0,0, -15]) cloche();

// Coupe par un cube pour voir l'interieur de la balle: 
difference () { union () {

// translate ([80, 0, 0])
balle_interieur ();
balle_exterieur ();

} translate([0,0,-100]) cube ([100,100,200]); }
