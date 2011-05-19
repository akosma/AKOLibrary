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
@dynamic multiline;
@dynamic margin;
@dynamic maximumLineHeight;

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
    self.margin = 0.0;
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
    
    if ((_shadowOffset.width != 0) || (_shadowOffset.height != 0)) 
    {
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

    // Paragraph settings
    CFIndex theNumberOfSettings = 6;
    CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
    CTTextAlignment textAlignment = kCTLeftTextAlignment;
    CGFloat indent = 0.0;
    CGFloat spacing = 0.0;
    CGFloat topSpacing = 0.0;
    CGFloat maximumLineHeight = self.maximumLineHeight;
    CTParagraphStyleSetting theSettings[6] =
    {
        { kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &textAlignment },
        { kCTParagraphStyleSpecifierLineBreakMode, sizeof(CTLineBreakMode), &lineBreakMode },
        { kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(CGFloat), &indent },
        { kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &spacing },
        { kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(CGFloat), &topSpacing },
        { kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(CGFloat), &maximumLineHeight }
    };
    
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(theSettings, theNumberOfSettings);

    // Initialize string, font, and context
    CFStringRef keys[] = { kCTFontAttributeName, kCTForegroundColorAttributeName, kCTParagraphStyleAttributeName };
    CFTypeRef values[] = { [self font], self.textColor.CGColor, paragraphStyle };
    
    CFDictionaryRef attributes =
    CFDictionaryCreate(kCFAllocatorDefault, (const void**)&keys,
                       (const void**)&values, sizeof(keys) / sizeof(keys[0]),
                       &kCFTypeDictionaryKeyCallBacks,
                       &kCFTypeDictionaryValueCallBacks);
    
    CFAttributedStringRef attrString = CFAttributedStringCreate(kCFAllocatorDefault, (CFStringRef)self.text, attributes);

    if (self.isMultiline)
    {
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
        CGMutablePathRef path = CGPathCreateMutable();
        CGRect rect = CGRectInset(self.bounds, self.margin, self.margin);
        CGPathAddRect(path, NULL, rect);
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, 
                                                    CFRangeMake(0, [self.text length]), 
                                                    path, 
                                                    NULL);
        CTFrameDraw(frame, context);
    }
    else
    {
        CTLineRef line = CTLineCreateWithAttributedString(attrString);

        // Add an ellipsis at the end, if required
        UniChar elip = 0x2026;
        CFStringRef elipString = CFStringCreateWithCharacters(NULL, &elip, 1);
        CFAttributedStringRef elipAttrString = CFAttributedStringCreate(NULL, elipString, attributes);
        CTLineRef ellipsis = CTLineCreateWithAttributedString(elipAttrString);
        CTLineRef line2 = CTLineCreateTruncatedLine(line, 
                                                    self.bounds.size.width, 
                                                    kCTLineTruncationEnd, 
                                                    ellipsis);
        
        CFRelease(attributes);
        CFRelease(ellipsis);
        CFRelease(elipAttrString);
        CFRelease(elipString);
        CFRelease(attrString);
        
        // Set text position and draw the line into the graphics context
        CGContextSetTextPosition(context, self.margin, self.margin);
        CTLineDraw(line2, context);
        CFRelease(line);
        CFRelease(line2);
    }
}

#pragma mark -
#pragma mark Setters and getters

- (CGFloat)maximumLineHeight
{
    return _maximumLineHeight;
}

- (void)setMaximumLineHeight:(CGFloat)maximumLineHeight
{
    if (maximumLineHeight != _maximumLineHeight)
    {
        _maximumLineHeight = maximumLineHeight;
        [self setNeedsDisplay];
    }
}

- (CGFloat)margin
{
    return _margin;
}

- (void)setMargin:(CGFloat)margin
{
    if (margin != _margin)
    {
        _margin = margin;
        [self setNeedsDisplay];
    }
}

- (BOOL)isMultiline
{
    return _multiline;
}

- (void)setMultiline:(BOOL)multiline
{
    if (multiline != _multiline)
    {
        _multiline = multiline;
        [self setNeedsDisplay];
    }
}

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
