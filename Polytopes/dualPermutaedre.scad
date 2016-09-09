module convex_poly(l) {
     hull() { for (point=l) translate (point) cube(0.0001); }
};

// compute the sum of a list of vectors
function sum_vects(l) = (len(l) == 0) ? [0,0,0] :
     sum_vects([for (i = [0:1:len(l)-2]) l[i]]) + l[len(l)-1];

// Todo : generate with a rec module
permdual4 = [[-5/9, 1/9, 1/9],
 [-1/3, -1/3, 1/6],
 [-1/9, -1/9, 5/9],
 [5/9, -1/9, -1/9],
 [1/3, 1/3, -1/6],
 [1/6, -1/3, -1/3],
 [1/3, -1/6, 1/3],
 [-1/3, -1/3, -1/3],
 [-1/3, 1/6, -1/3],
 [1/3, 1/3, 1/3],
 [1/9, -5/9, 1/9],
 [-1/9, 5/9, -1/9],
 [-1/6, 1/3, 1/3],
 [1/9, 1/9, -5/9]];
     


// projection matrix 4D -> 3D
// projmatrix = [[1, 0, 0], [0, 1, 0], [0, 0, 1], [-1/3, -1/3, -1/3]];

scale(10) convex_poly(permdual4);



