#!/usr/bin/env sh

# Some information before the script starts
echo =========================================================
echo DOXYGEN STARTED
echo This script builds the documentation items.
echo =========================================================
echo 
echo 

# Build the documentation using Doxygen (on the command line)
cd AKOLibrary

# Remove any previous existing documentation
rm -r Documentation

cd ..

# Generate the documentation
# (this assumes that the Doxygen app is installed 
# in the Applications folder in the Mac)
/Applications/Doxygen.app/Contents/Resources/doxygen

# Generate the PDF file from the LaTeX documentation
cd AKOLibrary/Documentation/latex
make
cd ../../

# Generate the Xcode docset from the HTML documentation
cd Documentation/html
make
make install
cd ../../../

# Information about what happened
echo 
echo 
echo =========================================================
echo BUILD FINISHED
echo Now you can find the generated applications in the "build"
echo subfolder.
echo You can also open the following documentation files:
echo - Documentation/latex/refman.pdf
echo - Documentation/html/index.html
echo - Documentation/html/ch.swissinfo.iPad.docset - to be opened with Xcode
echo - Documentation/rtf/refman.rtf
echo =========================================================

