//
//  UIView+AKOLibrary.h
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
 @file UIView+AKOLibrary.h
 Includes extensions to the UIView class.
 */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


/**
 Extensions to the UIView class.
 */
@interface UIView (AKOLibrary)

/**
 Adds a drop shadow to the current view.
 */
- (void)ako_addDropShadow;

/**
 Adds a drop shadow to the current view using a slighly faster method.
 */
- (void)ako_addDropShadowHighPerformance;

/**
 Removes the drop shadow from the current view.
 */
- (void)ako_removeDropShadow;

/**
 Takes a snapshot image of the current view.
 */
- (UIImage *)ako_snapshot;

/**
 Saves a snapshot image of the current view as a PDF file.
 @param path The path to the PDF file that will contain a snapshot 
 of the current view.
 */
- (void)ako_saveToPDF:(NSString *)path;

@end
