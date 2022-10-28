MEDIA=/media/nthiery/FABLAB/
DIR=DelaetThieryBlouses/
VERSION=1.3
PREFIX=$(MEDIA)$(DIR)V$(VERSION)

install-old:
	inkscape --without-gui --export-area-page --export-id-only --export-id=layer7 BlouseV$(VERSION).svg --export-pdf=$(PREFIX)-manche.pdf
	inkscape --without-gui --export-area-page --export-id-only --export-id=layer5 BlouseV$(VERSION).svg --export-pdf=$(PREFIX)-corps-bas.pdf
	inkscape --without-gui --export-area-page --export-id-only --export-id=layer11 BlouseV$(VERSION).svg --export-pdf=$(PREFIX)-corps-haut.pdf
	inkscape --without-gui --export-area-page --export-id-only --export-id=layer11 BlouseV$(VERSION).svg --export-pdf=$(PREFIX)-biais.pdf
	#umount $(MEDIA)

install:
	@echo Afficher le calque Découpe manche; read foo
	inkscape --without-gui BlouseV$(VERSION).svg --export-plain-svg=$(PREFIX)-manche.svg
	@echo Afficher le calque Découpe corps bas; read foo
	inkscape --without-gui BlouseV$(VERSION).svg --export-plain-svg=$(PREFIX)-corps-bas.svg
	@echo Afficher le calque Découpe corps haut; read foo
	inkscape --without-gui BlouseV$(VERSION).svg --export-plain-svg=$(PREFIX)-corps-haut.svg
	@echo Afficher le calque Découpe biais; read foo
	inkscape --without-gui BlouseV$(VERSION).svg --export-plain-svg=$(PREFIX)-biais.svg
	@echo Démontage clé USB
	#umount $(MEDIA)
