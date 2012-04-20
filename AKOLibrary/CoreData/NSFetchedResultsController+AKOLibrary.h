//
//  NSFetchedResultsController+AKOLibrary.h
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

#import <CoreData/CoreData.h>

/** 
 @category NSFetchedResultsController(AKOLibrary) 
 A category on NSFetchedResultsController
 */
@interface NSFetchedResultsController (AKOLibrary)

/**
 Returns the next NSIndexPath.
 This method returns the next object to be displayed in a table view that
 uses the current fetched results controller as data source. It is the
 equivalent of incrementing the NSIndexPath by one unit, which might mean
 incrementing the section if required. This method returns nil if the parameter
 represents the last object on the current results controller.
 @param oldIndexPath The index path to increment.
 @return An NSIndexPath object, or nil if the parameter represented 
 the last index path.
 */
- (NSIndexPath *)ako_incrementIndexPath:(NSIndexPath *)oldIndexPath;

/**
 Returns the previous NSIndexPath.
 This method returns the prevoius object to be displayed in a table view that
 uses the current fetched results controller as data source. It is the
 equivalent of decrementing the NSIndexPath by one unit, which might mean
 decrementing the section if required. This method returns nil if the parameter
 represents the first object on the current results controller.
 @param oldIndexPath The index path to decrement.
 @return An NSIndexPath object, or nil if the parameter represented 
 the first index path.
 */
- (NSIndexPath *)ako_decrementIndexPath:(NSIndexPath *)oldIndexPath;

@end
