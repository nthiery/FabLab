$fn = 12;

module cylinder_ep(p1, p2, r1, r2) {
     translate(p1) sphere(r=r1);
     translate(p2) sphere(r=r2);
     vector = [p2[0] - p1[0], p2[1] - p1[1], p2[2] - p1[2]];
     distance = sqrt(pow(vector[0], 2) +
		     pow(vector[1], 2) +
		     pow(vector[2], 2));
     translate(vector/2 + p1)
	  rotate([0, 0, atan2(vector[1], vector[0])])
	  rotate([0, atan2(sqrt(pow(vector[0], 2) +
                                pow(vector[1], 2)), vector[2]), 0])
	  cylinder(h = distance, r1 = r1, r2 = r2, center=true);
}

cylinder_ep([0, 10, 4], [0, 2, 6], 1, 1);
cylinder_ep([0, 10, 4], [5, 2, 6], 1, 1);
