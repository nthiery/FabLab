3D printing recipes for geometric objects:
==========================================

1 - Modeling the objects using openscad (http://www.openscad.org/):
  To export the object:
  * click "Render" (Key: F6)
  * Export to .stl file

2 - Slicing the object using cura (http://wiki.ultimaker.com/Cura):
  * resize and move the object inside the printer

    Recommended settings for fine printing:

        Layer Height : 0.06
        Travel Speed 100

    If one needs thick walls (e.g. to slightly reshape the objects using a file) :

        Shell thickness: 1.2

  * Check for overhang (if some, possibly add some support using "support
    type" setting)
  * Check that all the layers are ok (thin walls sometime generate non
    existent layers).
  * Go to Menu "File->Print" and save a .gcode file

3 - Printing:
  * Copy the object to the SD-card of the printer.
  * Select print on the printer.

