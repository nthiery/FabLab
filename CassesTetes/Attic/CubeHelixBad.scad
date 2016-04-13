intersection(){
    linear_extrude(height = 20, twist = 360, slices = 360) {
        translate([10.1,10.1,0]){
            square(20, center = true);
        }
    }
    translate([-10.1,-10.1,0]){
        cube([20,20,20]);
    }
}