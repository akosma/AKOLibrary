//
//  AKOLineView.m
//  AKOLibrary
//
//  Created by Adrian on 5/16/11.
//  Copyright (c) 2009, 2010, 2011, Adrian Kosmaczewski & akosma software
//  All rights reserved.
//  
//  Use in source and/or binary forms without modification is permitted following the
//  instructions in the LICENSE file.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
//  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
//  OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "AKOLineView.h"

@interface AKOLineView ()

- (void)setup;

@end


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
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _color = [[UIColor whiteColor] retain];
    _width = 2.0;
    
    // By default, it draws a straight line,
    // the size of the width of this view.
    NSMutableArray *points = [[NSMutableArray alloc] initWithCapacity:2];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
    [points addObject:value1];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, 0.0)];
    [points addObject:value2];
    
    _points = points;
}

- (void)dealloc
{
    [_points release];
    [_color release];
    
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
