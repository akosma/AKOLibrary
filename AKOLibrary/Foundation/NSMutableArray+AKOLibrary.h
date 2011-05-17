//
//  NSMutableArray+AKOLibrary.h
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
 @file NSMutableArray+AKOLibrary.h
 Contains a category on NSMutableArray with helper functions.
 */

#import <Foundation/Foundation.h>

/**
 @category NSMutableArray(AKOLibrary)
 Extends the NSMutableArray class with helper methods.
 This category in particular adds extensions that help using
 such an instance as if it were a stack, with its corresponding
 push and pop methods.
 */
@interface NSMutableArray(AKOLibrary)

/**
 Pushes an object on top of the current instance.
 This method is the equivalent of the "push" method, and uses
 the current instance as if it were a real stack class.
 @param inObject The object being pushed to the top of the stack.
 */
- (void)ako_stackPush:(id)inObject;

/**
 Pops an object from the top of the current instance.
 This method is the equivalent of the "pop" method, and uses
 the current instance as if it were a real stack class.
 @return The object being popped from the top of the stack.
 */
- (id)ako_stackPop;

@end
