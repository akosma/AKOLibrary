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

- (void)testDoubleFormattedAsCurrency;
- (void)testFloatFormattedAsCurrency;
- (void)testNumberFormattedAsCurrencyOnlyWorksWithFloatingPoint;
- (void)testRoundedInteger;
- (void)testRoundedIntegerOnlyWorksWithIntegers;
- (void)testLocalizedYesNo;
- (void)testLocalizedYesNoOnlyWorksWithBooleans;
- (void)testGeneratedFromBoolean;
- (void)testGeneratedFromInteger;
- (void)testGeneratedFromFloat;
- (void)testGeneratedFromDouble;

- (void)testRandomString;
- (void)testSHADigest;
- (void)testMD5Digest;
- (void)testCapitalization;
- (void)testURLEncode;
- (void)testURLDecode;

@end
