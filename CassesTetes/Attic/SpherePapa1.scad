cote=5;
epsilon=0.1;
d=cote*sqrt(2)/4;
de=d+epsilon;


module piece() {
difference() {
     intersection()
     {
	  sphere(cote*sqrt(2)/2, $fn=50);
	  translate([-5,-5,0]) cube(10,10,10);
     }

     translate([0, cote/4, 0]) rotate([45, 0, 0]) cube([10, de, de], center=true);
     translate([0, -cote/4, 0]) rotate([45, 0, 0]) cube([10, de, de], center=true);

     translate([d, 0, d+cote/2]) rotate([0,45,0]) cube([10, cote, cote], center=true);
     translate([-d, 0, d+cote/2]) rotate([0,-45,0]) cube([10, cote, cote], center=true);

     translate([-d, 0, -d+epsilon]) rotate([0,45,0]) cube([10, cote/2, cote], center=true);
     translate([d, 0, -d+epsilon]) rotate([0,-45,0]) cube([10, cote/2, cote], center=true);
}
}
piece();
// #cube(cote, center=true);

rotate([0, 180, 0]) piece();
rotate([90, 90, 0]) piece();
rotate([-90, 90, 0]) piece();
rotate([0, 90, 0]) rotate([0, 0, 90]) piece();
rotate([0, -90, 0]) rotate([0, 0, 90]) piece();

