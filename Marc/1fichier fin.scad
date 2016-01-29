l=20;
cote=l;
diag=l*sqrt(2)/2;
dia2=l*sqrt(2)/4;
eps=0.5;


module piece() {
    rotate([0,0,-45])
      translate([-dia2-eps,-dia2-eps,-cote/2])
         difference(){
                translate([eps,eps,0])
                cube([diag,diag,cote]);
                translate([diag,0,-diag])
                rotate( [0,0,45])cube([cote,cote,2*cote]);
           

                union() {
                       translate([dia2,dia2,cote/4])
                       rotate([0,45,45])
                       cube([dia2,cote,dia2],center=true) ;

                       translate([dia2,dia2,3*cote/4])
                       rotate([0,45,45])
                       cube([dia2,cote,dia2],center=true) ;
                        };
                union() {
                       translate([dia2,0,cote/4])
                       cube([cote/2,cote,cote/2]);

                       translate([0,dia2,cote/4])
                       cube([cote,cote/2,cote/2]);
                        };
                      } ;;
     
                }
 piece();
 //rotate([0,180,0])piece();  
    rotate([0,-90,-90])piece();              
   // rotate([0,90,90])piece(); 
         rotate([90,0,-90])piece();                  
       // rotate([90,0,+90])piece();               
       