//
//  AKOMultiColumnTextView.m
//  AKOLibrary
//
//  Created by Adrian on 4/24/10.
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

#import "AKOMultiColumnTextView.h"
#import "UIFont+AKOLibrary.h"

@interface AKOMultiColumnTextView ()

@property (nonatomic, retain) NSMutableAttributedString *attributedString;

- (void)updateAttributedString;
- (void)updateFrames;
- (void)setup;
- (void)createColumns;

@end


@implementation AKOMultiColumnTextView

@dynamic font;
@dynamic columnCount;
@dynamic text;
@dynamic color;
@synthesize startIndex = _startIndex;
@synthesize finalIndex = _finalIndex;
@synthesize moreTextAvailable = _moreTextAvailable;
@synthesize attributedString = _attributedString;

#pragma mark -
#pragma mark Init and dealloc

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    _columnCount = 3;
    _text = [@"" copy];
    _font = [[UIFont fontWithName:@"Helvetica" size:14.0] retain];
    _color = [[UIColor blackColor] retain];
    _startIndex = 0;
    _finalIndex = 0;
    _moreTextAvailable = NO;
    _columnPaths = NULL;
    _frames = NULL;
}

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

- (void)dealloc 
{
    if (_columnPaths != NULL)
    {
        CFRelease(_columnPaths);
    }
    
    if (_frames != NULL)
    {
        CFRelease(_frames);
    }
    
    self.attributedString = nil;

    [_text release];
    _text = nil;
    [_font release];
    _font = nil;
    [_color release];
    _color = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Properties

- (UIColor *)color
{
    return _color;
}

- (void)setColor:(UIColor *)newColor
{
    [_color release];
    _color = [newColor retain];
    [self updateFrames];
    [self setNeedsDisplay];
}

- (UIFont *)font
{
    return _font;
}

- (void)setFont:(UIFont *)newFont
{
    if (newFont != _font)
    {
        [_font release];
        _font = [newFont retain];
        [self updateFrames];
        [self setNeedsDisplay];
    }
}

- (NSString *)text
{
    return _text;
}

- (void)setText:(NSString *)newText
{
    if (![_text isEqualToString:newText])
    {
        [_text release];
        _text = [newText copy];
        
        self.attributedString = nil;
        [self updateFrames];
        [self setNeedsDisplay];
    }
}

- (NSInteger)columnCount
{
    return _columnCount;
}

- (void)setColumnCount:(NSInteger)newColumnCount
{
    if (_columnCount != newColumnCount)
    {
        _columnCount = newColumnCount;
        [self updateFrames];
        [self setNeedsDisplay];
    }
}

#pragma mark -
#pragma mark Drawing methods

- (void)drawRect:(CGRect)rect 
{
    // Initialize the text matrix to a known value.
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // This is required, otherwise the text is drawn upside down in iPhone OS 3.2 (!?)
    CGContextSaveGState(context);
    CGAffineTransform flip = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, self.frame.size.height);
    CGContextConcatCTM(context, flip);
    CFIndex pathCount = CFArrayGetCount(_columnPaths);
    
    for (int column = 0; column < pathCount; column++)
    {
        CTFrameRef frame = (CTFrameRef)CFArrayGetValueAtIndex(_frames, column);
        CTFrameDraw(frame, context);
    }
    
    CGContextRestoreGState(context);
}

#pragma mark -
#pragma mark Private methods

- (void)createColumns
{
    int column;
    CGRect* columnRects = (CGRect*)calloc(_columnCount, sizeof(*columnRects));
    
    // Start by setting the first column to cover the entire view.
    columnRects[0] = self.bounds;

    // Divide the columns equally across the frame's width.
    CGFloat columnWidth = CGRectGetWidth(self.bounds) / _columnCount;
    for (column = 0; column < _columnCount - 1; column++) 
    {
        CGRectDivide(columnRects[column], 
                     &columnRects[column],
                     &columnRects[column + 1], 
                     columnWidth, 
                     CGRectMinXEdge);
    }
    
    // Inset all columns by a few pixels of margin.
    for (column = 0; column < _columnCount; column++) 
    {
        columnRects[column] = CGRectInset(columnRects[column], 10.0, 10.0);
    }
    
    // Create an array of layout paths, one for each column.
    if (_columnPaths != NULL)
    {
        CFRelease(_columnPaths);
    }
    _columnPaths = CFArrayCreateMutable(kCFAllocatorDefault, _columnCount, &kCFTypeArrayCallBacks);
    for (column = 0; column < _columnCount; column++) 
    {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, columnRects[column]);
        CFArrayInsertValueAtIndex(_columnPaths, column, path);
        CFRelease(path);
    }
    free(columnRects);
}

- (void)updateAttributedString
{
    if (self.text != nil)
    {
        self.attributedString = [[[NSMutableAttributedString alloc] initWithString:self.text] autorelease];
        NSRange range = NSMakeRange(0, [self.text length]);
        
        if (self.font != nil)
        {
            CTFontRef font = [self.font ako_createCTFont];
            [self.attributedString addAttribute:(NSString *)kCTFontAttributeName
                                          value:(id)font
                                          range:range];
            CFRelease(font);
        }
        
        if (self.color != nil)
        {
            [self.attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName 
                                          value:(id)self.color.CGColor
                                          range:range];
        }
        
        CFIndex theNumberOfSettings = 6;
        CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
        CTTextAlignment textAlignment = kCTLeftTextAlignment;
        CGFloat indent = 10.0;
        CGFloat spacing = 15.0;
        CGFloat topSpacing = 5.0;
        CGFloat lineSpacing = 1.0;
        CTParagraphStyleSetting theSettings[6] =
        {
            { kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &textAlignment },
            { kCTParagraphStyleSpecifierLineBreakMode, sizeof(CTLineBreakMode), &lineBreakMode },
            { kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(CGFloat), &indent },
            { kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &spacing },
            { kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(CGFloat), &topSpacing },
            { kCTParagraphStyleSpecifierLineSpacing, sizeof(CGFloat), &lineSpacing }
        };
        
        CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(theSettings, theNumberOfSettings);
        [self.attributedString addAttribute:(NSString *)kCTParagraphStyleAttributeName 
                                      value:(id)paragraphStyle
                                      range:range];
        
        CFRelease(paragraphStyle);
    }
}

- (void)updateFrames
{
    if (self.text != nil)
    {
        [self updateAttributedString];
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedString);
        [self createColumns];
        
        CFIndex pathCount = CFArrayGetCount(_columnPaths);
        CFIndex currentIndex = self.startIndex;
        
        if (_frames != NULL)
        {
            CFRelease(_frames);
        }
        _frames = CFArrayCreateMutable(kCFAllocatorDefault, pathCount, &kCFTypeArrayCallBacks);
        
        for (int column = 0; column < pathCount; column++)
        {
            CGPathRef path = (CGPathRef)CFArrayGetValueAtIndex(_columnPaths, column);
            
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(currentIndex, 0), path, NULL);
            CFArrayInsertValueAtIndex(_frames, column, frame);
            
            CFRange frameRange = CTFrameGetVisibleStringRange(frame);
            currentIndex += frameRange.length;
            CFRelease(frame);
        }
        
        _finalIndex = currentIndex;
        _moreTextAvailable = [self.text length] > self.finalIndex;
        CFRelease(framesetter);
    }
}

@end
