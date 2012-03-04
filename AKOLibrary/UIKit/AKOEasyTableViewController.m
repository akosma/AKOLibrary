//
//  AKOEasyTableViewController.m
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

#import "AKOEasyTableViewController.h"
#import "UITableViewController+AKOLibrary.h"

@interface AKOEasyTableViewController ()

@property (nonatomic) BOOL hasSections;

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@end


@implementation AKOEasyTableViewController

@synthesize delegate = _delegate;
@synthesize autoDeselect = _autoDeselect;
@synthesize accessoryType = _accessoryType;
@synthesize dataSource = _dataSource;
@synthesize rowHeight = _rowHeight;
@synthesize dataSourceFileName = _dataSourceFileName;
@synthesize hasSections = _hasSections;

#pragma mark - Init and dealloc

- (id)initWithStyle:(UITableViewStyle)style 
{
    if (self = [super initWithStyle:style]) 
    {
        _dataSource = nil;
        _delegate = nil;
        _autoDeselect = NO;
        _hasSections = NO;
        _rowHeight = 44.0;
        _accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)dealloc 
{
    _delegate = nil;
    [_dataSource release];
    [_dataSourceFileName release];
    [super dealloc];
}

#pragma mark - Public properties

- (NSString *)dataSourceFileName
{
    return _dataSourceFileName;
}

- (void)setDataSourceFileName:(NSString *)newFileName
{
    [_dataSourceFileName release];
    _dataSourceFileName = [newFileName copy];
    NSString *path = [[NSBundle mainBundle] pathForResource:newFileName ofType:@"plist"];
    NSArray *data = [[NSArray alloc] initWithContentsOfFile:path];
    self.dataSource = data;
    [data release];
}

- (CGFloat)rowHeight
{
    return _rowHeight;
}

- (void)setRowHeight:(CGFloat)value
{
    _rowHeight = value;
    [self.tableView reloadData];
}

- (id)dataSource
{
    return _dataSource;
}

- (void)setDataSource:(id)object
{
    if (object != _dataSource)
    {
        [_dataSource release];
        _dataSource = [object retain];
        
        if ([_dataSource count] > 0)
        {
            id obj = [_dataSource objectAtIndex:0];
            _hasSections = [obj isKindOfClass:[NSDictionary class]];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - Public methods

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    if (self.hasSections)
    {
        return [self.dataSource count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    if (self.hasSections)
    {
        NSDictionary *dict = [self.dataSource objectAtIndex:section];
        NSArray *values = [dict objectForKey:@"values"];
        return [values count];
    }
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.hasSections)
    {
        NSDictionary *dict = [self.dataSource objectAtIndex:section];
        return [dict objectForKey:@"title"];
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    id obj = [self objectAtIndexPath:indexPath];
    static NSString *CellIdentifier = @"AKOEasyTableViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType = self.accessoryType;
    cell.textLabel.text = [obj description];
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self objectAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(easyTableViewController:didTapAccessoryForItem:)])
    {
        [self.delegate easyTableViewController:self didTapAccessoryForItem:obj];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    id obj = [self objectAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(easyTableViewController:didSelectItem:)])
    {
        [self.delegate easyTableViewController:self didSelectItem:obj];
    }
    
    if (self.autoDeselect)
    {
        [self ako_deselectCurrentlySelectedRow];
    }
}

#pragma mark - Private methods

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.hasSections)
    {
        NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.section];
        NSArray *values = [dict objectForKey:@"values"];
        return [values objectAtIndex:indexPath.row];
    }
    return [self.dataSource objectAtIndex:indexPath.row];
}

@end
