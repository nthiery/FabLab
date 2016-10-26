diametreInterieurTrous=30;
diametreExterieurTrous=70;
hauteurTrous=100;
nbTrous=16;

module trous () {
for (i =[1:nbTrous])
    rotate(a=360/nbTrous*i,v=[0,0,1])
        scale([1,.2,1]) 
            translate([-diametreExterieurTrous/2,0,0]) 
                cylinder(h=hauteurTrous,r=(diametreExterieurTrous-diametreInterieurTrous)/2,$fn=3);
}

trous();