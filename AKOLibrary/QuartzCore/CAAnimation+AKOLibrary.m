//
//  CAAnimation+AKOLibrary.m
//  AKOLibrary
//
//  Created by Adrian on 4/15/11.
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

#import "CAAnimation+AKOLibrary.h"


@implementation CAAnimation (AKOLibrary)

+ (CAAnimation *)ako_pulsatingAnimationWithDuration:(CFTimeInterval)duration
{
    CABasicAnimation *pulsatingAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulsatingAnimation.duration = duration;
    pulsatingAnimation.fillMode = kCAFillModeForwards; 
    pulsatingAnimation.removedOnCompletion = NO;
    pulsatingAnimation.repeatCount = HUGE_VALF; // repeats forever
    pulsatingAnimation.autoreverses = YES;
    pulsatingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulsatingAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    pulsatingAnimation.toValue = [NSNumber numberWithFloat:1.2];
    
    return pulsatingAnimation;
}

+ (CAAnimation *)ako_opacityAndTranformAnimationWithDuration:(CFTimeInterval)duration
{
	CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
	opacityAnimation.removedOnCompletion = YES;
    opacityAnimation.duration = duration;
    NSNumber *one = [NSNumber numberWithFloat:0.0];
    NSNumber *two = [NSNumber numberWithFloat:0.2];
    NSNumber *three = [NSNumber numberWithFloat:0.4];
    NSNumber *four = [NSNumber numberWithFloat:0.6];
    NSNumber *five = [NSNumber numberWithFloat:0.8];
    NSNumber *six = [NSNumber numberWithFloat:1.0];
    NSArray *times = [NSArray arrayWithObjects:one, two, three, four, five, six, nil];
    opacityAnimation.keyTimes = times;
    NSArray *values = [NSArray arrayWithObjects:two, three, four, three, two, one, nil];
    opacityAnimation.values = values;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	transformAnimation.removedOnCompletion = YES;
	transformAnimation.duration = duration;
    CATransform3D trans = CATransform3DMakeScale(0.1, 0.1, 0.1);
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:trans];
    
	CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.delegate = self;
    groupAnimation.duration = duration;
	groupAnimation.animations = [NSArray arrayWithObjects:opacityAnimation, transformAnimation, nil];
    
    return groupAnimation;
}

@end
