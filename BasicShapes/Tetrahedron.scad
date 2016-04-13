module tetrahedron(scl) {
    scale(scl)
	polyhedron ( points = [
			 [ 0, 1,-sqrt(2)/2],
                         [ 0,-1,-sqrt(2)/2],
                         [ 1, 0, sqrt(2)/2],
                         [-1, 0, sqrt(2)/2]
                         ],
                 faces = [[0,1,2],
                          [0,3,1],
                          [0,2,3],
                          [1,3,2]]
             );
};
tetrahedron(10);
