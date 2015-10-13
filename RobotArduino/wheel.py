#!/usr/bin/env python

from pyx import *

# text.set(mode="latex")
# text.preamble(r"""
# \usepackage[T1]{fontenc}
# \usepackage{amsmath,amsfonts}
# \usepackage{color}
# """)
# col = color.cmyk.Grey
# text.preamble(r"\definecolor{Gray}{cmyk}{%(c)g,%(m)g,%(y)g,%(k)g}" % col.color)

style.linewidth.hairthin = style.linewidth(0.01)
#style.linewidth.balls    = style.linewidth(0.3)
cut = [style.linewidth.hairthin, color.rgb.red]

pi = 3.1415926
radius = 2.5 # cm
rogne = .05
axis_diameter = 0.5 - rogne
axis_width = 0.3 - rogne

unit.set(defaultunit="cm")

def draw_wheel(radius, axis_diameter, axis_width, rays_nb=10, rays_width=.5):
    can = canvas.canvas()

    inner_circle    = path.circle(0, 0, axis_diameter/2)
    inner_rectangle = path.rect(-radius, -axis_width/2, 2*radius, axis_width)

    intersections = inner_circle.intersect(inner_rectangle)

    inner_circle_split = inner_circle.split(intersections[0])
    for i in [0,2]:
        can.stroke(inner_circle_split[i], cut)

    inner_rectangle_split = inner_rectangle.split(intersections[1])
    for i in [1,3]:
        can.stroke(inner_rectangle_split[i], cut)

    border = path.circle(0, 0, radius)
    can.stroke(border, cut)

    # inner_circle_clip = canvas.canvas([canvas.clip(inner_circle)])
    # inner_rectangle_clip = canvas.canvas([canvas.clip(inner_rectangle)])

    # inner_rectangle_clip.stroke(inner_circle, cut)
    # inner_circle_clip.stroke(inner_rectangle, cut)

#    can.stroke(path.arc(0,0,1.5, 0, 180))

#    angle = 360 / rays_nb

#    for i in range(rays_nb):
#        can.stroke(path.arc(0,0,radius-rays_width, angle*(i-1/2+.1), angle*(i+1/2-.1)), cut)

    # can.insert(inner_rectangle_clip)
    # can.insert(inner_circle_clip)
    return can

c = canvas.canvas()

margin = .5
voffset = radius + margin + 2*radius
for i in range(1,5):
    hoffset = (1 + 2.1*i) * radius + margin
    c.insert(draw_wheel(radius, axis_diameter, axis_width), [trafo.translate(hoffset, voffset)])

import os

filename = 'wheel'
c.writeEPSfile(filename)   # write eps file
retvalue = os.system("eps2eps %s.eps %s-ok.eps"%(filename, filename)) # fix it
retvalue = os.system("mv %s-ok.eps %s.eps"%(filename, filename)) # fix it

#c.writePDFfile('hello')
#c.writeSVGfile('hello')

