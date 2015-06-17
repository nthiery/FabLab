#!/usr/bin/env python

from pyx import *

text.set(mode="latex")
text.preamble(r"""
\usepackage[T1]{fontenc}
\usepackage{amsmath,amsfonts}
\usepackage{color}
""")
col = color.cmyk.Grey
text.preamble(r"\definecolor{Gray}{cmyk}{%(c)g,%(m)g,%(y)g,%(k)g}" % col.color)

style.linewidth.hairthin = style.linewidth(0.01)
style.linewidth.balls    = style.linewidth(0.3)


def draw_piece(left, right, throw):

    can = canvas.canvas()

    maxthrow = len(left)
    assert len(right) == maxthrow
    assert 0 <= throw <= maxthrow

    cut = [style.linewidth.hairthin, color.rgb.red]

    def ball_border(x, state):
        border = path.path(path.moveto(x,0), path.lineto(x,1))
        for i, bal in enumerate(state):
            if bal:
                border.append(path.arc(x,1.5*(i+1)+0.5,0.5,-90,90))
            else:
                border.append(path.arcn(x,1.5*(i+1)+0.5,0.5,-90,90))
            border.append(path.lineto(x,1.5*(i+1)+1.5))
        return border

    def draw_balls(xl, xr, balls, throw):
        for i, bal in enumerate(balls[1:]):
            if bal:
                can.fill(path.circle(xr, 1.5*i+2, 0.5), [color.cmyk.Grey])
                can.stroke(path.path(path.moveto(xl, 1.5*(i+1)+2), path.lineto(xr, 1.5*i+2)),
                           [style.linewidth.balls, color.cmyk.Grey]
                )
        if throw != 0:
            can.fill(path.circle(xr, 1.5*throw+0.5, 0.5), [color.cmyk.Grey])
            can.stroke(path.path(path.moveto(xl, 2), path.lineto(xr, 1.5*throw+0.5)),
                       [style.linewidth.balls, color.cmyk.Grey]
            )
    draw_balls(0, 4, left, throw)

    can.stroke(ball_border(0, left), cut)
    can.stroke(ball_border(4, right), cut)
    can.stroke(path.path(path.moveto(0,0), path.lineto(4,0)), cut)
    top = 1.5*maxthrow + 1.5
    can.stroke(path.path(path.moveto(0,top), path.lineto(4,top)), cut)

    can.text(2, 0.3, r"\textcolor{Gray}{\bf\textsf{"+str(throw)+"}}",
             [text.halign.center, trafo.scale(5)])

    can.text(3.7, 0.1, r"\textcolor{Gray}{A\!\!\!W\!Z}", [trafo.scale(0.3)])
    return can

def next_state(state, throw):
    maxthrow = len(state)
    assert 0 <= throw <= maxthrow
    res = state[1:]+[0]
    if state[0] == 0:
        assert throw == 0
    else:
        assert res[throw-1] == 0
        res[throw-1] = 1
    return res

c = canvas.canvas()

#Pour ecrire en outline:
#textpath = text.text(0, 0, r"\textsf{AWZ}").textpath().reversed()
#c.stroke(textpath, [trafo.scale(10)])

st1 = [1,0,1,1,0];

throw = 1; st = st1; st1 = next_state(st, throw)
c.insert(draw_piece(st, st1, throw), [trafo.translate(1, 11.2)])
throw = 3; st = st1; st1 = next_state(st, throw)
c.insert(draw_piece(st, st1, throw), [trafo.translate(6, 11.2)])
throw = 5; st = st1; st1 = next_state(st, throw)
c.insert(draw_piece(st, st1, throw), [trafo.translate(11, 11.2)])
throw = 5; st = st1; st1 = next_state(st, throw)
c.insert(draw_piece(st, st1, throw), [trafo.translate(16, 11.2)])
throw = 1; st = st1; st1 = next_state(st, throw)
c.insert(draw_piece(st, st1, throw), [trafo.translate(21, 11.2)])

throw = 4; st = st1; st1 = next_state(st, throw)
c.insert(draw_piece(st, st1, throw), [trafo.translate(1, 2)])
throw = 0; st = st1; st1 = next_state(st, throw)
c.insert(draw_piece(st, st1, throw), [trafo.translate(6, 2)])
throw = 4; st = st1; st1 = next_state(st, throw)
c.insert(draw_piece(st, st1, throw), [trafo.translate(11, 2)])
throw = 2; st = st1; st1 = next_state(st, throw)
c.insert(draw_piece(st, st1, throw), [trafo.translate(16, 2)])
throw = 3; st = st1; st1 = next_state(st, throw)
c.insert(draw_piece(st, st1, throw), [trafo.translate(21, 2)])


c.writeEPSfile('piece-2x5')
#c.writePDFfile('hello')
#c.writeSVGfile('hello')

