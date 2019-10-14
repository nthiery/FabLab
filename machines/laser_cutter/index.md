---
layout: machine
title: Epilog laser-cutter Mini 24"
images: [epilog_lasercutter_min_241.jpg]
---

## Network setup

The Epilog laser cutter is accessible through a private ethernet
network. It can be accessed either from the Windows machine on its
right or a laptop through the ethernet cable. The IP address is
129.175.5.206.  The windows IP address is 129.175.5.207. Apparently
129.175.5.208 is free.

## Command line instructions

Here are some instructions to print svg documents, typically produced
from inkscape, from a unix-based laptop (linux), using the cups-epilog
command-line driver.

### Turn on the laser cutter

Both the machine below and the laser cutter itself.

### Connect the laptop to the local network

#### Epilog Mini, Former configuration

Connect the laptop to the free orange cable on the table next to the
laser cutter.

Set:

    IP=129.175.5.207
    EPILOG_IP=129.175.5.206

#### Laser Fusion

Set:

    IP=192.168.3.5
    EPILOG_IP=192.168.3.4

### Setup network

If you are using wicd to manage your network connections, you need to turn off first the daemon:

    sudo service wicd stop

Set up the network with:

    sudo ifconfig eth0 $IP/16

Check the network connection:

    ping $EPILOG_IP

### Configure cups-epilog and its parameters

    export DEVICE_URI="epilog://$EPILOG_IP/Legend/rp=100/rs=20/rm=grey/vp=100/vs=20/vf=500"

- rp: raster power (engraving)
- rs: raster speed
- rm: raster color
- vp: vector power (cutting)
- vs: vector speed
- vf: vector frequency

### Printing

- From inkscape, export the SVG file to eps

        Save a copy -> eps -> ...

- Send the file to the printer:

        cups-epilog/epilog 123 user jobname < file.eps

- Put the sheet on the laser cutter, with its lower left corner on the
  upper limit of the 12 mark.

- Launch a dry run

  Turn on the laser pointer on, leave the bay open, no blower, press Go.

  No need to calibrate. You may want to edit the parameters to set the
  vector and raster speed to 100%.

- Launch a full run

  Turn off the laser pointer, turn on the blower, close the bay, press Go.

  The job can be paused / restarted at anytime.

## TODO: tips and tricks to produce documents from inkscape

## TODO: tips and tricks to print on slices of wood

## Materials

### Contreplaqué 4mm (Bricomarché)

export DEVICE_URI="epilog://$EPILOG_IP/Legend/rp=100/rs=20/vp=100/vs=20/vf=500/rm=grey"

fentes: 3.4 mm
