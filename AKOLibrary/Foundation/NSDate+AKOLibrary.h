//
//  NSDate+AKOLibrary.h
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
 @file NSDate+AKOLibrary.h
 Contains a category on NSDate with helper methods.
 */

#import <Foundation/Foundation.h>

/**
 @category NSDate(AKOLibrary)
 Extends the NSDate class with helper methods.
 */
@interface NSDate(AKOLibrary)

/**
 Returns a random date between the present moment and 1970.
 @return An NSDate instance representing a date between today and 1970.
 */
+ (NSDate *)ako_randomDateBetween1970AndNow;

/**
 Returns a random date between the present moment and 2001.
 @return An NSDate instance representing a date between today and 2001.
 */
+ (NSDate *)ako_randomDateBetween2001AndNow;

/**
 Returns a string that represents the current date using the current locale.
 This method returns a string that does only contain date information, 
 without any time information.
 @return An NSString instance.
 */
- (NSString *)ako_dateString;

/**
 Returns a string that represents the current date and time using the current locale.
 This method returns a string that contains date and time information.
 @return An NSString instance.
 */
- (NSString *)ako_dateTimeString;

/**
 Returns a string that represents the current weekday.
 This method returns strings of the form WEEKDAY_%d, where the integer pattern
 goes from 1 (Sunday) to 7 (Saturday). Clients of this class might want to
 localize these values in their specific languages before displaying them
 to the user.
 @return An NSString instance.
 */
- (NSString *)ako_weekday;

@end
