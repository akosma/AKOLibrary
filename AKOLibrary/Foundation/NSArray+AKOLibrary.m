//
//  NSArray+AKOLibrary.m
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

#import "NSArray+AKOLibrary.h"


@implementation NSArray(AKOLibrary)

- (id)ako_randomObject
{
    id result = nil;
    NSInteger count = [self count];
    if (count > 0)
    {
        NSInteger index = arc4random() % [self count];
        result = [self objectAtIndex:index];
    }
    return result;
}

- (NSString *)ako_formatAsCSV
{
    NSMutableString *text = [NSMutableString string];
    BOOL headerDone = NO;
    for (NSDictionary *dict in self)
    {
        if (!headerDone)
        {
            headerDone = YES;
            for (NSString *key in dict)
            {
                [text appendFormat:@"%@, ", key];
            }            
            [text appendString:@"\n"];
        }
        for (NSString *key in dict)
        {
            id value = [dict objectForKey:key];
            [text appendFormat:@"%@, ", [value description]];
        }
        [text appendString:@"\n"];
    }
    return text;
}

@end
