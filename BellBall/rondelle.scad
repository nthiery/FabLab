// toutes les dimensions sont en mm
diametre=26;
epaisseur=6;
trou_diametre_large=5.6;
trou_diametre=5.4;
epaisseur_large=2;
trou_vis_diametre=3.6;
trou_vis_ecartement=10;
fn=50; // nombre de facettes


difference() {
    cylinder(d=diametre, h=epaisseur, $fn=fn);
    translate([0,  0,-1]) cylinder(d=trou_diametre, h=epaisseur+2, $fn=fn);
    translate([0,  0,-1]) cylinder(d=trou_diametre_large, h=epaisseur_large+1, $fn=fn);
    for (angle=[0:90:360])
            rotate([0,0,angle+45])
                translate([trou_vis_ecartement, 0, -1])
                    cylinder(d=trou_vis_diametre, h=epaisseur+2, $fn=fn);
     
 }