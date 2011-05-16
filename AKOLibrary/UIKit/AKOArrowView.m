//
//  AKOArrowView.m
//  CSComposer
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AKOArrowView.h"


@implementation AKOArrowView

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSMutableArray *points = [NSMutableArray array];
        NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
        [points addObject:value1];
        NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(0.0, frame.size.height)];
        [points addObject:value2];
        NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(frame.size.width, frame.size.height / 2.0)];
        [points addObject:value3];
        
        self.points = points;
        self.width = 2.0;
        self.mode = AKOLineViewModeFill;
    }
    return self;
}


@end
