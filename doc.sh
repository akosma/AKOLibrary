#!/usr/bin/env sh

# Some information before the script starts
echo =========================================================
echo DOXYGEN STARTED
echo This script builds the documentation items.
echo =========================================================
echo 
echo 

# Build the documentation using Doxygen (on the command line)
# First remove any previous existing documentation
rm -r Documentation

# Generate the documentation
# (this assumes that the Doxygen app is installed 
# in the Applications folder in the Mac)
/Applications/Doxygen.app/Contents/Resources/doxygen

# Generate the PDF file from the LaTeX documentation
cd Documentation/latex
make
cd ../

# Generate the Xcode docset from the HTML documentation
cd html
make
make install
cd ../

# Copy the man pages to their location
# (this requires super user privileges, so you might
# want to run this script with sudo)
cd man/man3
cp * /usr/share/man/man3
cd ../../

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

