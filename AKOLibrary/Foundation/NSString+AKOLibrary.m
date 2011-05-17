//
//  NSString+AKOLibrary.m
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

#import "NSString+AKOLibrary.h"

@implementation NSString (AKOLibrary)

+ (NSString *)ako_randomStringOfLength:(int)length
{
    // Adapted from 
    // http://stackoverflow.com/questions/2633801/generate-a-random-alphanumeric-string-in-cocoa
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    static char *letters = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789-";
    unsigned long len = strlen(letters);
    
    for (int i = 0; i < length; i++) 
    {
        NSInteger index = arc4random() % len;
        [randomString appendFormat:@"%c", letters[index]];
    }
    return randomString;
}

+ (NSString *)ako_randomString
{
    NSInteger length = (arc4random() % 12) + 5;
    return [[self class] ako_randomStringOfLength:length];
}

+ (NSString *)ako_stringFromFileNamed:(NSString *)bundleFileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:bundleFileName ofType:nil];
    NSString *text = [NSString stringWithContentsOfFile:path
                                               encoding:NSUTF8StringEncoding
                                                  error:nil];
    return text;
}

- (NSString *)ako_SHADigest
{
    // Adapted from
    // http://spitzkoff.com/craig/?p=122
    
    NSData *data = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; ++i)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSDate *)ako_dateWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:format];
    return [formatter dateFromString:self];
}

- (NSString *)ako_stringWithFirstLetterCapitalized
{
    // Adapted from
    // http://stackoverflow.com/questions/2432452/how-to-capitalize-the-first-word-of-the-sentece-in-objective-c
    NSString *result = nil;
    if ([self length] > 0)
    {
        NSString *capitalized = [[self substringToIndex:1] uppercaseString];
        result = [self stringByReplacingCharactersInRange:NSMakeRange(0,1) 
                                               withString:capitalized];
    }
    return result;
}

- (NSString *)ako_MD5Digest
{
    // Adapted from
    // http://discussions.apple.com/thread.jspa?messageID=7362074

	const char *cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cStr, strlen(cStr), result);
	NSString *md5 = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                     result[0], result[1],
                     result[2], result[3],
                     result[4], result[5],
                     result[6], result[7],
                     result[8], result[9],
                     result[10], result[11],
                     result[12], result[13],
                     result[14], result[15]];
    return [md5 lowercaseString];
}

- (NSString *)ako_URLEncode
{
    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
                                                                  (CFStringRef)self,
                                                                  NULL, 
                                                                  CFSTR(";/?:@&=+$,"), 
                                                                  kCFStringEncodingUTF8);
    return [(NSString *)encoded autorelease];
}

- (NSString *)ako_URLDecode
{
    CFStringRef cleanString = CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, 
                                                                         (CFStringRef)self, 
                                                                         CFSTR(""));
    return [(NSString *)cleanString autorelease];
}

@end
