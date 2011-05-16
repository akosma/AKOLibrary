//
//  AKOMultiColumnTextView.h
//  AKOLibrary
//
//  Created by Adrian on 4/24/10.
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

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

/**
 Wrapper around CoreText to simplify the creation of multi-column texts.
 This class lays out text in several columns automatically. It is used
 by AKOMultiPageTextView to lay text over several pages in one operation.
 */
@interface AKOMultiColumnTextView : UIView 
{
@private
    NSInteger _columnCount;
    UIFont *_font;
    NSString *_text;
    UIColor *_color;
    CFMutableArrayRef _columnPaths;
    CFMutableArrayRef _frames;
}

/**
 The number of columns in which to split the text into.
 */
@property (nonatomic) NSInteger columnCount;

/**
 The font to be used for formatting the text displayed by the component.
 */
@property (nonatomic, retain) UIFont *font;

/**
 The text to be shown in the component.
 */
@property (nonatomic, copy) NSString *text;

/**
 The color of the text to be displayed in the component.
 */
@property (nonatomic, retain) UIColor *color;

/**
 The index where the text starts to be displayed in this page.
 The AKOMultiPageTextView splits the text in several pages,
 and this parameter (and the finalIndex property) is used to know
 where to start rendering the text. The index refers to the index
 in the "text" property.
 */
@property (nonatomic) CFIndex startIndex;

/**
 The index of the text where the rendering stops.
 The AKOMultiPageTextView splits the text in several pages,
 and this parameter (and the startIndex property) is used to know
 where to start rendering the text. The index refers to the index
 in the "text" property.
 */
@property (nonatomic, readonly) CFIndex finalIndex;

/**
 Specifies whether all the text was rendered in this page or not.
 Signals to the AKOMultiPageTextView that owns this instance that
 not all the text has been rendered in this component, and that a 
 new page (at least) is required. This way, the AKOMultiPageTextView
 component chains the creation of pages one after the other.
 */
@property (nonatomic, readonly) BOOL moreTextAvailable;

@end
