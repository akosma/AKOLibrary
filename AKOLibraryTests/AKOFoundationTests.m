//
//  AKOFoundationTests.m
//  AKOLibrary
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AKOFoundationTests.h"
#import "AKOLibrary_Foundation_functions.h"
#import "NSArray+AKOLibrary.h"
#import "NSDate+AKOLibrary.h"
#import "NSMutableArray+AKOLibrary.h"

@implementation AKOFoundationTests

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

#pragma mark - Foundation functions

- (void)testCurrentVersion
{
    NSString *version = AKOCurrentVersionNumber();
    NSString *realVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    STAssertEquals(version, realVersion, @"The function should return the proper version number");
}

#pragma mark - NSArray categories

- (void)testRandomArrayObject
{
    NSArray *array = [NSArray arrayWithObjects:@"first", @"second", @"third", nil];
    id obj = [array ako_randomObject];
    STAssertNotNil(obj, @"The random object should never be nil");
    
    BOOL belongs = [array containsObject:obj];
    STAssertTrue(belongs, @"The random object should belong to the array");
}

- (void)testCreateCSVFromArrayOfDictionaries
{
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"value3", @"key1", @"value4", @"key2", nil];
    NSArray *array = [NSArray arrayWithObjects:dict1, dict2, nil];
    NSData *csvData = [array ako_formatAsCSV];
    NSString *csv = [[[NSString alloc] initWithData:csvData encoding:NSUTF8StringEncoding] autorelease];
    
    NSString *output = @"key2, key1, \nvalue2, value1, \nvalue4, value3, \n";
    BOOL equal = [csv isEqualToString:output];
    STAssertTrue(equal, @"The output of the method should be a CSV-formatted string, instead it was '%@'", csv);
}

#pragma mark - NSDate categories

- (void)testRandomDateBetween1970AndNow
{
    NSDate *random = [NSDate ako_randomDateBetween1970AndNow];
    NSTimeInterval interval = [random timeIntervalSince1970];
    BOOL positive = (interval > 0);
    STAssertTrue(positive, @"The random date should be after 1970");

    NSTimeInterval intervalSinceNow = [random timeIntervalSinceNow];
    BOOL negative = (intervalSinceNow > 0);
    STAssertFalse(negative, @"The random date should be before now");
}

- (void)testRandomDateBetween2001AndNow
{
    NSDate *random = [NSDate ako_randomDateBetween2001AndNow];
    NSTimeInterval interval = [random timeIntervalSinceReferenceDate];
    BOOL positive = (interval > 0);
    STAssertTrue(positive, @"The random date should be after 2001");

    NSTimeInterval intervalSinceNow = [random timeIntervalSinceNow];
    BOOL negative = (intervalSinceNow > 0);
    STAssertFalse(negative, @"The random date should be before now");
}

- (void)testWeekdays
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setLocale:[NSLocale currentLocale]];

    NSDate *sun = [formatter dateFromString:@"May 15, 2011"];
    NSDate *mon = [formatter dateFromString:@"May 16, 2011"];
    NSDate *tue = [formatter dateFromString:@"May 17, 2011"];
    NSDate *wed = [formatter dateFromString:@"May 18, 2011"];
    NSDate *thu = [formatter dateFromString:@"May 19, 2011"];
    NSDate *fri = [formatter dateFromString:@"May 20, 2011"];
    NSDate *sat = [formatter dateFromString:@"May 21, 2011"];
    
    NSString *sunday = [sun ako_weekday];
    NSString *monday = [mon ako_weekday];
    NSString *tuesday = [tue ako_weekday];
    NSString *wednesday = [wed ako_weekday];
    NSString *thursday = [thu ako_weekday];
    NSString *friday = [fri ako_weekday];
    NSString *saturday = [sat ako_weekday];
    
    BOOL sunEquals = [sunday isEqualToString:@"WEEKDAY_1"];
    BOOL monEquals = [monday isEqualToString:@"WEEKDAY_2"];
    BOOL tueEquals = [tuesday isEqualToString:@"WEEKDAY_3"];
    BOOL wedEquals = [wednesday isEqualToString:@"WEEKDAY_4"];
    BOOL thuEquals = [thursday isEqualToString:@"WEEKDAY_5"];
    BOOL friEquals = [friday isEqualToString:@"WEEKDAY_6"];
    BOOL satEquals = [saturday isEqualToString:@"WEEKDAY_7"];
    
    STAssertTrue(sunEquals, @"Sunday should be properly formatted");
    STAssertTrue(monEquals, @"Monday should be properly formatted");
    STAssertTrue(tueEquals, @"Tuesday should be properly formatted");
    STAssertTrue(wedEquals, @"Wednesday should be properly formatted");
    STAssertTrue(thuEquals, @"Thursday should be properly formatted");
    STAssertTrue(friEquals, @"Friday should be properly formatted");
    STAssertTrue(satEquals, @"Saturday should be properly formatted");
}

#pragma mark - NSMutableArray methods

- (void)testStackMethods
{
    id obj1 = @"first object";
    id obj2 = [NSArray array];
    id obj3 = [NSDictionary dictionary];
    id obj4 = [NSNull null];
    
    NSMutableArray *stack = [NSMutableArray arrayWithCapacity:4];

    NSInteger count = [stack count];
    STAssertEquals(count, 0, @"The stack now is empty");
    
    [stack ako_stackPush:obj1];
    [stack ako_stackPush:obj2];
    [stack ako_stackPush:obj3];
    [stack ako_stackPush:obj4];

    count = [stack count];
    STAssertEquals(count, 4, @"The stack now has 4 elements");

    id obj = [stack ako_stackPop];
    STAssertEquals(obj, obj4, @"The first object to be popped is the last one to be inserted");

    obj = [stack ako_stackPop];
    STAssertEquals(obj, obj3, @"The other objects pop in order");

    obj = [stack ako_stackPop];
    STAssertEquals(obj, obj2, @"The other objects pop in order");

    obj = [stack ako_stackPop];
    STAssertEquals(obj, obj1, @"The other objects pop in order");
    
    count = [stack count];
    STAssertEquals(count, 0, @"The stack now is empty");
}

@end
