//
//  UIColor+AKOLibrary.m
//  AKOLibrary
//
//  Created by Adrian on 5/17/11.
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

#import "UIColor+AKOLibrary.h"
#import "AKOLibrary_Foundation_functions.h"

#define AKO_RETURN_COLOR(r, g, b) static UIColor *ret; if (ret == nil) ret = [UIColor colorWithRed:r green:g blue:b alpha:1.0]; return ret

@implementation UIColor(AKOLibrary)

+ (UIColor *)ako_randomColor
{
    CGFloat red =  (CGFloat)arc4random() / (CGFloat)AKO_ARC4RANDOM_MAX;
    CGFloat blue = (CGFloat)arc4random() / (CGFloat)AKO_ARC4RANDOM_MAX;
    CGFloat green = (CGFloat)arc4random() / (CGFloat)AKO_ARC4RANDOM_MAX;
    CGFloat alpha = (CGFloat)arc4random() / (CGFloat)AKO_ARC4RANDOM_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)ako_indigoColor
{
    AKO_RETURN_COLOR(.294f, 0.0f, .509f);
}

+ (UIColor *)ako_tealColor
{
    AKO_RETURN_COLOR(0.0f, 0.5f, 0.5f);
}

+ (UIColor *)ako_violetColor
{
    AKO_RETURN_COLOR (.498f, 0.0f, 1.0f); 
}

+ (UIColor *)ako_electricVioletColor
{
    AKO_RETURN_COLOR(.506f, 0.0f, 1.0f);
}

+ (UIColor *)ako_vividVioletColor
{
    AKO_RETURN_COLOR(.506f, 0.0f, 1.0f);
}

+ (UIColor *)ako_darkVioletColor
{
    AKO_RETURN_COLOR(.58f, 0.0f, .827f);
}

+ (UIColor *)ako_amberColor
{
    AKO_RETURN_COLOR(1.0f, .75f, 0.0f);
}

+ (UIColor *)ako_darkAmberColor
{
    AKO_RETURN_COLOR(1.0f, .494f, 0.0f);
}

+ (UIColor *)ako_lemonColor
{
    AKO_RETURN_COLOR(1.0f, .914f, .0627f);
}

+ (UIColor *)ako_roseColor
{
    AKO_RETURN_COLOR(1.0f, 0.0f, 0.5f);
}

+ (UIColor *)ako_rubyColor
{
    AKO_RETURN_COLOR(0.8784f, .06667f, .3725f);
}

+ (UIColor *)ako_fireEngineRed
{
    AKO_RETURN_COLOR(0.8078f, 0.0863f, 0.1255f);
}

@end
