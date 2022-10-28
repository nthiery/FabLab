module cylinder_ep(p1, p2, r1, r2) {
     // translate(p1)sphere(r=r1,center=true);
     // translate(p2)sphere(r=r2,center=true);
     vector = [p2[0] - p1[0],p2[1] - p1[1],p2[2] - p1[2]];
     distance = sqrt(pow(vector[0], 2) +
		     pow(vector[1], 2) +
		     pow(vector[2], 2));
     translate(vector/2 + p1)
	  rotate([0, 0, atan2(vector[1], vector[0])]) //rotation
	  rotate([0, atan2(sqrt(pow(vector[0], 2)+pow(vector[1], 2)),vector[2]), 0])
	  cylinder(h = distance, r1 = r1, r2 = r2,center=true);
}

rank = 1;
time = 360*$t;
size = 20;
step = 2;
thick = 0.1;
faces=16;
ncurves=3;
for (b=[0:1:ncurves-1]) {
    for (a = [0:step:360*2])
    {
      u0 = cos(a+(360/ncurves)*b);
      v0 = cos(rank*(a+time));
      w0 = sin(rank*(a+time));
      u1 = cos(a+step+(360/ncurves)*b);
      v1 = cos(rank*(a+step+time));
      w1 = sin(rank*(a+step+time));
      cylinder_ep(size*[u0,v0,w0], size*[u1,v1,w1],
                  thick, thick, $fn=faces);
    }
  }
