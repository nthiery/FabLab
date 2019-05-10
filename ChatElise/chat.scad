/*
translate([5,0,5])
cube();


sphere(d=2, $fn=20);
translate([1,0,1])
sphere(d=1, $fn=20);
translate([-1,0,1])
sphere(d=1, $fn=20);
*/
facettes=50;

module point(p) {
    translate(p)
    sphere(.1, $fn=20);
}

module oreillePleine() {
    hull() {
        point([0,-1,0]);
        point([0,1,0]);
        point([1,0,0]);
        point([0,0,2]);
    };
}

module oreille() {
    difference() {
        oreillePleine();
        translate([-.1,0,0])
        scale(.6)
        oreillePleine();
    }
}

module aile() {
    scale([1,2.5,3])
    sphere($fn=facettes);
}


module chat() {
    // corps
    translate([0,0,4])
    scale([.8,.8,1])
    sphere(d=10, $fn=facettes);

    // tete
    translate([0,0,10])
    sphere(d=6, $fn=facettes);

    translate([0, 1,12.3])
    rotate(a=[-30,0,0])
    oreille();

    translate([0,-1,12.3])
    rotate(a=[30,0,0])
    oreille();
  
    // yeux  
    /*
    translate([-2.3,1,11])
    sphere(.5,$fn=facettes);
    translate([-2.3,-1,11])
    sphere(.5,$fn=facettes);*/
    
    translate([1,2,5])
    rotate([0,-10,0])
    aile();

    translate([1,-2,5])
    rotate([0,-10,0])
    aile();
    
}

//chat();


difference() {
difference() {
    chat();
    // intérieur corps
    translate([0,0,4])
    scale([.8,.8,1])
    sphere(d=9, $fn=facettes);
    // intérieur tête
    translate([0,0,10])
    sphere(d=5, $fn=facettes);

    translate([0,0,8])
    cylinder(1, d=3.75, center=true,$fn=facettes);

    
    translate([0,0,12.6])
    cylinder(.7, d1=2.2, d2=0, center=true,$fn=facettes);
    // ouverture du bas
    cylinder(h=5, d=6,center=true,$fn=facettes);
    cube([10,10,2.5], center=true);
}

//cube([20,20,20]);
}
