Changeloc

Tool for the comparison of localisation predictions for different gene isoforms

Prerequisites:
Docker
Nextflow

Installation:
Download the source code and place in a directory of your choice.
Download the linux versions of:

Signalp6 (fast) https://services.healthtech.dtu.dk/services/SignalP-6.0/
TargetP2        https://services.healthtech.dtu.dk/services/TargetP-2.0/
Deeploc2        https://services.healthtech.dtu.dk/services/DeepLoc-2.1/
TMHMM2.0        https://services.healthtech.dtu.dk/services/TMHMM-2.0/

and place the .tar.gz files in the "Licensed_packages" folder in the changeloc root directory.

Navigate to the home directory and run "sudo ./dockerbuild" in order to build and pull necessary docker images. 
The installation is now complete

Usage:



Abbreviations:

WoLFPsort uses the following abbreviations, Changeloc uses these as well as a few extra. 
plas, mito, E.R. nucl, cyto, pero, extr, cysk, golg, lyso

changeloc:
plas - plasma membrane
nucl - nucleus
cyto - cytoplasm
extr - extracellular/secreted
chlr - chloroplast
golg - golgi apparatus
E.R. - Endoplasmic reticulum
lyso - lysosome/vacuole
pero - peroxisome
cysk - cytoskeleton
mito - mitochondrion
memb - any cellular membrane (only used in the case of TMHMM2.0 assuming a transmembrane helical domain means it localises to a membrane)
othr - other (or not classified by a particular software usually !mito or !sgnl)
sgnl - signal peptide detected
    can include(golg, E.R., lyso, plas, extr, memb)

