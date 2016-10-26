use <Thread_Library.scad>


// Dimension de la cloche d'après texto Vincent.
diamExt=74;
haut=49;
diamHaut=35;
epaisseurFeutre=2;  // Epaisseur de la couche amortissante entre la boule et la cloche
epaisseurSocleCloche=8;
ecartementVisCloche=10;
module cloche () {
     cylinder(d2=diamExt, d1=diamHaut, h=haut);
}
poscloche=35;


pitchRadius=42; 	// rayon du milieu du pas de vis
length=10;              // longeur de la vis
epaisseur=3;            // epaisseur de la balle

HauteurVis = -length/2;

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


// Contrôle la finesse du résultat; 64 pour impression, 16 pour visualization
stepsPerTurn=64; 	// number of slices to create per turn
//stepsPerTurn=16; 	// number of slices to create per turn

rsphere = pitchRadius+epaisseur;
echo ("Rayon de la balle : ", rsphere);

////////////////////////////////////////////////////////
// Dessin d'ouvertures régulières dans la balle
// Ici on les construit en creusant une collection de nbOuvertures cônes centrés sur le centre de la
// balle et répartis autour d'un axe radial 
nbOuvertures=16;
// Les variables suivantes contrôlent 
// Les cônes sont définis
hauteurOuvertures=100; // Ne pas changer, sauf si la balle
diametreInterieurOuvertures=50;
diametreExterieurOuvertures=480;
epaisseurOuvertures=40;

// Il n'y a pas de primitive dans OpenScad pour construire un polytope plein défini par ses points extrémaux
// À la place, on peut faire l'enveloppe convexe de micro cubes.
// https://spolearninglab.com/curriculum/software/3d_modeling/openscad/openscad_06.html
// 
module pseudoPoint () {
    cube(.1, center=true);
}

module ouvertures () {
  for (i =[1:nbOuvertures])
    rotate(a=360/nbOuvertures*i,v=[0,0,1])
        hull () {
            translate([0,0,0]) pseudoPoint();
            translate([0                    ,diametreInterieurOuvertures,hauteurOuvertures]) pseudoPoint();
            translate([-epaisseurOuvertures,diametreExterieurOuvertures,hauteurOuvertures]) pseudoPoint();
            translate([ epaisseurOuvertures,diametreExterieurOuvertures,hauteurOuvertures]) pseudoPoint();
        }
        //polyhedron(points=[[0,0,0],
        //                    [0                    ,diametreInterieurOuvertures,diametreExterieurOuvertures],
        //                    [-epaisseurOuvertures,diametreExterieurOuvertures,diametreExterieurOuvertures],
        //                    [ epaisseurOuvertures,diametreExterieurOuvertures,diametreExterieurOuvertures]],
        //            faces=[[0,1,2],[0,2,3],[0,3,1],[1,2,3]]);
        //scale([1,epaisseurOuvertures,1])
        //    translate([-diametreExterieurOuvertures/2,0,0]) 
        //        cylinder(h=hauteurOuvertures,r=(diametreExterieurOuvertures-diametreInterieurOuvertures)/2,$fn=3);
}

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

// TODO: chanfrein
diametreVis=3;
module trouVis() {
         cylinder(r=diametreVis/2,h=1.1*rsphere, $fn=stepsPerTurn,center=true);
}

module balle_interieur() {
  difference() {
    union() {
      translate ([0,0,HauteurVis])
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
      // socle cloche
      // TODO: le socle est trop épais maintenant et dépasse
      translate ([0,0, -poscloche-epaisseurSocleCloche/2-epaisseurFeutre])
          cylinder(r=diamHaut/2, h=epaisseurSocleCloche/2, $fn=stepsPerTurn);
      translate ([0,0, -poscloche-epaisseurSocleCloche-epaisseurFeutre])
          cylinder(r1=diamHaut/4, r2=diamHaut/2, h=epaisseurSocleCloche,   $fn=stepsPerTurn);
    }
    union () {
        mirror([0,0,1]) ouvertures();
        translate([-ecartementVisCloche,0, -poscloche]) trouVis();
        translate([ecartementVisCloche,0, -poscloche]) trouVis();
        translate([0,-ecartementVisCloche, -poscloche]) trouVis();
        translate([0, ecartementVisCloche, -poscloche]) trouVis();
    }
  }
}


module balle_exterieur() {
  difference () {
     union () {
	   intersection () {
	       translate ([0,0,HauteurVis]) vis_exter();
	       translate ([0,0,HauteurVis]) rotate([0,0,180]) vis_exter ();
	       sphere(r=rsphere,$fn=stepsPerTurn);
	   }
	   difference() {
	       intersection () {
		    sphere(r=rsphere,$fn=stepsPerTurn);
		    translate([0,0,rsphere+length+HauteurVis])
			  cube(2*rsphere+2,center=true);
	       }
	       sphere(r=rsphere-epaisseur, $fn=stepsPerTurn);
	   }
     }
     union () {
         // Trou de vis
         cylinder(r=diametreVis/2,h=1.1*rsphere, $fn=stepsPerTurn);
         ouvertures ();
     }
  }
}


decalage = 120;
//decalage = 0;
//translate ([0,decalage, -poscloche]) 
//  cloche();

// Coupe par un cube pour voir l'interieur de la balle: 
//difference () { 
  union () {
    balle_interieur ();
    translate ([0, decalage, 0])
      balle_exterieur();
  } 
  // translate([50,50,-100]) cube ([100,100,400],center=true);
//}