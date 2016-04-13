cote=40;
c2=2*cote;
eps=0.5;
d=cote*sqrt(2)/4;
de=d+eps;


module piece() {
  difference() {
     intersection()
     {
	  sphere(cote*sqrt(3)/2, $fn=200);
	  translate([-cote/2, -cote, eps/2]) cube([cote,c2,c2]);
     }

     translate([0,  cote/4, 0]) rotate([45, 0, 0]) cube([c2, de, de], center=true);
     translate([0, -cote/4, 0]) rotate([45, 0, 0]) cube([c2, de, de], center=true);

     translate([ d,0,d+cote/2]) rotate([0, 45,0]) cube([c2, cote+eps, cote], center=true);
     translate([-d,0,d+cote/2]) rotate([0,-45,0]) cube([c2, cote+eps, cote], center=true);

     translate([-d,0,-d+eps/2]) rotate([0, 45,0]) cube([c2, cote/2, cote], center=true);
     translate([ d,0,-d+eps/2]) rotate([0,-45,0]) cube([c2, cote/2, cote], center=true);
  }
}
piece();


// #cube(cote, center=true);
rotate([0, 180, 0]) piece();
rotate([90, 90, 0]) piece();
rotate([-90, 90, 0]) piece();
rotate([0, 90, 0]) rotate([0, 0, 90]) piece();
rotate([0, -90, 0]) rotate([0, 0, 90]) piece();

