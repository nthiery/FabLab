#!/usr/bin/env python3

from pyx import *

# text.set(mode="latex")
# text.preamble(r"""
# \usepackage[T1]{fontenc}
# \usepackage{amsmath,amsfonts}
# \usepackage{color}
# """)
# col = color.cmyk.Grey
# text.preamble(r"\definecolor{Gray}{cmyk}{%(c)g,%(m)g,%(y)g,%(k)g}" % col.color)

style.linewidth.hairthin = style.linewidth(0.0001)
style.linewidth.balls    = style.linewidth(0.3)
cut = [style.linewidth.hairthin, color.rgb.red]

can = canvas.canvas()

def rect():
    can = canvas.canvas()
    border = path.path(path.moveto(0,0),
                       path.lineto(0,1),
                       path.lineto(1,1),
                       path.lineto(1,0),
                       path.lineto(0,0),
    )
    can.stroke(border, cut)
    return can

def level1():
    can = canvas.canvas()
    can.insert(rect(), [trafo.scale(1/3., 1/3., 0.5, 0.5)])
    return can

def step(c):
    c1 = canvas.canvas()
    for i in range(3):
        for j in range(3):
            # if (i,j) != (1,1):
            c1.insert(c, [trafo.scale(1/3., 1/3.), trafo.translate(i/3., j/3.)])
    c1.insert(level1())
    return c1

c = canvas.canvas()
c = step(c)
c = step(c)
c = step(c)
c = step(c)

hoffset=0.2
voffset=1

size = 7

res = canvas.canvas()

res.insert(c,      [trafo.scale(size, size), trafo.translate(hoffset, voffset)])
res.insert(rect(), [trafo.scale(size, size), trafo.translate(hoffset, voffset)])

import os

filename = 'rect'
res.writeEPSfile(filename)   # write eps file
retvalue = os.system("eps2eps %s.eps %s-ok.eps"%(filename, filename)) # fix it

#c.writePDFfile('hello')
#c.writeSVGfile('hello')

