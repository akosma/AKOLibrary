//
//  AKOLibrary_Foundation_functions.h
//  AKOLibrary
//
//  Created by Adrian on 4/15/11.
//  Copyright (c) 2009, 2010, 2011, Adrian Kosmaczewski & akosma software
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, 
//  are permitted provided that the following conditions are met:
//  
//  Redistributions of source code must retain the above copyright notice, this list 
//  of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this 
//  list of conditions and the following disclaimer in the documentation and/or 
//  other materials provided with the distribution.
//  Neither the name of the akosma software nor the names of its contributors may be 
//  used to endorse or promote products derived from this software without specific 
//  prior written permission.
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

#import <Foundation/Foundation.h>

/**
 @file AKOLibrary_Foundation_functions.h
 Helper global functions dealing with Foundation classes and utilities.
 */


#undef NSLocalizedString
#define NSLocalizedString(key, comment) AKOLocalizedString(key, comment)

/**
 Drop-in replacement for NSLocalizedString.
 Overrides the current implementation of NSLocalizedString
 so that strings are loaded automatically when the user 
 changes the current language in the application.
 @param key The key of the string in the .strings file.
 @param comment The comment corresponding to the localized string.
 @return A localized string stored in a .strings file.
 */
NSString *AKOLocalizedString(NSString *key, NSString *comment);

/**
 The "supportedLanguages" parameter should be of the form
 @param supportedLanguages A set of NSString instances, specifying 
 all the languages currently supported in the current application.
 @return The current system language of the current device.
 */
NSString *AKOCurrentSystemLanguage(NSSet *supportedLanguages);

/**
 Returns the current version number of the application.
 @return An NSString with the current version of the application,
 as defined in the local info.plist file of the current bundle.
 */
NSString *AKOCurrentVersionNumber();
