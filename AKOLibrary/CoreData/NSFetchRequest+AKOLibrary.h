//
//  NSFetchRequest+AKOLibrary.h
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
 @file NSFetchRequest+AKOLibrary.h
 Contains a category on NSFetchRequest.
 */

#import <CoreData/CoreData.h>

/** 
 @category NSFetchRequest(AKOLibrary) 
 A category on NSFetchRequest
 */
@interface NSFetchRequest(AKOLibrary)

/**
 Sorts the current fetch request using the keys specified as parameter.
 This method adds the keys specified as parameter as NSSortDescriptors
 in the current instance, using the sort order specified in the first
 parameter.
 @param ascending A boolean specifying whether to sort ascending (YES) 
 or descending (NO).
 @param firstKey A nil-terminated list of string keys specifying 
 the fields to sort by.
 */
- (void)ako_sortAscending:(BOOL)ascending withKeys:(NSString *)firstKey, ...;

@end
