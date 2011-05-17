//
//  NSNumber+AKOLibrary.h
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
 @file NSNumber+AKOLibrary.h
 Contains a category on NSNumber with helper methods.
 */

#import <Foundation/Foundation.h>

/**
 @category NSNumber(AKOLibrary)
 Extends the NSNumber category with some helper methods.
 */
@interface NSNumber(AKOLibrary)

/**
 Specifies whether the current instance was created from a boolean or not.
 @return A BOOL value.
 */
- (BOOL)ako_generatedFromBoolean;

/**
 Specifies whether the current instance was created from an integer or not.
 @return A BOOL value.
 */
- (BOOL)ako_generatedFromInteger;

/**
 Specifies whether the current instance was created from a double or not.
 @return A BOOL value.
 */
- (BOOL)ako_generatedFromDouble;

/**
 Specifies whether the current instance was created from a float or not.
 @return A BOOL value.
 */
- (BOOL)ako_generatedFromFloat;

/**
 Returns a string formatted as currency, using the current locale.
 This method only works with NSNumber instances build from float or double values.
 @return An NSString instance.
 */
- (NSString *)ako_stringFormattedAsLocalCurrency;

/**
 Returns a string manually converted into a currency format.
 This method does not use the current locale. A number like
 "45134.5387" would get transformed in a string 
 as follows: "45.134,54". This method only works with
 NSNumber instances build from float or double values.
 @return An NSString instance representing the current number.
 */
- (NSString *)ako_stringFormattedAsCurrency;

/**
 Rounds the integer stored in this instance and returns it as string.
 This method only works with NSNumber instances build from integer values.
 @return An NSString instance representing a rounded version of the current number.
 */
- (NSString *)ako_stringFormattedAsRoundedInteger;

/**
 Returns a string representing the current boolean value of this instance.
 This method only works if the current instance has been created with a boolean value.
 @return An NSString instance with the "YES" or "NO" value.
 */
- (NSString *)ako_stringWithLocalizedYesNo;

@end
