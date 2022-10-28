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


time = 360*$t;
size = 20;
step = 2;
thick = 1;
for (a = [0:step:360*2])
{
  u = cos(a+60);
  v = cos(1.5*(a+time));
  w = sin(1.5*(a+time));
  u1 = cos(a+step+60);
  v1 = cos(1.5*(a+step+time));
  w1 = sin(1.5*(a+step+time));
  cylinder_ep(size*[u,v,w], size*[u1,v1,w1],
                         thick, thick, $fn=16);
}


