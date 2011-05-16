//
//  AKOCircleView.m
//  CSComposer
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AKOCircleView.h"


@implementation AKOCircleView

@synthesize strokeWidth = _strokeWidth;
@synthesize style = _style;
@synthesize fillColor = _fillColor;
@synthesize strokeColor = _strokeColor;

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        _strokeWidth = 1.0;
        _style = AKOCircleViewStyleDefault;
        _fillColor = [[UIColor whiteColor] retain];
        _strokeColor = [[UIColor blackColor] retain];
    }
    return self;
}

- (void)dealloc 
{
    [_fillColor release];
    [_strokeColor release];
    [super dealloc];
}

- (void)drawRect:(CGRect)rect 
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    CGContextSetLineWidth(context, self.strokeWidth);
    
    CGRect rect2 = CGRectMake(2.0 * self.strokeWidth, 
                              2.0 * self.strokeWidth,
                              self.bounds.size.width - 4.0 * self.strokeWidth, 
                              self.bounds.size.height - 4.0 * self.strokeWidth);
    
    // Draw a filled circle
    CGContextFillEllipseInRect(context, rect2);
    
    // Draw a border circle
    CGContextStrokeEllipseInRect(context, rect2);
}

#pragma mark - Properties

- (CGFloat)strokeWidth
{
    return _strokeWidth;
}

- (void)setStrokeWidth:(CGFloat)strokeWidth
{
    _strokeWidth = strokeWidth;
    [self setNeedsDisplay];
}

- (AKOCircleViewStyle)style
{
    return _style;
}

- (void)setStyle:(AKOCircleViewStyle)style
{
    _style = style;
    [self setNeedsDisplay];    
}

- (UIColor *)fillColor
{
    return [[_fillColor retain] autorelease];
}

- (void)setFillColor:(UIColor *)fillColor
{
    if (fillColor != _fillColor)
    {
        [_fillColor release];
        _fillColor = [fillColor retain];
        [self setNeedsDisplay];
    }
}

- (UIColor *)strokeColor
{
    return [[_strokeColor retain] autorelease];
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    if (strokeColor != _strokeColor)
    {
        [_strokeColor release];
        _strokeColor = [strokeColor retain];
        [self setNeedsDisplay];
    }
}

@end
