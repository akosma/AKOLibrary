//
//  AKOCoreDataTests.h
//  AKOLibrary
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AKOCoreDataTests : SenTestCase 

- (void)testAddAscendingSortingToFetchRequest;
- (void)testAddDescendingSortingToFetchRequest;
- (void)testIncrementIndexPath;
- (void)testDecrementIndexPath;
- (void)testCannotIncrementIndexPathAfterTheLast;
- (void)testCannotDecrementIndexPathBeforeTheFirst;

@end
