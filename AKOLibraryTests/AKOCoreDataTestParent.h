//
//  AKOCoreDataTestParent.h
//  AKOLibrary
//
//  Created by Adrian Kosmaczewski on 4/20/12.
//  Copyright (c) 2012 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AKOCoreDataTestParent : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *children;
@end

@interface AKOCoreDataTestParent (CoreDataGeneratedAccessors)

- (void)addChildrenObject:(NSManagedObject *)value;
- (void)removeChildrenObject:(NSManagedObject *)value;
- (void)addChildren:(NSSet *)values;
- (void)removeChildren:(NSSet *)values;

@end
