use <Thread_Library.scad>

version = "preview_open";
//version = "preview_closed";
version = "print";
//version = "accessoires";

// Contrôle la finesse du résultat; 64 pour impression, 16 pour visualization
stepsPerTurn  = version == "print" ? 64:16; 	// number of slices to create per turn

// Dimensions vis et ecrous
visDiametreTete=6;
visDiametre=3;
visLongueur=30;

ecrouEpaisseur = 1.5;
ecrouDiametre = 6.5;

// Dimension de la cloche
diamExt=74;
haut=49;
diamHaut=35;
clochePosition=34;

module cloche () {
    cylinder(d2=diamExt, d1=diamHaut, h=haut);
}

// Dimensions socle cloche
epaisseurFeutre = 0;  // Epaisseur de l'éventuelle couche amortissante entre le socle et la cloche
socleDiametre = diamHaut;
visClocheEcartement=10;
visClocheEnfoncement=2.5;

// Dimensions contre socle cloche
contreSocleDiametre = 2*visClocheEcartement+ecrouDiametre+2;
contreSocleEpaisseur = 4;

module contreSocle () {
    difference () {
        cylinder(r=contreSocleDiametre/2,h=contreSocleEpaisseur, $fn=stepsPerTurn);
        union () {
            for (angle=[0:90:360]) {
                rotate([0,0,angle+45]) {
                    translate([visClocheEcartement, 0, -.1]) vis();
                    translate([visClocheEcartement, 0, contreSocleEpaisseur-ecrouEpaisseur+.1]) ecrou();
                }
            }
        }
    }
}

pitchRadius=42; 	// rayon du milieu du pas de vis
length=10;              // longeur de la vis
epaisseur=2.5;            // epaisseur de la balle

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


rsphere = pitchRadius+epaisseur;
echo ("Rayon de la balle : ", rsphere);

//////////////////////////////////////////////////////////////////////////////
// Utilitaires

// Il n'y a pas de primitive dans OpenScad pour construire un polytope plein défini par ses points extrémaux
// À la place, on peut faire l'enveloppe convexe de micro cubes comme celui ci-dessous
// https://spolearninglab.com/curriculum/software/3d_modeling/openscad/openscad_06.html

module pseudoPoint () {
    cube(.1, center=true);
}

// Coupe un objet centré par un coin à 45 degrés pour en voir l'intérieur
// r: une majoration du rayon maximal de l'objet
module coupe(r) {
    difference() {
        children(0);
        rotate([0,0,-135]) translate([r,r,0]) cube ([2*r,2*r,2*r], center=true);
    }
}

module vis(acces=0) {
    cylinder(r=visDiametre/2,h=visLongueur, $fn=stepsPerTurn);
    cylinder(r2=0,r1=visDiametreTete/2,h=visDiametreTete/2, $fn=stepsPerTurn);
    translate([0,0,-acces])
        cylinder(r=visDiametreTete/2, h=acces, $fn=stepsPerTurn);
}

module ecrou() {
    difference() {
        cylinder(r=ecrouDiametre/2, h=ecrouEpaisseur, $fn=6);
        translate([0,0,-.1])
        cylinder(r=visDiametre/2, h=ecrouEpaisseur+.2, $fn=stepsPerTurn);
    }
}

//////////////////////////////////////////////////////////////////////////////
// Dessin d'ouvertures régulières dans la balle
// Ici on les construit en creusant une collection de nbOuvertures cônes centrés sur le centre de la
// balle et répartis autour d'un axe radial
nbOuvertures=16;
// Les variables suivantes contrôlent la forme du cône de base
hauteurOuvertures=100; // Ne pas changer, sauf si la balle devenait plus grande
diametreInterieurOuvertures=47;
epaisseurInterieurOuvertures=3;
diametreExterieurOuvertures=500;
epaisseurExterieurOuvertures=60;

module ouvertures () {
    ratio = diametreInterieurOuvertures / diametreExterieurOuvertures;
    for (i =[1:nbOuvertures])
        rotate(a=360/nbOuvertures*i,v=[0,0,1])
            hull () {
                translate([0,0,0]) pseudoPoint();
                translate([-epaisseurInterieurOuvertures,diametreInterieurOuvertures,hauteurOuvertures]) pseudoPoint();
                translate([ epaisseurInterieurOuvertures,diametreInterieurOuvertures,hauteurOuvertures]) pseudoPoint();
                translate([-epaisseurExterieurOuvertures,diametreExterieurOuvertures,hauteurOuvertures]) pseudoPoint();
                translate([ epaisseurExterieurOuvertures,diametreExterieurOuvertures,hauteurOuvertures]) pseudoPoint();
            }
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
        intersection() {
            sphere(r=rsphere, $fn=stepsPerTurn);
            translate ([0,0, -rsphere])
                cylinder(r=socleDiametre/2, h=rsphere-clochePosition, $fn=stepsPerTurn);
        }
    }
    union () {
        mirror([0,0,1]) ouvertures();
        for (angle=[0:90:360]) {
            rotate([0,0,angle+45])
                translate([visClocheEcartement,0, -rsphere+visClocheEnfoncement]) vis(acces=visClocheEnfoncement);
        }
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
         // la vis pour attacher le contrepoids
         translate([0,0,rsphere]) rotate([180,0,0])
             vis();
         ouvertures ();
     }
  }
}

//////////////////////////////////////////////////////////////////////////////
// Construction des différentes versions

if (version == "print") {
    translate([rsphere+2, 0, 0]) rotate([0,180,0])
    balle_interieur();
    translate([-rsphere, 0, 0])
    balle_exterieur();
    translate([rsphere, 0, 0])
    contreSocle();
}
else if (version == "preview_closed") {
    translate ([0,0, -clochePosition])
        cloche();
    coupe(rsphere) {
        union() {
            balle_interieur();
            balle_exterieur();
        }
    }
}
else if (version == "preview_open") {
    translate([rsphere,0,0])
    coupe(rsphere)
        balle_interieur();
    translate([-rsphere,0,0])
    coupe(rsphere)
        balle_exterieur();
} else if (version == "accessoires") {
    vis();
    translate([10,0,0])
        ecrou();
    translate([-20,0,0])
        contreSocle();
}
