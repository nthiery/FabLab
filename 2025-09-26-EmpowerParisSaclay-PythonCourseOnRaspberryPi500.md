# 

These are notes taken at Empower Paris-Saclay 2025, while
experimenting with using the FabLab's collection of Raspberry Pi to
run an introductory programming workshop.

## Hardware

- 10 Raspberrypi 400 embedded in keyboard
- 10 15" Rapsberry screens

These were new out of the box, provided with adequate cables and
mouse.

## Setup

Run through the first-boot wizard:
1.  Leave localization information to their default setting (french/paris/azerty).
2.  Create an account with username `pi` and password `pi`. Ignore the warning.
3.  Skip screen configuration (not needed)
4.  Setup network: SSID: `Empower UPSAY` password: `UPSAY+2025`
5.  Time synchronization fails; certificates are outdated
6.  Skip software updates (fails due to wrong time)
7.  Restart
8.  Set the date from a terminal:
    ```
	sudo date -s "2025-09-27 13:01"
	```
9.  Run the setup script below to prepare the machine, and download
    and install the course material and required software.

    To deploy easily on many machines, I had uploaded the script on my
    website, so that I could just do:
    ```
    curl http://Nicolas.Thiery.name/install-raspberry | bash
	```

## Storage

The 10 raspberry pi have been repacked to minimize future use: the
screen and keyboard (and book and sd adapter) are stored together in
the screen's box, with all cables connected.

## Future usage

The course material is installed in
~pi/IntroductionProgrammationPython. To use it:

```
cd ~/IntroductionProgrammationPython
uv run jupyter lab index.md
```

If the same machine is reused by several students, you probably want
to reset the course material by running the following commands:

```
cd ~/IntroductionProgrammationPython
git checkout -- .                   # Reset all changes from the previous student
git pull                            # Get the latest version
```

## Remaining issues

### How to enable automatic time synchronization?

Romain encountered that problem on another occasion. He could know how
to solve it.

### Can't use Jupyterlite websites

One of the means to access the training material is to access a
JupiterLite deployment (static web site, with javascript to run
jupyter directly into the browser). It failed with the deployment we
had prepared, with this message in the browser's console:

Aborted (RangeError: WebAssembly.instantiate): Out of Memory: Cannot
allocate Wasm memory for new answer.

This is with the Chrome web browser.

Plain jupyterlite using pyodide (e.g. from jupyter.org/try-jupyter/)
worked.

JupyterLite-xeus fails: RangeError: WebAssembly.Compile is disallowed
on the main thread, if the buffer size is larger than 4KB. Use
WebAssembly.compile, or compile on a worker thread.

This was reported to the devs: https://github.com/jupyterlite/xeus/issues/283

### Can't (easily) install vtk / pyvista

Context: pyvista is used by one of the worksheets to illustrate
constructive solid geometry in Python, e.g. to produce objects to
3D-print.

## Conclusion

It took about 6 hours to get a fully functional setup on 10
machines. Now that the procedure is defined, it probably would take
around 2 hours to setup 10 more machine.

- Working on the course material online with mydocker worked. It
  requires requires an academic account (Renater), or to use
  mydocker's facility to create temporary accounts on the fly tied to
  an email address which is functional but not yet as handy as
  desirable.
- Working on the course material locally worked
- Working on the course material through JupyterLite failed

## Installation script

```
#!/bin/bash

echo Correctif de la date:

sudo timedatectl set-ntp true   # Not sure this is changing anything

echo "Update certificates and install GitLab@UPSaclay's certificate which is not recognized."

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install gnutls-bin

gnutls-cli --print-cert gitlab.dsi.universite-paris-saclay.fr </dev/null| sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > gitlab.dsi.universite-paris-saclay.fr.crt
sudo cp gitlab.dsi.universite-paris-saclay.fr.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

echo "Installation de uv:"

curl -LsSf https://astral.sh/uv/install.sh | sh

PATH=$PATH:$HOME/.local/bin

echo "Installation de libffi, libjpeg-dev, nodejs, npm requises pour (re)compiler certains package comme learning-traces-extension ou pillow)"

sudo apt install -y libffi-dev libjpeg-dev nodejs npm
sudo apt autoremove -y

echo "Installation de l'environnement:"

git clone https://gitlab.dsi.universite-paris-saclay.fr/IntroductionProgrammationPython/2025-09.git IntroductionProgrammationPython
cd IntroductionProgrammationPython
uv remove pyvista trame
uv remove jupylates --group dev
uv remove jupylates --group book
uv sync

echo "Ouverture des ressources pédagogiques:"

uv run jupyter lab index.md
```
