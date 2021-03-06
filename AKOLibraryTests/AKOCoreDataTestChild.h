//
//  AKOCoreDataTestChild.h
//  AKOLibrary
//
//  Created by Adrian Kosmaczewski on 4/20/12.
//  Copyright (c) 2012 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AKOCoreDataTestParent;

@interface AKOCoreDataTestChild : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) AKOCoreDataTestParent *parent;

@end
