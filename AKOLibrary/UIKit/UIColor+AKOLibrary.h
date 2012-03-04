//
//  UIColor+AKOLibrary.h
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

/**
 @file UIColor+AKOLibrary.h
 Includes extensions to the UIColor class.
 */

#import <UIKit/UIKit.h>


/**
 @file UIColor+AKOLibrary.h
 Extensions to the UIColor class.
 */
@interface UIColor(AKOLibrary)

/**
 Returns a random color.
 */
+ (UIColor *)ako_randomColor;

/**
 Returns indigo.
 */
+ (UIColor *)ako_indigoColor;

/**
 Returns teal.
 */
+ (UIColor *)ako_tealColor;

/**
 Returns violet.
 */
+ (UIColor *)ako_violetColor;

/**
 Returns electric violet.
 */
+ (UIColor *)ako_electricVioletColor;

/**
 Returns "vivid violet".
 */
+ (UIColor *)ako_vividVioletColor;

/**
 Returns dark violet.
 */
+ (UIColor *)ako_darkVioletColor;

/**
 Returns amber.
 */
+ (UIColor *)ako_amberColor;

/**
 Returns dark amber.
 */
+ (UIColor *)ako_darkAmberColor;

/**
 Returns lemon.
 */
+ (UIColor *)ako_lemonColor;

/**
 Returns rose.
 */
+ (UIColor *)ako_roseColor;

/**
 Returns ruby.
 */
+ (UIColor *)ako_rubyColor;

/**
 Returns "fire engine red".
 */
+ (UIColor *)ako_fireEngineRed;

@end
