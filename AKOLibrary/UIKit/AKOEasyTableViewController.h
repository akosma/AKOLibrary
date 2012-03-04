//
//  AKOEasyTableViewController.h
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
 @file AKOEasyTableViewController.h
 Includes the definition of the AKOEasyTableViewController class.
 */

#import <UIKit/UIKit.h>
#import "AKOEasyTableViewControllerDelegate.h"

/**
 Complementary class used by the AKOEasyNavigationController class.
 This class has a "dataSource" parameter, which once set will load
 automatically any data in it in the table view.
 */
@interface AKOEasyTableViewController : UITableViewController 

/**
 The data to display in the table.
 */
@property (nonatomic, retain) NSArray *dataSource;

/**
 The delegate of the current table.
 */
@property (nonatomic, assign) id<AKOEasyTableViewControllerDelegate> delegate;

/**
 Toggle specifying whether the selected item is deselected automatically.
 */
@property (nonatomic) BOOL autoDeselect;

/**
 The type of accessory applied to all cells of this table.
 */
@property (nonatomic) UITableViewCellAccessoryType accessoryType;

/**
 The height of the rows in this table.
 */
@property (nonatomic) CGFloat rowHeight;

/**
 The filename in the current bundle where the data is located.
 */
@property (nonatomic, copy) NSString *dataSourceFileName;

@end
