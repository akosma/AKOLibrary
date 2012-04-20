//
//  AKOCoreDataTestManager.m
//  AKOLibrary
//
//  Created by Adrian Kosmaczewski on 4/20/12.
//  Copyright (c) 2012 akosma software. All rights reserved.
//

#import "AKOCoreDataTestManager.h"
#import "SynthesizeSingleton.h"

@implementation AKOCoreDataTestManager

SYNTHESIZE_SINGLETON_FOR_CLASS(AKOCoreDataTestManager)

- (id)init
{
    self = [super initWithFilename:@"TestModel"];
    if (self)
    {
    }
    return self;
}

@end
