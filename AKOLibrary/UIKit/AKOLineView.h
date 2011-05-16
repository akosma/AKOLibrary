//
//  AKOLineView.h
//  CSComposer
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    AKOLineViewModeStroke = 0,
    AKOLineViewModeFill = 1
} AKOLineViewMode;


@interface AKOLineView : UIView 

@property (nonatomic, copy) NSArray *points;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic) CGFloat width;
@property (nonatomic) AKOLineViewMode mode;

@end
