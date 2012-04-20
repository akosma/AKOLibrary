//
//  NSFetchedResultsController+AKOLibrary.m
//  AKOLibrary
//
//  Created by Adrian Kosmaczewski on 4/10/12.
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

#import "NSFetchedResultsController+AKOLibrary.h"

@implementation NSFetchedResultsController (AKOLibrary)

- (NSIndexPath *)ako_incrementIndexPath:(NSIndexPath *)oldIndexPath
{
    NSIndexPath *nextIndexPath = nil;

    id <NSFetchedResultsSectionInfo> sectionInfo = [[self sections] objectAtIndex:oldIndexPath.section];
    NSInteger rowCount = [sectionInfo numberOfObjects];

    NSInteger nextRow = oldIndexPath.row + 1;
    NSInteger currentSection = oldIndexPath.section;
    if (nextRow < rowCount)
    {
        nextIndexPath = [NSIndexPath indexPathForRow:nextRow inSection:currentSection];
    }
    else
    {
        NSInteger sectionCount = [[self sections] count];
        NSInteger nextSection = currentSection + 1;
        if (nextSection < sectionCount)
        {
            nextIndexPath = [NSIndexPath indexPathForRow:0 inSection:nextSection];
        }
    }
    
    return nextIndexPath;
}

- (NSIndexPath *)ako_decrementIndexPath:(NSIndexPath *)oldIndexPath
{
    NSIndexPath *previousIndexPath = nil;
        
    NSInteger nextRow = oldIndexPath.row - 1;
    NSInteger currentSection = oldIndexPath.section;
    if (nextRow >= 0)
    {
        previousIndexPath = [NSIndexPath indexPathForRow:nextRow inSection:currentSection];
    }
    else
    {
        NSInteger nextSection = currentSection - 1;
        if (nextSection >= 0)
        {
            previousIndexPath = [NSIndexPath indexPathForRow:0 inSection:nextSection];
        }
    }
    
    return previousIndexPath;
}

@end
