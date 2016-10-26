difference() {
     cylinder(d=27, h=5, $fn=50);
     translate([0,0,-4]) cylinder(d=5, h=40, $fn=50);
     translate([0,10,-4]) cylinder(d=3, h=40, $fn=50);
     translate([10,0,-4]) cylinder(d=3, h=40, $fn=50);
     translate([0,-10,-4]) cylinder(d=3, h=40, $fn=50);
     translate([-10,0,-4]) cylinder(d=3, h=40, $fn=50);
}
