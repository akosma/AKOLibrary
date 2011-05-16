//
//  AKOFoundationTests.h
//  AKOLibrary
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

@interface AKOFoundationTests : SenTestCase 

- (void)testCurrentVersion;
- (void)testRandomArrayObject;
- (void)testCreateCSVFromArrayOfDictionaries;
- (void)testRandomDateBetween1970AndNow;
- (void)testRandomDateBetween2001AndNow;
- (void)testStackMethods;

@end
