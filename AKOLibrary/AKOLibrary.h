//
//  AKOLibrary.h
//  AKOLibrary
//
//  Created by Adrian on 4/15/11.
//  Copyright (c) 2009, 2010, 2011, Adrian Kosmaczewski & akosma software
//  All rights reserved.
//  
//  Use in source and/or binary forms without modification is permitted following the
//  instructions in the LICENSE file.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
//  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
//  OF THE POSSIBILITY OF SUCH DAMAGE.
//

/**
 @file AKOLibrary.h
 Main header file of the AKOLibrary.
 Use this header file to insert the symbols of the AKOLibrary
 in your own application.
 */

#import "AKOLibrary_Foundation.h"
#import "AKOLibrary_CoreData.h"
#import "AKOLibrary_CoreText.h"
#import "AKOLibrary_QuartzCore.h"
#import "AKOLibrary_UIKit.h"
#import "AKOLibrary_Managers.h"

/**
 @mainpage AKOLibrary

 @author Adrian Kosmaczewski
 @date May 16th, 2011

 This library exposes functionality and classes used in many applications
 Developed by akosma software.

 @section main_index Index

 More information can be found in the following pages:

 @li @subpage pageBuild "Build"
 @li @subpage pageDocumentation "Documentation"
 @li @subpage pageTests "Tests"
 */

/**
 @page pageBuild Build

 These instructions explain how to build the project in Xcode 4.
 
 @section sec_1 Install Xcode
 
 Install the iPhone developer tools for iOS 4.3. This builds successfully with 
 Xcode 4.0.2 and later. This project does not build with older versions of Xcode, 
 because the source code uses the automatic ivar generation feature of LLVM.
 
 @section sec_2 Install Doxygen
 
 Download Doxygen from the website http://doxygen.org/ and install it in 
 the "Applications" folder.
 
 @section sec_3 Build binaries and documentation
 
 Open the AKOLibrary.xcodeproj file with Xcode 4.0.2, select the
 "Universal_Framework | iOS Device" scheme, and select the "Product / Build"
 menu entry. The solution should compile without problems.
 */

/**
 @page pageDocumentation Documentation

 To generate the documentation, make sure that Doxygen 1.7.2 or later
 (http://www.stack.nl/~dimitri/doxygen/) is installed; type "doc.sh" in the root folder
 of the project.

 @section sec_1 Note about PDF output with Doxygen
 
 If you want to create a PDF output using Doxygen, you should install first 
 the MacTex distribution, freely available from
 http://www.tug.org/mactex/
 
 Download the disk image file from
 http://mirror.ctan.org/systems/mac/mactex/MacTeX.dmg
 
 Open the image file and execute the installer inside. This will install all the  
 required tools to generate PDF files from the Doxygen documentation.
 */

/**
 @page pageTests Tests
 
 The AKOLibrary is bundled with a large suite of tests. 
 
 To run the tests, select the "Universal_Framework | iOS Device" scheme, 
 and select  the "Product / Test" menu entry. This will launch the
 iPhone Simulator app, and then run the tests.
 
 To see the test results, open the console in Xcode 4.
 */
