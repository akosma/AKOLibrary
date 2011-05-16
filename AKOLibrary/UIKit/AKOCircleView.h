//
//  AKOCircleView.h
//  CSComposer
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    AKOCircleViewStyleDefault = 0,
    AKOCircleViewStyleFilled = 1
} AKOCircleViewStyle;

@interface AKOCircleView : UIView 

@property (nonatomic) CGFloat strokeWidth;
@property (nonatomic) AKOCircleViewStyle style;
@property (nonatomic, retain) UIColor *fillColor;
@property (nonatomic, retain) UIColor *strokeColor;

@end
