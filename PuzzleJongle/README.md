A Quick documentation on how to build puzzle pieces in Python
=============================================================


The goal is to automatically generate some kinds of piece of a puzzle from
Python. Since the number of pieces was large, I wanted to keep the number of
by-hand intervention as minimal as possible. I tried to use various technology
for drawing the puzzle pieces (Sage / Mathplotlib ...) I've found that for my
purpose PyX (http://pyx.sourceforge.net/) seems to be the easiest.

Here are (from PyX website) its main feature:
  - PostScript, PDF, and SVG output for device independent, freely scalable figures
  - seamless TeX/LaTeX integration
  - full access to PostScript features like paths, linestyles, fill patterns,
    transformations, clipping, bitmap inclusion, etc.
  - advanced geometric operations on paths like intersections,
    transformations, splitting, smoothing, etc.

It is not as well know as Matplotlib. It is also a relatively old code (first
release in 2002) but it is still actively maintained (last release from
2015/04/30) and the author are responsive to bug report (It took 3 day to
integrate a suggested bug fix). In my opinion, the code is also quite clear
and well written, I had no difficulties to debug it.



## EXAMPLE on how to use PYX


See my script piece-pyx.py. Here is  an example on how to use it:

Generating the file:

    ./piece-pyx.py

You should get a file name piece-ok.eps similar to result.eps which is ready for cutting

Printing (replacing 192.168.*.* by the IP address of your printer).

    export DEVICE_URI="epilog://192.168.*.*/Legend/rp=60/rs=50/vp=100/vs=10/vf=500/rm=grey"
    ../../cups-epilog/epilog 123 jdoe test < piece-ok.eps



## BUGS and CAVEAT:


1. I didn't manage to use relative coordinate on the epilog printer. The origin
calibration didn't work. So I used absolute (cartesian) coordinate from the
left bottom corner of the laser cutter.

2. The eps produced by pyx doesn't work well with the driver when using LaTeX
fonts. It breaks when calling ghostscript. As a workaround I'm using eps2eps
which seems to fix the problem It is called automatically by my script by the
following lines:

        import os
        filename = 'piece'
        c.writeEPSfile(filename)
        retvalue = os.system("eps2eps %s.eps %s-ok.eps"%(filename, filename))

Good printing and cutting.
