cote=40;
c2=2*cote;
eps=0.5;
d=cote*sqrt(2)/4;
de=d+eps;


                    //cube origine  ([2*l,2*l,2*l],center=true);
l=cote/2;               // demi coté du cube
r=l*sqrt(3)-0.3;    // rayon de la sphère
                            //eps=0.1;
epais=2;            // epaisseur sous la calotte


module calotte() {
intersection() {
sphere(r,center=true,$fn=50);

rotate([45,0,0]) translate([ -2*l,0,0])
                 cube([4*l,4*l,4*l],center=false);;
                 
rotate([0,-45,0])translate([ 0,-2*l,0]) 
                 cube([4*l,4*l,4*l],center=false);;
 
translate ([0,0,2*l])cube([3*l,3*l,2*l+epais],center=true);   
               };
                   }


module piece() {
  difference()   {  
  intersection() {
    difference() {
                        // sphere(cote*sqrt(3)/2, $fn=200);
        translate ([0,0,l/2])   cube([l,2*l,l],center=true);

	translate([0,  cote/4, 0]) rotate([45, 0, 0]) cube([c2, de, de], center=true);
	translate([0, -cote/4, 0]) rotate([45, 0, 0]) cube([c2, de, de], center=true);

	translate([ d,0,d+cote/2]) rotate([0, 45,0]) cube([c2, cote+eps, cote], center=true);
	translate([-d,0,d+cote/2]) rotate([0,-45,0]) cube([c2, cote+eps, cote], center=true);

	translate([-d,0,-d+eps/2]) rotate([0, 45,0]) cube([c2, cote/2, cote], center=true);
	translate([ d,0,-d+eps/2]) rotate([0,-45,0]) cube([c2, cote/2, cote], center=true);
    }
  translate([-cote/2, -cote, eps]) cube([cote,c2,c2]);
    
   
  }
  translate([0,l-epais/2,0])
    cube([l,epais-eps,2*l],center=true) ;
  translate([0,-l+epais/2,0])
    cube([l,epais*2,2*l],center=true) ;
 } 
}

module sphere6morceaux6faces()
    union (){
              translate([0,0,eps])calotte (); 
              piece();
            }          
 
  
                                      //intersection()
                     color([1,0,0]) sphere6morceaux6faces();
rotate([ 90, 90, 0]) color([0,1,0]) sphere6morceaux6faces();     
rotate([-90, 90, 0]) color([0,0,1]) sphere6morceaux6faces();
rotate([180,  0, 0]) color([1,1,0]) sphere6morceaux6faces();
rotate([  0, 90, 0]) color([1,0,1]) sphere6morceaux6faces();
rotate([  0,-90, 0]) color([0,1,1]) sphere6morceaux6faces();
