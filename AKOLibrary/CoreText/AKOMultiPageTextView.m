//
//  AKOMultiPageTextView.m
//  AKOLibrary
//
//  Created by Adrian on 4/28/10.
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

#import "AKOMultiPageTextView.h"
#import "AKOMultiColumnTextView.h"

@interface AKOMultiPageTextView ()

@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *pages;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic) BOOL pageControlUsed;

- (void)setup;

@end


@implementation AKOMultiPageTextView

@synthesize pages = _pages;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize pageControlUsed = _pageControlUsed;
@dynamic text;
@dynamic font;
@dynamic columnCount;
@dynamic color;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
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

- (void)setup
{
    self.pages = [NSMutableArray arrayWithCapacity:5];
    
    CGRect scrollViewFrame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height - 20.0);
    self.scrollView = [[[UIScrollView alloc] initWithFrame:scrollViewFrame] autorelease];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    CGRect pageControlFrame = CGRectMake(0.0, self.frame.size.height - 20.0, self.frame.size.width, 20.0);
    self.pageControl = [[[UIPageControl alloc] initWithFrame:pageControlFrame] autorelease];
    self.pageControl.numberOfPages = 2;
    self.pageControl.backgroundColor = [UIColor whiteColor];
    self.pageControl.currentPage = 0;
    self.pageControl.backgroundColor = [UIColor lightGrayColor];
    [self.pageControl addTarget:self
                         action:@selector(changePage:) 
               forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

- (void)dealloc 
{
    self.pageControl = nil;
    self.scrollView = nil;
    self.pages = nil;

    [_text release];
    _text = nil;
    [_font release];
    _font = nil;
    [_color release];
    _color = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender 
{
    if (self.pageControlUsed) 
    {
        return;
    }
	
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView 
{
    self.pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView 
{
    self.pageControlUsed = NO;
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)changePage:(id)sender 
{
    int page = self.pageControl.currentPage;
	
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    self.pageControlUsed = YES;
}

#pragma mark -
#pragma mark Properties

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

- (UIFont *)font
{
    return _font;
}

- (void)setFont:(UIFont *)newFont
{
    if (newFont != self.font)
    {
        [_font release];
        _font = [newFont retain];
        [self setNeedsDisplay];
    }
}

- (NSInteger)columnCount
{
    return _columnCount;
}

- (void)setColumnCount:(NSInteger)newColumnCount
{
    if (newColumnCount != self.columnCount)
    {
        _columnCount = newColumnCount;
        [self setNeedsDisplay];
    }
}

- (UIColor *)color
{
    return _color;
}

- (void)setColor:(UIColor *)newColor
{
    if (newColor != self.color)
    {
        [_color release];
        _color = [newColor retain];
        [self setNeedsDisplay];
    }
}

#pragma mark -
#pragma mark Drawing code

- (void)drawRect:(CGRect)rect 
{
    [self.pages makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.pages removeAllObjects];

    CGRect pageControlFrame = CGRectMake(0.0, self.frame.size.height - 20.0, self.frame.size.width, 20.0);
    self.pageControl.frame = pageControlFrame;

    NSInteger currentPosition = 0;
    NSInteger iteration = 0;
    BOOL moreTextAvailable = YES;
    do 
    {
        CGRect currentFrame = CGRectOffset(self.scrollView.frame, self.scrollView.frame.size.width * iteration, 0.0);
        AKOMultiColumnTextView *view = [[[AKOMultiColumnTextView alloc] initWithFrame:currentFrame] autorelease];
        
        view.startIndex = currentPosition;
        view.text = self.text;
        view.font = self.font;
        view.columnCount = self.columnCount;
        view.color = self.color;

        [self.pages addObject:view];
        [self.scrollView addSubview:view];

        currentPosition = view.finalIndex;
        iteration += 1;
        
        self.scrollView.contentSize = CGSizeMake(currentFrame.size.width * iteration, currentFrame.size.height);
        moreTextAvailable = view.moreTextAvailable;
    } 
    while (moreTextAvailable);
    self.pageControl.numberOfPages = iteration;
    self.pageControl.currentPage = 0;
}

@end
