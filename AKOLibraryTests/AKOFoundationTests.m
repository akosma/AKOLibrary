//
//  AKOFoundationTests.m
//  AKOLibrary
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AKOFoundationTests.h"
#import "AKOLibrary_Foundation.h"

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
    count = [stack count];
    STAssertEquals(count, 1, @"The stack now has 1 element");

    [stack ako_stackPush:obj2];
    count = [stack count];
    STAssertEquals(count, 2, @"The stack now has 2 elements");

    [stack ako_stackPush:obj3];
    count = [stack count];
    STAssertEquals(count, 3, @"The stack now has 3 elements");

    [stack ako_stackPush:obj4];
    count = [stack count];
    STAssertEquals(count, 4, @"The stack now has 4 elements");

    id obj = [stack ako_stackPop];
    STAssertEquals(obj, obj4, @"The first object to be popped is the last one to be inserted");
    count = [stack count];
    STAssertEquals(count, 3, @"The stack now has 3 elements");

    obj = [stack ako_stackPop];
    STAssertEquals(obj, obj3, @"The other objects pop in order");
    count = [stack count];
    STAssertEquals(count, 2, @"The stack now has 2 elements");

    obj = [stack ako_stackPop];
    STAssertEquals(obj, obj2, @"The other objects pop in order");
    count = [stack count];
    STAssertEquals(count, 1, @"The stack now has 1 element");

    obj = [stack ako_stackPop];
    STAssertEquals(obj, obj1, @"The other objects pop in order");
    count = [stack count];
    STAssertEquals(count, 0, @"The stack now is empty");
}

#pragma mark - NSNumber methods

- (void)testNumberFormattedAsCurrency
{
    double value = 45134.5387;
    NSNumber *number = [NSNumber numberWithDouble:value];
    NSString *result = [number ako_stringFormattedAsCurrency];
    NSString *expected = @"45.134,54";
    
    BOOL equals = [result isEqualToString:expected];
    STAssertTrue(equals, @"The expected result is @%, received %@", expected, result);
}

- (void)testRoundedInteger
{
    NSInteger value = 21345;
    NSNumber *number = [NSNumber numberWithInt:value];
    NSString *result = [number ako_stringFormattedAsRoundedInteger];
    NSString *expected = @"21000";

    BOOL equals = [result isEqualToString:expected];
    STAssertTrue(equals, @"The expected result is @%, received %@", expected, result);
}

- (void)testLocalizedYesNo
{
    NSNumber *boolYes = [NSNumber numberWithBool:YES];
    NSNumber *boolNo = [NSNumber numberWithBool:NO];
    
    NSString *yes = [boolYes ako_stringWithLocalizedYesNo];
    NSString *no = [boolNo ako_stringWithLocalizedYesNo];
    
    BOOL equalsYes = [yes isEqualToString:@"YES"];
    BOOL equalsNo = [no isEqualToString:@"NO"];
    
    STAssertTrue(equalsYes, @"The value 'YES' should be there");
    STAssertTrue(equalsNo, @"The value 'NO' should be there");
}

#pragma mark - NSString methods

- (void)testRandomString
{
    NSInteger length = 10;
    NSString *random1 = [NSString ako_randomStringOfLength:length];
    NSInteger received = [random1 length];

    BOOL sizeOK = (received == length);
    STAssertTrue(sizeOK, @"The random string should have a length of %d, but got %d instead", length, received);
    
    NSString *random2 = [NSString ako_randomStringOfLength:length];
    BOOL equal = [random1 isEqualToString:random2];
    STAssertFalse(equal, @"Consecutive random strings should be different");
}

- (void)testSHADigest
{
    NSString *someText = @"Here goes some text to test";
    NSString *sha = [someText ako_SHADigest];
    NSString *expected = @"78e4518c4bb40e465a17b651a39745ac80351c64";
    BOOL equal = [sha isEqualToString:expected];
    STAssertTrue(equal, @"The SHA hash of string %@ should be %@, but got %@ instead", someText, expected, sha);

    NSString *random1 = [NSString ako_randomString];
    NSString *random2 = [NSString ako_randomString];
    
    NSString *sha1 = [random1 ako_SHADigest];
    NSString *sha2 = [random2 ako_SHADigest];
    
    equal = [sha1 isEqualToString:sha2];
    STAssertFalse(equal, @"The hashes of different strings should be different");
}

- (void)testMD5Digest
{
    NSString *someText = @"Here goes some text to test";
    NSString *md5 = [someText ako_MD5Digest];
    NSString *expected = @"5244374072ca0933cc8110bbafae8eec";
    BOOL equal = [md5 isEqualToString:expected];
    STAssertTrue(equal, @"The MD5 hash of string %@ should be %@, but got %@ instead", someText, expected, md5);
    
    NSString *random1 = [NSString ako_randomString];
    NSString *random2 = [NSString ako_randomString];
    
    NSString *md1 = [random1 ako_MD5Digest];
    NSString *md2 = [random2 ako_MD5Digest];
    
    equal = [md1 isEqualToString:md2];
    STAssertFalse(equal, @"The hashes of different strings should be different");
}

- (void)testCapitalization
{
    NSString *someText = @"here goes some text to test";
    NSString *result = [someText ako_stringWithFirstLetterCapitalized];
    NSString *expected = @"Here goes some text to test";
    BOOL equal = [result isEqualToString:expected];
    STAssertTrue(equal, @"The method returned %@, what was expected was %@", result, expected);
}

- (void)testURLEncode
{
    NSString *url = @"http://www.mysite.com/01325/joomla_workspace/index.php?option=com_content&view=article&id=4&Itemid=6&type=2";
    NSString *encoded = [url ako_URLEncode];
    NSString *expected = @"http%3A%2F%2Fwww.mysite.com%2F01325%2Fjoomla_workspace%2Findex.php%3Foption%3Dcom_content%26view%3Darticle%26id%3D4%26Itemid%3D6%26type%3D2";
    BOOL equal = [encoded isEqualToString:expected];
    STAssertTrue(equal, @"The URL encoding returned %@ but what was expected was %@", encoded, expected);
}

- (void)testURLDecode
{
    NSString *url = @"http%3A%2F%2Fwww.mysite.com%2F01325%2Fjoomla_workspace%2Findex.php%3Foption%3Dcom_content%26view%3Darticle%26id%3D4%26Itemid%3D6%26type%3D2";
    NSString *encoded = [url ako_URLDecode];
    NSString *expected = @"http://www.mysite.com/01325/joomla_workspace/index.php?option=com_content&view=article&id=4&Itemid=6&type=2";
    BOOL equal = [encoded isEqualToString:expected];
    STAssertTrue(equal, @"The URL encoding returned %@ but what was expected was %@", encoded, expected);
}

@end
