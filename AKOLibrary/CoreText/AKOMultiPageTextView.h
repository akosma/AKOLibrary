//
//  AKOMultiPageTextView.h
//  AKOLibrary
//
//  Created by Adrian on 4/28/10.
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

/**
 Lays out text over several pages, each using several columns.
 This class uses the AKOMultiColumnTextView class to lay out long
 texts into several pages, using the specified number of columns.
 */
@interface AKOMultiPageTextView : UIView <UIScrollViewDelegate>
{
@private
    NSString *_text;
    UIFont *_font;
    UIColor *_color;
    NSInteger _columnCount;
}

/**
 The text to be shown in the component.
 The text inserted in this property is split among several
 pages automatically, using the number of columns passed as 
 parameters.
 */
@property (nonatomic, copy) NSString *text;

/**
 The font to be used for formatting the text displayed by the component.
 */
@property (nonatomic, retain) UIFont *font;

/**
 The color of the text to be displayed in the component.
 */
@property (nonatomic, retain) UIColor *color;

/**
 The number of columns in which to split the text into.
 */
@property (nonatomic) NSInteger columnCount;

@end
