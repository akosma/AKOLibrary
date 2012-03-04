//
//  AKOEasyTableViewControllerDelegate.h
//  AKOLibrary
//
//  Created by Adrian on 11/22/09.
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
 @file AKOEasyTableViewControllerDelegate.h
 Includes the definition of the AKOEasyTableViewControllerDelegate protocol.
 */


#import <Foundation/Foundation.h>

@class AKOEasyTableViewController;

@protocol AKOEasyTableViewControllerDelegate <NSObject>

@optional

/**
 Called when the user selects an item in the list.
 @param controller The controller calling this method.
 @param item The data item that corresponds to the cell touched.
 */
- (void)easyTableViewController:(AKOEasyTableViewController *)controller 
                  didSelectItem:(id)item;

/**
 Called when the user touches an accessory view on the list.
 @param controller The controller calling this method.
 @param item The data item that corresponds to the cell touched.
 */
- (void)easyTableViewController:(AKOEasyTableViewController *)controller 
         didTapAccessoryForItem:(id)item;

@end
