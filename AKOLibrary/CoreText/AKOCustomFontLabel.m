//
//  AKOCustomFontView.m
//  AKOLibrary
//
//  Created by Adrian on 6/19/10.
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

#import "AKOCustomFontLabel.h"
#import "UIFont+AKOLibrary.h"

@interface AKOCustomFontLabel ()

- (void)setup;

@end


@implementation AKOCustomFontLabel

@dynamic text;
@dynamic textColor;
@dynamic shadowOffset;
@dynamic shadowColor;

#pragma mark -
#pragma mark Init and dealloc

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    CTFontRef font = [[UIFont systemFontOfSize:17.0] ako_createCTFont];
    [self setFont:font];
    CFRelease(font);

    self.textColor = [UIColor blackColor];
    self.text = @"";
    self.shadowColor = [UIColor whiteColor];
    self.shadowOffset = CGSizeMake(0,0);
}

- (void)dealloc 
{
    self.text = nil;
    self.textColor = nil;
    [self setFont:NULL];
    self.shadowColor = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIView methods

- (void)drawRect:(CGRect)rect 
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGAffineTransform shadowFlip = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, self.frame.size.height);
    CGContextConcatCTM(context, shadowFlip);
    
    if ((_shadowOffset.width != 0) || (_shadowOffset.height != 0)) {
        // Initialize string, font, and context
        CFStringRef shadowKeys[] = { kCTFontAttributeName, kCTForegroundColorAttributeName };
        CFTypeRef shadowValues[] = { [self font], self.shadowColor.CGColor };
        
        CFDictionaryRef shadowAttributes =
        CFDictionaryCreate(kCFAllocatorDefault, (const void**)&shadowKeys,
                           (const void**)&shadowValues, sizeof(shadowKeys) / sizeof(shadowKeys[0]),
                           &kCFTypeDictionaryKeyCallBacks,
                           &kCFTypeDictionaryValueCallBacks);
        
        CFAttributedStringRef shadowAttrString = CFAttributedStringCreate(kCFAllocatorDefault, (CFStringRef)self.text, shadowAttributes);
        CFRelease(shadowAttributes);
        
        CTLineRef shadowLine = CTLineCreateWithAttributedString(shadowAttrString);
        CFRelease(shadowAttrString);
        
        // Set text position and draw the line into the graphics context
        CGContextSetTextPosition(context, _shadowOffset.width, 20.0-_shadowOffset.height);
        CTLineDraw(shadowLine, context);
    }
   


    // Initialize string, font, and context
    CFStringRef keys[] = { kCTFontAttributeName, kCTForegroundColorAttributeName };
    CFTypeRef values[] = { [self font], self.textColor.CGColor };
    
    CFDictionaryRef attributes =
    CFDictionaryCreate(kCFAllocatorDefault, (const void**)&keys,
                       (const void**)&values, sizeof(keys) / sizeof(keys[0]),
                       &kCFTypeDictionaryKeyCallBacks,
                       &kCFTypeDictionaryValueCallBacks);
    
    CFAttributedStringRef attrString = CFAttributedStringCreate(kCFAllocatorDefault, (CFStringRef)self.text, attributes);
    CFRelease(attributes);
    
    CTLineRef line = CTLineCreateWithAttributedString(attrString);

    // Add an ellipsis at the end, if required
    UniChar elip = 0x2026;
    CFStringRef elipString = CFStringCreateWithCharacters(NULL, &elip, 1);
    CFAttributedStringRef elipAttrString = CFAttributedStringCreate(NULL, elipString, attributes);
    CTLineRef ellipsis = CTLineCreateWithAttributedString(elipAttrString);
    line = CTLineCreateTruncatedLine(line, self.frame.size.width, kCTLineTruncationEnd, ellipsis);
    
    CFRelease(ellipsis);
    CFRelease(elipAttrString);
    CFRelease(elipString);
    CFRelease(attrString);
    CFRelease(attributes);
    
    // Set text position and draw the line into the graphics context
    CGContextSetTextPosition(context, 0.0, 20.0);
    CTLineDraw(line, context);
    CFRelease(line);
}

#pragma mark -
#pragma mark Setters and getters

- (NSString *)text
{
    return _text;
}

- (void)setText:(NSString *)newText
{
    if (![self.text isEqualToString:newText])
    {
        [_text release];
        _text = [newText copy];
        
        [self setNeedsDisplay];
    }
}

- (UIColor *)textColor
{
    return _textColor;
}

- (void)setTextColor:(UIColor *)newColor
{
    if (newColor != self.textColor)
    {
        [_textColor release];
        _textColor = [newColor retain];
        
        [self setNeedsDisplay];
    }
}

- (CTFontRef)font
{
    return _font;
}

- (void)setFont:(CTFontRef)newFont
{
    if (_font != NULL)
    {
        CFRelease(_font);
    }
    if (newFont != NULL)
    {
        _font = CFRetain(newFont);
    }
    [self setNeedsDisplay];
}


- (UIColor *)shadowColor
{
    return _shadowColor;
}

- (void)setShadowColor:(UIColor *)newColor
{
    if (newColor != self.shadowColor)
    {
        [_shadowColor release];
        _shadowColor = [newColor retain];
        _shadowSubview.textColor = _shadowColor;
        
        [self setNeedsDisplay];
    }
}

- (CGSize)shadowOffset
{
    return _shadowOffset;
}

- (void)setShadowOffset:(CGSize)newShadowOffset
{
    _shadowOffset = newShadowOffset;
    [self setNeedsDisplay];
}

@end
