//
//  AKOEasyNavigationController.m
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

#import "AKOEasyNavigationController.h"
#import "AKOEasyTableViewController.h"


@interface AKOEasyNavigationController ()

@property (nonatomic, retain) NSArray *dataSequence;

- (void)loadNextScreen;

@end


@implementation AKOEasyNavigationController

@synthesize dataSequence = _dataSequence;
@synthesize dataSequenceFileName = _dataSequenceFileName;

#pragma mark -
#pragma mark Init and dealloc

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        _dataSequenceFileName = nil;
        _dataSequence = nil;
    }
    return self;
}

- (void)dealloc 
{
    [_dataSequence release];
    [_dataSequenceFileName release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public properties

- (NSString *)dataSequenceFileName
{
    return _dataSequenceFileName;
}

- (void)setDataSequenceFileName:(NSString *)newFileName
{
    [_dataSequenceFileName release];
    _dataSequenceFileName = [newFileName copy];
    NSString *path = [[NSBundle mainBundle] pathForResource:newFileName ofType:@"plist"];
    if (path != nil)
    {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
        self.dataSequence = array;
        [array release];
    }
}

#pragma mark -
#pragma mark Public methods

- (void)loadNextScreen
{
    if (self.dataSequence != nil && [self.dataSequence count] >= [self.viewControllers count])
    {
        NSInteger index = [self.viewControllers count] - 1;
        NSDictionary *dict = [self.dataSequence objectAtIndex:index];
        UITableViewStyle style = (UITableViewStyle)[[dict objectForKey:@"style"] intValue];
        UITableViewCellAccessoryType accessory = (UITableViewCellAccessoryType)[[dict objectForKey:@"accessory"] intValue];
        CGFloat rowHeight = (CGFloat)[[dict objectForKey:@"rowHeight"] floatValue];
        NSString *fileName = [dict objectForKey:@"fileName"];

        AKOEasyTableViewController *newController = [[AKOEasyTableViewController alloc] initWithStyle:style];
        newController.title = @"Detail View";
        newController.dataSourceFileName = fileName;
        newController.title = fileName;
        newController.autoDeselect = YES;
        newController.delegate = self;
        newController.accessoryType = accessory;
        newController.rowHeight = rowHeight;
        [self pushViewController:newController animated:YES];
        [newController release];
    }
}

#pragma mark -
#pragma mark AKOEasyTableViewControllerDelegate methods

- (void)easyTableViewController:(AKOEasyTableViewController *)controller 
                  didSelectItem:(id)item
{
    [self loadNextScreen];
}

- (void)easyTableViewController:(AKOEasyTableViewController *)controller 
         didTapAccessoryForItem:(id)item
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Accessory Tapped" 
                                                    message:[item description] 
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];    
    [alert show];
    [alert release];
}

@end
