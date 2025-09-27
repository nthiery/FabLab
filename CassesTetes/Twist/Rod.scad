module rod(a, b, r) {
    dir = b-a;
    h   = norm(dir);
    if(dir[0] == 0 && dir[1] == 0) {
        // no transformation necessary
        cylinder(r=r, h=h);
	translate(a) sphere(r=r);
	translate(b) sphere(r=r);
    }
    else {
        w  = dir / h;
        u0 = cross(w, [0,0,1]);
        u  = u0 / norm(u0);
        v0 = cross(w, u);
        v  = v0 / norm(v0);
        multmatrix(m=[[u[0], v[0], w[0], a[0]],
                      [u[1], v[1], w[1], a[1]],
                      [u[2], v[2], w[2], a[2]],
                      [0,    0,    0,    1]])
	union () {
	     cylinder(r=r, h=h);
	     sphere(r=r);
	     translate([0,0,h]) sphere(r=r);
	}
    }
}

rod([1,2,2], [3,5,4], 1, $fn=24);
