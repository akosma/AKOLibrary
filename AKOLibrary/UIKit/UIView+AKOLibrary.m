//
//  UIView+AKOLibrary.m
//  AKOLibrary
//
//  Created by Adrian on 4/15/11.
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

#import "UIView+AKOLibrary.h"


@implementation UIView (AKOLibrary)

- (void)ako_addDropShadow
{
    self.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.layer.shadowRadius = 3.0;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shouldRasterize = YES;
}

- (void)ako_addDropShadowHighPerformance
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = path.CGPath;
    self.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.layer.shadowOpacity = 1.0;
    self.layer.shouldRasterize = YES;    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
}

- (void)ako_removeDropShadow
{
    self.layer.shadowPath = NULL;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 0.0;
}

- (UIImage *)ako_snapshot
{
    // This code comes from 
    // http://idevkit.com/forums/tutorials-code-samples-sdk/5-uiimage-any-calayer-uiview.html
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

- (void)ako_saveToPDF:(NSString *)path
{
    UIGraphicsBeginPDFContextToFile(path, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(self.frame, nil);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // PDF contexts have an inverted coordinate system, 
    // which means we have to make a transformation before drawing
    CGContextTranslateCTM(currentContext, 0, self.frame.size.height);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Get the current image of the current drawing
    UIImage *image = [self ako_snapshot];
    
    // Draw the image in the PDF file
    CGContextDrawImage(currentContext, self.frame, image.CGImage);
    
    UIGraphicsEndPDFContext();
}

@end
