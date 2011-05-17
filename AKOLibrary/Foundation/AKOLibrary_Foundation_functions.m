//
//  AKOLibrary_Foundation_functions.m
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

#include "AKOLibrary_Foundation_functions.h"

NSString *AKOLocalizedString(NSString *key, NSString *comment)
{
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *locale = [languages objectAtIndex:0];
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"Localizable" 
                                                             ofType:@"strings"
                                                        inDirectory:nil
                                                    forLocalization:locale];
    NSString *path = [resourcePath stringByDeletingLastPathComponent];
    NSBundle *currentResource = [NSBundle bundleWithPath:path];
    NSString *result = NSLocalizedStringFromTableInBundle(key, nil, currentResource, nil);
    if (result == nil)
    {
        result = key;
    }
    return result;
}

NSString *AKOCurrentSystemLanguage(NSSet *supportedLanguages)
{
    // This code is adapted from
    // http://www.schmidp.com/2010/01/11/how-to-get-the-current-iphone-language-code/

    NSArray *arr = [NSLocale preferredLanguages];
    NSString *lang = [arr objectAtIndex:0];
    
    // Whichever version of Chinese is available in the system,
    // use the simplified version.
    if ([lang isEqualToString:@"zh-Hant"] || [lang isEqualToString:@"zh-Hans"])
    {
        lang = @"zh_CN";
    }
    
    // If the system uses a language not yet available in the application,
    // fallback to English as the default choice.
    if (![supportedLanguages containsObject:lang])
    {
        lang = @"en";
    }
    
    return lang;
}

inline NSString *AKOCurrentVersionNumber()
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
