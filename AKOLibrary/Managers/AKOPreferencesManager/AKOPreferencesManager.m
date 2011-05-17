//
//  AKOPreferencesManager.m
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

#import "AKOPreferencesManager.h"
#import "AKOLibrary_Foundation_functions.h"
#import "SynthesizeSingleton.h"

NSString * const AKOPreferencesLanguageKey = @"AKOPreferencesLanguageKey";

@implementation AKOPreferencesManager

SYNTHESIZE_SINGLETON_FOR_CLASS(AKOPreferencesManager);

@synthesize userDefaults = _userDefaults;
@dynamic language;

- (id)init
{
    self = [super init];
    if (self)
    {
        _userDefaults = [NSUserDefaults standardUserDefaults];

        NSArray *versions = [self currentAndPastVersions];
        for (NSString *version in versions)
        {
            [self initializePreferencesForVersion:version];
        }
    }
    return self;
}

- (void)dealloc
{
    _userDefaults = nil;
    [super dealloc];
}

#pragma mark - Methods to override

- (NSArray *)currentAndPastVersions
{
    return nil;
}

- (void)initializePreferencesForVersion:(NSString *)version
{
}

#pragma mark - Dynamic setters and getters

- (NSString *)language
{
    NSString *lang = [self.userDefaults stringForKey:AKOPreferencesLanguageKey];
    if ([lang length] > 2)
    {
        // In the case of Chinese, the code returned is "zh_CN", and
        // the JSON feeds only specify "zh". To make the match when
        // filtering stories in the Core Data model, we use the short version.
        lang = [lang substringWithRange:NSMakeRange(0, 2)];
    }
    return lang;
}

- (void)setLanguage:(NSString *)newLanguage
{
    if (newLanguage == nil || [newLanguage length] == 0)
    {
        [self.userDefaults setObject:nil forKey:@"AppleLanguages"];
        newLanguage = AKOCurrentSystemLanguage([NSSet setWithObject:@"en"]);
    }
    
    NSArray *array = [NSArray arrayWithObject:newLanguage];
    [self.userDefaults setObject:array forKey:@"AppleLanguages"];
    [self.userDefaults setObject:newLanguage forKey:AKOPreferencesLanguageKey];
    [self.userDefaults synchronize];
}

@end
