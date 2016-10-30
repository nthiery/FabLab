use <threads.scad>

//////////////////////////////////////////////////////////////////////////////
// Configuration générale

// Choix de la vue
vue = "eclatee"; // ["eclatee", "montee", "impression", "accessoires"]
vue = "montee";
//vue = "impression";
//vue = "accessoires";
//vue = "pas_de_vis";

// Contrôle la finesse du résultat; 64 pour impression, 16 pour visualization
stepsPerTurn  = vue == "impression" ? 64:32; 	// number of slices to create per turn

//////////////////////////////////////////////////////////////////////////////
// Dimensions vis et ecrous
vis_diametre=3;
vis_longueur=30;
// Forme de la tête de la vis
vis_formeTete = "plate"; // ["fraisee", "plate"]
vis_diametreTete=6;
vis_longueurTete=2;
vis_marge=.1;

ecrou_epaisseur = 2;
ecrou_diametre = 6.5;

// Dimensions de la cloche
cloche_diametre_grand=74;
cloche_hauteur=49;
cloche_diametre_petit=35;
cloche_epaisseur=1;
cloche_diametre_trou=14;
// À quelle hauteur est acrochée la base de la cloche
cloche_position=34;
cloche_ecartement_trous_vis=10;

// Dimensions du marteau
marteau_diametre = 20;
marteau_diametreRessort = 5;
marteau_longueurRessort = 25;

// Dimensions socle cloche
epaisseurFeutre = .1;  // Epaisseur de l'éventuelle couche amortissante entre le socle et la cloche
socleDiametre = cloche_diametre_petit;
visClocheEnfoncement=2.5;

//////////////////////////////////////////////////////////////////////////////
// Dimensions contre socle cloche

contreSocleDiametre = 2*cloche_ecartement_trous_vis+ecrou_diametre+2;
contreSocleEpaisseur = 6;

//////////////////////////////////////////////////////////////////////////////
// Dimensions de la balle: pas de vis, ...

balle_diametre_interne=84; 	// rayon du milieu du pas de vis
balle_epaisseur=2.5;          // epaisseur de la balle
pasDeVis_epaisseurFilets=2; // epaisseur des filets
pasDeVis_nbFilets=2;        // nombre de filets
pasDeVis_longueur=10;              // longeur du pas de vis
// surplus d'epaisseur au niveau de la vis interne
pasDeVis_surplusEpaisseur=1.5;
// Décallage vers le bas du pas de vis interne pour s'assurer qu'il
// morde bien dans le pas de vis externe quand la balle est fermée,
// et aussi qu'il fusionne bien avec sa demi-sphère
pasDeVis_mordant=.1;

balle_diametre = balle_diametre_interne+2*balle_epaisseur;
echo ("Diamètre de la balle : ", balle_diametre);

//////////////////////////////////////////////////////////////////////////////
// Utilitaires

// Il n'y a pas de primitive dans OpenScad pour construire un polytope plein défini par ses points extrémaux
// À la place, on peut faire l'enveloppe convexe de micro cubes comme celui ci-dessous
// https://spolearninglab.com/curriculum/software/3d_modeling/openscad/openscad_06.html
// Ici, on mets des sphères de rayon 1 afin d'éviter les angles vifs

module pseudoPoint () {
    sphere(center=true,$fn=16);
}

// Coupe un objet centré par un coin à 45 degrés pour en voir l'intérieur
// r: une majoration du rayon maximal de l'objet
module coupe(r) {
    difference() {
        children();
        color("black")
        rotate([0,0,-135]) translate([r,r,0]) cube ([2*r,2*r,2*r], center=true);
    }
}

//////////////////////////////////////////////////////////////////////////////
// Accessoires

module vis(diametre=vis_diametre, longueur=vis_longueur, marge=vis_marge,
           diametreTete=vis_diametreTete, longueurTete=vis_longueurTete, formeTete=vis_formeTete,
           acces=0) {
    // Filetage
    color("silver") {
        cylinder(d=diametre+marge,h=longueur, $fn=stepsPerTurn);
        // Tête
        if (formeTete == "fraisee")
            cylinder(d2=0,d1=vis_diametreTete,d=diametreTete, $fn=stepsPerTurn);
        else
            cylinder(d=vis_diametreTete, h=vis_longueurTete, $fn=stepsPerTurn);
        // Volume d'accès à la tête (optionel)
        if ( acces > 0 )
            translate([0,0,-acces])
                cylinder(d=diametreTete, h=acces+.1, $fn=stepsPerTurn);
    }
}

module ecrou(diametre=ecrou_diametre, epaisseur=ecrou_epaisseur,
             diametre_interne=vis_diametre-2*vis_marge) {
    color("silver") difference() {
        cylinder(r=diametre/2, h=epaisseur, $fn=6);
        translate([0,0,-.1])
            cylinder(d=balle_diametre_interne, h=epaisseur+.2, $fn=stepsPerTurn);
    }
}

module cloche (diametre_grand=cloche_diametre_grand,
               diametre_petit=cloche_diametre_petit,
               hauteur=cloche_hauteur, epaisseur=cloche_epaisseur,
               diametre_trou=cloche_diametre_trou) {
    color ("red")
        difference() {
        cylinder(d2=diametre_grand, d1=diametre_petit, h=hauteur, $fn=stepsPerTurn);
        // Forme intérieure de la cloche
        translate([0,0,epaisseur])
            cylinder(d2=diametre_grand-epaisseur, d1=diametre_petit-epaisseur, h=hauteur-epaisseur+.1, $fn=stepsPerTurn);
        // Trou central
        cylinder(d=diametre_trou,h=3*epaisseur,$fn=stepsPerTurn,center=true);
        // Trous des vis
        for (angle=[0:90:360])
            rotate([0,0,angle+45])
                translate([cloche_ecartement_trous_vis, 0, -vis_longueur/2]) vis();
    }
}

module contreSocle () {
    difference () {
        cylinder(r=contreSocleDiametre/2,h=contreSocleEpaisseur, $fn=stepsPerTurn);
        union () {
            // Trous pour les vis
            for (angle=[0:90:360]) {
                rotate([0,0,angle+45]) {
                    translate([cloche_ecartement_trous_vis, 0, -.1]) vis();
                    translate([cloche_ecartement_trous_vis, 0, contreSocleEpaisseur-ecrou_epaisseur+.1]) ecrou();
                }
            }
            // Trou pour le ressort du marteau
            cylinder(r=marteau_diametreRessort/2,h=3*contreSocleEpaisseur, $fn=stepsPerTurn,center=true);
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
diametreInterieurOuvertures=50;
epaisseurInterieurOuvertures=1;
diametreExterieurOuvertures=600;
epaisseurExterieurOuvertures=55;

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

module balle_interieur() {
    difference () {
        union() {
            // Le pas de vis
            translate([0,0,-pasDeVis_longueur/2-pasDeVis_mordant])
            metric_thread(diameter=balle_diametre_interne+pasDeVis_epaisseurFilets/2, length=pasDeVis_longueur,
                          pitch=pasDeVis_epaisseurFilets,
                          n_starts=pasDeVis_nbFilets, n_segments=stepsPerTurn);
            // La demi calotte
            difference() {
                sphere(d=balle_diametre,$fn=stepsPerTurn);
                union() {
                    // Les ouvertures
                    mirror([0,0,1]) ouvertures();
                    // Un demi-espace simulé par un cube de largeur 2*balle_diametre
                    translate([0,0, balle_diametre-pasDeVis_longueur/2])
                        cube(2*balle_diametre,center=true);
                }
            }
        }
        // forme interne ovoïde pour rajouter de l'épaisseur au niveau de la vis interne
        translate([0,0,pasDeVis_longueur/2])
            scale([balle_diametre_interne/2-pasDeVis_surplusEpaisseur,
                   balle_diametre_interne/2-pasDeVis_surplusEpaisseur,
                   balle_diametre_interne/2+pasDeVis_longueur/2])
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
                sphere(d=balle_diametre, $fn=stepsPerTurn);
                translate ([0,0, -balle_diametre/2])
                    cylinder(r=socleDiametre/2, h=balle_diametre/2-cloche_position-epaisseurFeutre, $fn=stepsPerTurn);
            }
        }
        // Les trous de vis
        for (angle=[0:90:360]) {
            rotate([0,0,angle+45])
                translate([cloche_ecartement_trous_vis,0, -balle_diametre/2+visClocheEnfoncement]) vis(acces=visClocheEnfoncement);
        }
    }
}

module balle_cloche_interieur() {
    ajoute_socle()
        balle_interieur();
}

module balle_exterieur() {
    difference() {
        sphere(d=balle_diametre,$fn=stepsPerTurn);
        translate([0,0,-balle_diametre+-pasDeVis_longueur/2])
            cube(2*balle_diametre,center=true);
        translate([0,0,-pasDeVis_longueur/2])
        metric_thread(diameter=balle_diametre_interne+pasDeVis_epaisseurFilets/2, length=pasDeVis_longueur,
                      pitch=pasDeVis_epaisseurFilets, n_starts=pasDeVis_nbFilets,
                      n_segments=stepsPerTurn, internal=true);
        sphere(d=balle_diametre_interne, $fn=stepsPerTurn);
        ouvertures ();
    }
}

module balle_cloche_exterieur() {
    difference () {
        balle_exterieur();
        // la vis pour attacher le contrepoids
        translate([0,0,balle_diametre/2]) rotate([180,0,0])
            vis();
    }
}

//////////////////////////////////////////////////////////////////////////////
// Construction des différentes vues

if (vue == "impression") {
    translate([balle_diametre/2+2, 0, pasDeVis_longueur/2]) rotate([0,180,0])
    balle_cloche_interieur();
    translate([-balle_diametre/2, 0, pasDeVis_longueur/2])
    balle_cloche_exterieur();
    translate([balle_diametre/2+2, 0, 0])
    contreSocle();
}
else if (vue == "montee") {
    coupe(balle_diametre) {
        translate ([0,0, -cloche_position])
            cloche();
        balle_cloche_interieur();
        balle_cloche_exterieur();
    }
}
else if (vue == "eclatee") {
    translate([balle_diametre/2,0,0]) coupe (balle_diametre)
        balle_cloche_interieur();
    translate([-balle_diametre/2,0,0]) coupe(balle_diametre)
        balle_cloche_exterieur();
} else if (vue == "accessoires") {
    vis();
    translate([10,0,0])
        ecrou();
    translate([-20,0,0])
        contreSocle();
    translate([50,0,0])
        cloche();
} else if (vue == "pas_de_vis") {
    vis_inter();
}
