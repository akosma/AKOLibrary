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

#import <UIKit/UIKit.h>
#import "AKOEasyTableViewControllerDelegate.h"

@interface AKOEasyTableViewController : UITableViewController 
{
@private
    NSArray *_dataSource;
    BOOL _hasSections;
    BOOL _autoDeselect;
    UITableViewCellAccessoryType _accessoryType;
    CGFloat _rowHeight;
    NSString *_dataSourceFileName;

    id<AKOEasyTableViewControllerDelegate> _delegate;
}

@property (nonatomic, retain) NSArray *dataSource;
@property (nonatomic, assign) id delegate;
@property (nonatomic) BOOL autoDeselect;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;
@property (nonatomic) CGFloat rowHeight;
@property (nonatomic, copy) NSString *dataSourceFileName;

- (void)deselectSelectedRow;

@end
