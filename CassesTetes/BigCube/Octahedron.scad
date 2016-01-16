module octahedron(scl) {
     scale(scl)
	  polyhedron (
     points = [[ 1, 0, 0],
	       [-1, 0, 0],
	       [ 0, 1, 0],
	       [ 0,-1, 0],
	       [ 0, 0, 1],
	       [ 0, 0,-1]],
     faces = [[0,4,2],
	      [0,2,5],
	      [0,3,4],
	      [0,5,3],
	      [1,2,4],
	      [1,5,2],
	      [1,4,3],
	      [1,3,5]]
             );
}

octahedron(20);
