---
layout: project-disabled
machines: 3D_printer
title: A juggling ball holding a bell
authors: [delavenere, hivert, nthiery]
license: ???
sources: [model.scad]
images: [model.png]
date: 2016/10/20
parameters:
  Shell thickness: 0.8
  Layer Height: 0.2
  Travel Speed: 100
  Fill density: 100%
  Nozzle size: 0.8
  Support type: Everywhere
  Platform adhesion type: Brim
  Brim line amount: 10
  Support: everywhere
material: PLA/PHA
---

The professional juggler [Vincent
Delavenère](http://www.vincentdelavenere.com/) has been exploring over
the last decade various ways to build musical juggling balls. This
ball we designed with him is 3D printed and unscrews into two half
spheres into which a bell can be fitted.

## Printing Notes

Load the stl model in [cura](http://wiki.ultimaker.com/Cura), split it
into two pieces, rotate if needed the pieces so that they lays flat on
their outer rim.

## Related work

### Laser cut wood support for the bells

- [rondelle.py](rondelle.py)
- [rondelle.eps](rondelle.eps)

### A preliminary OpenSCAD model starting from an existing Screwball stl

- [Original stl model](Screwball_7.stl), taken from [http://www.thingiverse.com/thing:61205]()
- [OpenSCAD file](Screwball.scad)

## Related models on thingiverse

- Pokemon ball: [http://www.thingiverse.com/thing:411193]()
- Screwball: [http://www.thingiverse.com/thing:61205]()
- Snap-locking Sphere Container: [http://www.thingiverse.com/thing:3272]()

  Initial version: Snap-locking sphere container inspired by Demi-sphere
  [http://www.thingiverse.com/thing:3100]()
  With openscad code

- Spherical Container from Hexagons [http://www.thingiverse.com/thing:351617]()

  Not quite what we are looking for, but there is OpenSCAD code.


