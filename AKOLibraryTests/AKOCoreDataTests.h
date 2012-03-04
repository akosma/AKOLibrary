//
//  AKOCoreDataTests.h
//  AKOLibrary
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 akosma software. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AKOCoreDataTests : SenTestCase 

- (void)testAddAscendingSortingToFetchRequest;
- (void)testAddDescendingSortingToFetchRequest;

@end
