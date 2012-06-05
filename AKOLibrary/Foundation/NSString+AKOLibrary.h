//
//  NSString+AKOLibrary.h
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

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

/**
 @file NSString+AKOLibrary.h
 Contains several extensions to the NSString class.
 */

/**
 @category NSString(AKOLibrary)
 Set of extension methods on the NSString class.
 */
@interface NSString(AKOLibrary)

/**
 Creates a random string of the specified length.
 The string created by this method mixes uppercase and lowercase parameters,
 as well as numbers, spaces and other symbols.
 @param length The length of the required random string.
 @return An NSString object.
 */
+ (NSString *)ako_randomStringOfLength:(NSInteger)length;

/**
 Returns a random string of random length.
 The random string returned by this method has between 5 and 16 characters.
 @return A random NSString object.
 */
+ (NSString *)ako_randomString;

/**
 Returns a string that contains the text of a file located in the current bundle.
 @param bundleFileName The filename of the text file in the resources.
 @return An NSString with the contents of the file.
 */
+ (NSString *)ako_stringFromResourceNamed:(NSString *)bundleFileName;

/**
 Returns a string that contains the text of a file located in the file system.
 @param path The filename of the text file in the local file system.
 @return An NSString with the contents of the file.
 */
+ (NSString *)ako_stringFromFileAtPath:(NSString *)path;

/**
 Returns a string with the SHA hash of the current instance.
 @return An NSString instance.
 */
- (NSString *)ako_SHADigest;

/**
 Returns a string with the MD5 hash of the current instance.
 @return An NSString instance.
 */
- (NSString *)ako_MD5Digest;

/**
 Returns a string with the first letter capitalized.
 The rest of the string remains unchanged.
 @return A capitalized NSString intance.
 */
- (NSString *)ako_stringWithFirstLetterCapitalized;

/**
 Returns the NSDate that corresponds to the current string.
 @param format The format to be used during formatting.
 @return An NSDate object.
 */
- (NSDate *)ako_dateWithFormat:(NSString *)format;

/**
 Returns the URL-encoded version of the current instance.
 @return An URL-encoded string.
 */
- (NSString *)ako_URLEncode;

/**
 Performs a URL-decoding version of the current instance.
 @return A string without URL encoding.
 */
- (NSString *)ako_URLDecode;

/**
 Removes all XML and HTML tags from the current instance.
 @return A string without XML or HTML tasg
 */
- (NSString *)ako_stringByStrippingHTML;

@end
