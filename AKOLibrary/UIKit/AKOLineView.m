//
//  AKOLineView.m
//  CSComposer
//
//  Created by Adrian on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AKOLineView.h"


@implementation AKOLineView

@synthesize points = _points;
@synthesize color = _color;
@synthesize width = _width;
@synthesize mode = _mode;

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _color = [[UIColor whiteColor] retain];
        _width = 2.0;

        // By default, it draws a straight line,
        // the size of the width of this view.
        NSMutableArray *points = [[NSMutableArray alloc] initWithCapacity:2];
        NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
        [points addObject:value1];
        NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(frame.size.width, 0.0)];
        [points addObject:value2];

        _points = points;
    }
    return self;
}

- (void)dealloc
{
    [_points release];
    _points = nil;
    [_color release];
    _color = nil;
    
    [super dealloc];
}

- (void)drawRect:(CGRect)rect 
{
    if ([self.points count] > 1)
    {
        NSValue *valueOrigin = [self.points objectAtIndex:0];
        CGPoint origin = [valueOrigin CGPointValue];

        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:origin];
        for (NSInteger index = 1; index < [self.points count]; ++index)
        {
            NSValue *value = [self.points objectAtIndex:index];
            CGPoint point = [value CGPointValue];
            
            [path addLineToPoint:point];
        }
        path.lineWidth = self.width;
        [path closePath];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        if (self.mode == AKOLineViewModeStroke)
        {
            [self.color setStroke];
            [path stroke];
        }
        else if (self.mode == AKOLineViewModeFill)
        {
            [self.color setFill];
            [path fill];
        }
        CGContextRestoreGState(context);
    }
}

#pragma mark - Dynamic properties

- (CGFloat)width
{
    return _width;
}

- (void)setWidth:(CGFloat)width
{
    _width = width;
    [self setNeedsDisplay];
}

- (AKOLineViewMode)mode
{
    return _mode;
}

- (void)setMode:(AKOLineViewMode)mode
{
    _mode = mode;
    [self setNeedsDisplay];
}

- (UIColor *)color
{
    return [[_color retain] autorelease];
}

- (void)setColor:(UIColor *)color
{
    if (color != _color)
    {
        [_color release];
        _color = [color retain];
        [self setNeedsDisplay];
    }
}

- (NSArray *)points
{
    return [[_points retain] autorelease]; 
}

- (void)setPoints:(NSArray *)newPoints
{
    if (_points != newPoints) 
    {
        [_points release];
        _points = [newPoints copy];
        [self setNeedsDisplay];
    }
}

@end
