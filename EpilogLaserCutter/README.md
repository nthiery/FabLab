Using the Epilog laser cutter
=============================

# References inkscape and laser cutting

- http://www.cutlasercut.com/resources/drawing-guidelines/styles-examples#using-our-drawing-templates
- http://atxhackerspace.org/wiki/Using_Inkscape_with_the_Laser_Cutter#Importing_to_CorelDraw
- http://www.nycresistor.com/2011/07/17/laser-cutting-commands/

# Fabmodules:

   a priori pilotage direct du graveur depuis linux
   Connection a priori directement ethernet <-> ethernet
https://github.com/FabModules/fabmodules-html5/wiki/How-to-install
http://fab.cba.mit.edu/classes/4.140/tutorials/LaserCutterTutorial/LaserCutterTutorial.html

# Instructions using CorelDraw on the PC

## Document preparation

 - Gravure (Raster): rouge, surface  (pour faire un trait: Arrange ->
   convert outline to object)
 - Découpe (Vector): noir, hairline (0.010mm 0.001" in inkscape)
 - Mettre dans une feuille 300 x 600
 - Activer seulement les calques utiles (dont éventuellement feuille)
 - Tout dégrouper: ^A Shift-^-G plusieurs fois
 - Exporter vers PDF; convert text to path

 - Open in Corel Draw
 - Sélection , right click, -> unlock if needed
 - Select all, enter object position w.r.t. upper corner (see upper left widget of Corel Draw)
 - Select toutes les lignes à découper, style -> outline -> width -> hairline

## Printing

 - Allumer alimentation + machine
 - Allumer aspirateur si nécessaire
 - Faire le zéro:
   9: pointeur
   8+confirm: désengager les moteurs 
   7: définir l'origine
 - Print -> Préférence
   600 DPI
   Régler les paramètres en fonction des indications p. 122 dans le bouquin
 - Print
 - Go

# Instructions for direct printing from linux using CUPS Epilog driver

## References

   https://github.com/thenexxuz/cups-epilog

## Installing the driver command

Instructions:

    sudo apt-get install libcups2-dev

    git clone https://github.com/thenexxuz/cups-epilog.git
    cd cups-epilog
    gcc -o epilog `cups-config --cflags` cups-epilog.c `cups-config --libs`

## Network configuration

Disconnect from wireless network

Connect on the netgear router/switch near the printer

Disconnect the windows machine

    sudo ifconfig eth0 129.175.5.207/16

    The Epilog printer is on 129.175.5.206 port 515

## Driver configuration

See the README.md file for details on the parameters

From the settings sheet, one would have expected the following to work for wood:

    export DEVICE_URI="epilog://129.175.5.206/Legend/rp=25/rs=100/vp=35/vs=100/vf=500/rm=grey" 

but the power seems too low. Slowing down with the following seems
about alright:

    export DEVICE_URI="epilog://129.175.5.206/Legend/rp=100/rs=20/vp=100/vs=20/vf=500/rm=grey"

Version Romain :

    export DEVICE_URI="epilog://129.175.5.206/Legend/rp=50/rs=50/vp=100/vs=7/vf=500/rm=grey"

## Usage

- Color code: grey values for raster, plain red for cutting

  See e.g. [](test.eps) for an example


- Export to eps from inkscape (Fichier -> Enregistrer une copie ->
  eps -> convertir texte en chemin (nécessaire?)

- Follow instructions as above for setting up the printer

- Launch the printing with:

    ./epilog 123 <user> <jobname> < file.eps

    ./epilog 123 nicolas test < test.eps

- Printing from pdf worked for raster but not for cutting ???

## Installing as a CUPS printer driver

TODO
