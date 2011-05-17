//
//  NSFetchRequest+AKOLibrary.m
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

#import "NSFetchRequest+AKOLibrary.h"

@implementation NSFetchRequest(AKOLibrary)

- (void)ako_sortAscending:(BOOL)ascending withKeys:(NSString *)firstKey, ...
{
    NSMutableArray *sortDescriptors = [[self sortDescriptors] mutableCopy];
    if (sortDescriptors == nil)
    {
        sortDescriptors = [NSMutableArray array];
    }
    
    va_list argumentList;
    if (firstKey)
    {
        NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:firstKey 
                                                                        ascending:ascending] autorelease];
        [sortDescriptors addObject:sortDescriptor];
        
        va_start(argumentList, firstKey);
        id key = nil;
        while ((key = va_arg(argumentList, id)))
        {
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:key 
                                                                            ascending:ascending] autorelease];
            [sortDescriptors addObject:sortDescriptor];
        }
        va_end(argumentList);
    }
    
    if ([sortDescriptors count] > 0)
    {
        [self setSortDescriptors:sortDescriptors];
    }
}

@end
