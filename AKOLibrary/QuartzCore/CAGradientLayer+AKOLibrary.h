//
//  CAGradientLayer+AKOLibrary.h
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

/**
 @file CAGradientLayer+AKOLibrary.h
 Includes extensions for the CAGradientLayer class.
 */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 Extensions for the CAGradientLayer class.
 */
@interface CAGradientLayer (AKOLibrary)

/**
 Returns a gradient layer with the specified start and end colors.
 Remember to set a frame to the return object of this method! Otherwise you will
 not see the gradient layer when added to a view.
 @param startColor The start color of the gradient.
 @param endColor The final color for the gradient.
 @return An instance of CAGradientLayer.
 */
+ (CAGradientLayer *)ako_layerWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

@end
