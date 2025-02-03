Changeloc

Tool for the comparison of localisation predictions for different gene isoforms

Prerequisites:
Docker
Nextflow

Installation:
Download the source code and place in a directory of your choice.
Download the linux versions of Signalp6, TargetP2 and Deeploc2 and place them in the "Licensed_packages" folder in the root directory.
Navigate to the home directory and run "sudo ./dockerbuild" in order to build and pull necessary docker images. 
The installation is now complete

Usage:


Abbreviations

Wolfpsort uses the following abbreviations, Changeloc uses these as well as a few extra. 
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
othr - other (or not classified by a particular software usually !mito or !sgnl)
sgnl - signal peptide detected
    can include(sgnl, golg, E.R., lyso, plas, extr)