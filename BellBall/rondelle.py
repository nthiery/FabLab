#!/usr/bin/env python

from pyx import *
from math import sqrt

unit.set(defaultunit="mm")

nx = 7
ny = 5
diametre = 20.0
trou_central = 5 - .2
trou_vis = 3.0 - .2
trou_distance=6
margin = .3
style.linewidth.hairthin = style.linewidth(.25)
cut = [style.linewidth.hairthin, color.rgb.red]

def rondelle():
    c = canvas.canvas()
    c.stroke(path.circle(0, 0, diametre/2), cut)
    c.stroke(path.circle(0, 0, trou_central/2), cut)
    c.stroke(path.circle(trou_distance,0, trou_vis/2), cut)
    c.stroke(path.circle(-trou_distance,0, trou_vis/2), cut)
    #c.stroke(path.circle(0,trou_distance, trou_vis/2), cut)
    #c.stroke(path.circle(0,-trou_distance, trou_vis/2), cut)
    return c

xoffset = diametre+.3
#yoffset = xoffset
#oddshift = 0

yoffset = xoffset * sqrt(3.0) / 2.0
oddshift = .5

print("Preparation de %s * %s = %s rondelles"%(nx,ny,nx * ny))
print("Largeur: %s, hauteur: %s"%(nx*xoffset, (ny-1)*yoffset+xoffset))

can = canvas.canvas()
for x in range(nx):
    for y in range(ny):
        can.insert(rondelle(),
                 [trafo.translate(7+xoffset*(x+.5+(oddshift if y %2==1 else 0)),
                                  7+yoffset*(y+.5))])

import os

filename = 'rondelle'
can.writeEPSfile(filename)   # write eps file
retvalue = os.system("eps2eps %s.eps %s-ok.eps"%(filename, filename)) # fix it
retvalue = os.system("mv %s-ok.eps %s.eps"%(filename, filename)) # fix it

can.writePDFfile(filename)
can.writeSVGfile(filename)

