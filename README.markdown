AKOLibrary
==========

- Author: Adrian Kosmaczewski
- Date: March 4th, 2012

This library exposes functionality and classes used in many applications
developed by akosma software.

Build
-----

These instructions explain how to build the project in Xcode 4.

### Install Xcode

Install the iPhone developer tools for iOS 4.3. This builds successfully
with Xcode 4.0.2 and later. This project does not build with older
versions of Xcode, because the source code uses the automatic ivar
generation feature of LLVM.

### Install Doxygen

Install [Doxygen](http://doxygen.org/) using
[Homebrew](http://mxcl.github.com/homebrew/): `brew install doxygen`

### Build binaries and documentation

Open the AKOLibrary.xcodeproj file with Xcode 4.0.2, select the
"Universal_Framework | iOS Device" scheme, and select the "Product /
Build" menu entry. The solution should compile without problems.

Documentation
-------------

To generate the documentation, make sure that Doxygen 1.7.2 or later
(<http://www.stack.nl/~dimitri/doxygen/>) is installed; type "doc.sh" in
the root folder of the project.

### Note about PDF output with Doxygen

If you want to create a PDF output using Doxygen, you should install
first the MacTex distribution, freely available from
<http://www.tug.org/mactex/>

Download the disk image file from
<http://mirror.ctan.org/systems/mac/mactex/MacTeX.dmg>

Open the image file and execute the installer inside. This will install
all the  required tools to generate PDF files from the Doxygen
documentation.

### Tests

The AKOLibrary is bundled with a large suite of tests. 

To run the tests, select the `"Universal_Framework | iOS Device"`
scheme, and select  the "Product / Test" menu entry. This will launch
the iPhone Simulator app, and then run the tests.

To see the test results, open the console in Xcode 4.

Extending the Library
---------------------

To add more functionality in the AKOLibrary, follow these steps:

- Add a new folder with classes in the AKOLibrary group.
- Alternatively, you can add or create new classes in a pre-existing
  group or folder.
- Add any new files to the "AKOLibrary" target.
- Build using the `"Universal_Framework"` scheme and make sure
  everything works.
- Run the tests.
- Add a new header file for the group (if required), similar to the
  files `"AKOLibrary_Video.h"`.
- Add the new header file for the group in the AKOLibrary.h file.
- Select the project icon, select the AKOLibrary target, and in the
  "Build Phases" tab add the required frameworks to the project ("Link
  Binary with Libraries"). Also, make any new header files publicly
  visible in the same pane ("Copy Headers").
- Select the `"Product / Archive"` menu.
- When the compilation is ready, open the "Products" group and
  right-click on the AKOLibrary.framework product. Select `"Show in
  Finder"`.
- In the window that appears, go back a few levels in the folder
  hierarchy and select the folder `"ArchiveIntermediates /
  Universal_Framework / BuildProductsPath / Release-universal"`. In that
  folder you will find the freshly created AKOLibrary.framework bundle.

Using the Library
-----------------

To use the library in a project, follow these steps:

- Import the AKOLibrary.framework bundle in your app. Choose to
  explicitly copy it into the project.
- Select the project icon, select the main target and select the "Build
  Phases" tab. Add the following frameworks in your project: MapKit,
  MediaPlayer, AudioToolbox, CoreData, CoreGraphics, CoreText,
  Foundation, QuartzCore, SystemConfiguration, UIKit, CFNetwork. 
- In the "Build Settings" tab, select the "Other Linker Flags" entry and
  add the `"-all_load"` flag.
- In your source files, use the `#import <AKOLibrary/AKOLibrary.h>`
  header.

