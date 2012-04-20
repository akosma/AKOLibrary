//
//  AKOCoreDataTests.m
//  AKOLibrary
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import "AKOCoreDataTests.h"
#import "AKOLibrary_CoreData.h"
#import "AKOLibrary_Managers.h"
#import "AKOCoreDataTestParent.h"
#import "AKOCoreDataTestChild.h"
#import "AKOCoreDataTestManager.h"

static NSInteger OBJECT_COUNT = 10;


@interface AKOCoreDataTests ()

@property (nonatomic, strong) AKOCoreDataTestManager *manager;
@property (nonatomic, getter = isFirstRun) BOOL initialized;

@end


@implementation AKOCoreDataTests

@synthesize manager = _manager;
@synthesize initialized = _initialized;

- (void)setUp
{
    [super setUp];

    self.manager = [AKOCoreDataTestManager sharedAKOCoreDataTestManager];
    
    if (!self.initialized)
    {
        self.initialized = YES;

        [self.manager setPersistenceStoreForTesting];

        // Insert OBJECT_COUNT parents, each with OBJECT_COUNT children
        for (NSInteger index = 0; index < OBJECT_COUNT; ++index)
        {
            AKOCoreDataTestParent *parent = [self.manager createObjectOfType:@"AKOCoreDataTestParent"];
            parent.name = [NSString stringWithFormat:@"Parent %d", index];
            parent.date = [NSDate date];
            for (NSInteger innerIndex = 0; innerIndex < OBJECT_COUNT; ++innerIndex)
            {
                AKOCoreDataTestChild *child = [self.manager createObjectOfType:@"AKOCoreDataTestChild"];
                child.name = [NSString stringWithFormat:@"Child %d", innerIndex];
                [parent addChildrenObject:child];
            }
        }
        [self.manager save];
    }
}

- (void)tearDown
{
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

- (void)testIncrementIndexPath
{
    NSFetchRequest *request = [self.manager fetchRequestForType:@"AKOCoreDataTestParent"];
    [request ako_sortAscending:YES withKeys:@"name", @"date", nil];
    NSFetchedResultsController *controller = [self.manager resultsControllerForRequest:request groupedBy:@"name"];
    [controller performFetch:nil];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    NSIndexPath *next = [controller ako_incrementIndexPath:indexPath];
    STAssertEquals(next.row, 1, @"After incrementing, the row should be 1");
    STAssertEquals(next.section, 0, @"After incrementing, the section should still be 0");
}

- (void)testCannotIncrementIndexPathAfterTheLast
{
    NSInteger last = OBJECT_COUNT - 1;
    NSFetchRequest *request = [self.manager fetchRequestForType:@"AKOCoreDataTestParent"];
    [request ako_sortAscending:YES withKeys:@"name", @"date", nil];
    NSFetchedResultsController *controller = [self.manager resultsControllerForRequest:request groupedBy:@"name"];
    [controller performFetch:nil];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:last inSection:last];
    
    NSIndexPath *next = [controller ako_incrementIndexPath:indexPath];
    STAssertNil(next, @"Incrementing the last index path should return nil");
}

- (void)testDecrementIndexPath
{
    NSFetchRequest *request = [self.manager fetchRequestForType:@"AKOCoreDataTestParent"];
    [request ako_sortAscending:YES withKeys:@"name", @"date", nil];
    NSFetchedResultsController *controller = [self.manager resultsControllerForRequest:request groupedBy:@"name"];
    [controller performFetch:nil];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    
    NSIndexPath *next = [controller ako_decrementIndexPath:indexPath];
    STAssertEquals(next.row, 0, @"After decrementing, the row should be 0");
    STAssertEquals(next.section, 0, @"After decrementing, the section should still be 0");
}

- (void)testCannotDecrementIndexPathBeforeTheFirst
{
    NSFetchRequest *request = [self.manager fetchRequestForType:@"AKOCoreDataTestParent"];
    [request ako_sortAscending:YES withKeys:@"name", @"date", nil];
    NSFetchedResultsController *controller = [self.manager resultsControllerForRequest:request groupedBy:@"name"];
    [controller performFetch:nil];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    NSIndexPath *next = [controller ako_decrementIndexPath:indexPath];
    STAssertNil(next, @"Decrementing the first index path should return nil");
}

@end
