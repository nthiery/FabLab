use <Thread_Library.scad>

//////////////////////////////////////////////////////////////////////////////
// Configuration générale

// Choix de la vue
vue = "eclatee"; // ["eclatee", "montee", "impression", "accessoires"]
//vue = "montee";
//vue = "impression";
//vue = "accessoires";

// Contrôle la finesse du résultat; 64 pour impression, 16 pour visualization
stepsPerTurn  = vue == "impression" ? 64:16; 	// number of slices to create per turn

//////////////////////////////////////////////////////////////////////////////
// Dimensions vis et ecrous
vis_diametre=3;
vis_longueur=30;
// Forme de la tête de la vis
vis_formeTete = "plate"; // ["fraisee", "plate"]
vis_diametreTete=6;
vis_longueurTete=2;

ecrou_epaisseur = 2;
ecrou_diametre = 6.5;

// Dimensions de la cloche
cloche_diametre_grand=74;
cloche_hauteur=49;
cloche_diametre_petit=35;
// À quelle hauteur est acrochée la base de la cloche
cloche_position=34;

// Dimensions du marteau
marteau_diametre = 20;
marteau_diametreRessort = 5;
marteau_longueurRessort = 25;

// Dimensions socle cloche
epaisseurFeutre = 0;  // Epaisseur de l'éventuelle couche amortissante entre le socle et la cloche
socleDiametre = cloche_diametre_petit;
visClocheEcartement=10;
visClocheEnfoncement=2.5;

//////////////////////////////////////////////////////////////////////////////
// Dimensions contre socle cloche

contreSocleDiametre = 2*visClocheEcartement+ecrou_diametre+2;
contreSocleEpaisseur = 6;

//////////////////////////////////////////////////////////////////////////////
// Dimensions de la balle: pas de vis, ...

pitchRadius=42; 	// rayon du milieu du pas de vis
length=10;              // longeur du pas de vis
epaisseur=2.5;            // epaisseur de la balle
epaisseur_vis_interne=1.5;

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

//////////////////////////////////////////////////////////////////////////////
// Accessoires

module vis(diametre=vis_diametre, longueur=vis_longueur,
           diametreTete=vis_diametreTete, longueurTete=vis_longueurTete, formeTete=vis_formeTete,
           acces=0) {
    // Filetage
    cylinder(r=diametre/2,h=longueur, $fn=stepsPerTurn);
    // Tête
    if (formeTete == "fraisee")
        cylinder(r2=0,r1=vis_diametreTete/2,h=diametreTete/2, $fn=stepsPerTurn);
    else
        cylinder(r=vis_diametreTete/2, h=vis_longueurTete, $fn=stepsPerTurn);
    // Volume d'accès à la tête (optionel)
    if ( acces > 0 )
        translate([0,0,-acces])
            cylinder(r=diametreTete/2, h=acces, $fn=stepsPerTurn);
}

module ecrou(diametre=ecrou_diametre, epaisseur=ecrou_epaisseur, diametre_interne=vis_diametre) {
    difference() {
        cylinder(r=diametre/2, h=epaisseur, $fn=6);
        translate([0,0,-.1])
        cylinder(r=diametre_interne/2, h=epaisseur+.2, $fn=stepsPerTurn);
    }
}

module cloche (diametre_grand=cloche_diametre_grand,
               diametre_petit=cloche_diametre_petit,
               hauteur = cloche_hauteur) {
    cylinder(d2=diametre_grand, d1=diametre_petit, h=hauteur);
}

// TODO: rajouter le trou central!
module contreSocle () {
    difference () {
        cylinder(r=contreSocleDiametre/2,h=contreSocleEpaisseur, $fn=stepsPerTurn);
        union () {
            // Trous pour les vis
            for (angle=[0:90:360]) {
                rotate([0,0,angle+45]) {
                    translate([visClocheEcartement, 0, -.1]) vis();
                    translate([visClocheEcartement, 0, contreSocleEpaisseur-ecrou_epaisseur+.1]) ecrou();
                }
            }
            // Trou pour le ressort du marteau
            cylinder(r=marteau_diametreRessort/2,h=contreSocleEpaisseur, $fn=stepsPerTurn);
        }
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
diametreExterieurOuvertures=600;
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
    difference () {
        union() {
            // Les deux filets
            for (angle=[0,180])
                translate ([0,0,HauteurVis]) rotate([0,0,angle]) vis_inter();
            // La demi calotte
            difference() {
                sphere(r=rsphere,$fn=stepsPerTurn);
                union() {
                    // Les ouvertures
                    mirror([0,0,1]) ouvertures();
                    // Un demi-espace simulé par un cube de largeur 4*rsphere
                    translate([0,0, 2*rsphere-length/2])
                        cube(4*rsphere,center=true);
                }
            }
        }
        // forme interne ovoïde pour rajouter de l'épaisseur au niveau de la vis interne
        translate([0,0,-HauteurVis])
            scale([rsphere-epaisseur-epaisseur_vis_interne,
                   rsphere-epaisseur-epaisseur_vis_interne,
                   rsphere-epaisseur-HauteurVis])
            sphere($fn=stepsPerTurn);
    }
}

module ajoute_socle() {
    difference() {
        // Le socle
        union() {
            children();
            // socle cloche
            intersection() {
                sphere(r=rsphere, $fn=stepsPerTurn);
                translate ([0,0, -rsphere])
                    cylinder(r=socleDiametre/2, h=rsphere-cloche_position, $fn=stepsPerTurn);
            }
        }
        // Les trous de vis
        for (angle=[0:90:360]) {
            rotate([0,0,angle+45])
                translate([visClocheEcartement,0, -rsphere+visClocheEnfoncement]) vis(acces=visClocheEnfoncement);
        }
    }
}

module balle_cloche_interieur() {
    ajoute_socle()
        balle_interieur();
}

module balle_exterieur() {
    // Le pas de vis externe
    intersection () {
        // Les deux filets
        for (angle=[0,180])
            translate ([0,0,HauteurVis]) rotate([0,0,angle]) vis_exter ();
        // La forme externe du pas de vis
        sphere(r=rsphere,$fn=stepsPerTurn);
    }
    // Le reste de la demi-sphere
    difference() {
        sphere(r=rsphere,$fn=stepsPerTurn);
        union() {
            sphere(r=rsphere-epaisseur, $fn=stepsPerTurn);
            ouvertures ();
            // un demi-espace
            translate([0,0,-2*rsphere+HauteurVis])
                cube(4*rsphere,center=true);
        }
    }
}

module balle_cloche_exterieur() {
    difference () {
        balle_exterieur();
        // la vis pour attacher le contrepoids
        translate([0,0,rsphere]) rotate([180,0,0])
            vis();
    }
}

//////////////////////////////////////////////////////////////////////////////
// Construction des différentes vues

if (vue == "impression") {
    translate([rsphere+2, 0, -HauteurVis]) rotate([0,180,0])
    balle_cloche_interieur();
    translate([-rsphere, 0, -HauteurVis])
    balle_cloche_exterieur();
    translate([rsphere, 0, 0])
    contreSocle();
}
else if (vue == "montee") {
    translate ([0,0, -cloche_position])
        cloche();
    coupe(rsphere) {
        union() {
            balle_cloche_interieur();
            balle_cloche_exterieur();
        }
    }
}
else if (vue == "eclatee") {
    translate([rsphere,0,0])
    coupe(rsphere)
        balle_cloche_interieur();
    translate([-rsphere,0,0])
    coupe(rsphere)
        balle_cloche_exterieur();
} else if (vue == "accessoires") {
    vis();
    translate([10,0,0])
        ecrou();
    translate([-20,0,0])
        contreSocle();
}
