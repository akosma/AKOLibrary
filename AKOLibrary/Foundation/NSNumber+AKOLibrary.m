//
//  NSNumber+AKOLibrary.m
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

#import "NSNumber+AKOLibrary.h"
#import "AKOPreferencesManager.h"

@implementation NSNumber (AKOLibrary)

- (NSString *)ako_stringFormattedAsCurrency
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setDecimalSeparator:@","];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setUsesGroupingSeparator:TRUE];
    [numberFormatter setGroupingSeparator:@"."];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setMinimumIntegerDigits:1];

    return [numberFormatter stringFromNumber:self];
}

- (NSString *)ako_stringFormattedAsLocalCurrency
{
    NSString *language = [AKOPreferencesManager sharedAKOPreferencesManager].language;
    NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:language] autorelease];
    
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setLocale:locale];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [numberFormatter stringFromNumber:self];
}

- (NSString *)ako_stringFormattedAsRoundedInteger
{
    NSInteger value = [self intValue];
    NSInteger thousands = value / 1000;
    return [NSString stringWithFormat:@"%d", thousands * 1000];
}

- (NSString *)ako_stringWithLocalizedYesNo
{
    BOOL ok = [self boolValue];
    NSString *yes = NSLocalizedString(@"YES", @"Localized version of 'yes'");
    NSString *no = NSLocalizedString(@"NO", @"Localized version of 'no'");
    return (ok) ? yes : no;
}

@end
