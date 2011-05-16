//
//  AKOCoreDataTests.m
//  AKOLibrary
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AKOCoreDataTests.h"
#import "AKOLibrary_CoreData.h"

@implementation AKOCoreDataTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testAddAscendingSortingToFetchRequest
{
    NSFetchRequest *request1 = [[[NSFetchRequest alloc] init] autorelease];
    [request1 ako_sortAscending:YES withKeys:@"name", @"lastname", @"phone", nil];
    
    NSArray *sortDescriptors = [request1 sortDescriptors];
    NSInteger count = [sortDescriptors count];
    
    STAssertEquals(count, 3, @"There should be 3 sort descriptors in the fetch request");
    
    for (NSSortDescriptor *descriptor in sortDescriptors)
    {
        BOOL ascending = [descriptor ascending];
        STAssertTrue(ascending, @"Each sort descriptor should be ascending");
    }
    
    NSSortDescriptor *desc1 = [sortDescriptors objectAtIndex:0];
    NSString *key1 = [desc1 key];
    STAssertEquals(key1, @"name", @"The first key should be 'name'");

    NSSortDescriptor *desc2 = [sortDescriptors objectAtIndex:1];
    NSString *key2 = [desc2 key];
    STAssertEquals(key2, @"lastname", @"The first key should be 'lastname'");

    NSSortDescriptor *desc3 = [sortDescriptors objectAtIndex:2];
    NSString *key3 = [desc3 key];
    STAssertEquals(key3, @"phone", @"The first key should be 'phone'");
}

- (void)testAddDescendingSortingToFetchRequest
{
    NSFetchRequest *request1 = [[[NSFetchRequest alloc] init] autorelease];
    [request1 ako_sortAscending:NO withKeys:@"country", @"price", @"enabled", @"active", nil];
    
    NSArray *sortDescriptors = [request1 sortDescriptors];
    NSInteger count = [sortDescriptors count];
    
    STAssertEquals(count, 4, @"There should be 4 sort descriptors in the fetch request");
    
    for (NSSortDescriptor *descriptor in sortDescriptors)
    {
        BOOL ascending = [descriptor ascending];
        STAssertFalse(ascending, @"Each sort descriptor should be descending");
    }
}

@end
