//
//  AKOCircleView.m
//  CSComposer
//
//  Created by Adrian on 5/16/11.
//  Copyright (c) 2009, 2010, 2011, Adrian Kosmaczewski & akosma software
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, 
//  are permitted provided that the following conditions are met:
//  
//  Redistributions of source code must retain the above copyright notice, this list 
//  of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this 
//  list of conditions and the following disclaimer in the documentation and/or 
//  other materials provided with the distribution.
//  Neither the name of the akosma software nor the names of its contributors may be 
//  used to endorse or promote products derived from this software without specific 
//  prior written permission.
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
