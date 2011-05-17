//
//  UIFont+AKOLibrary.h
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
 @file UIFont+AKOLibrary.h
 Contains a category on UIFont with helper methods.
 */

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

/**
 @category UIFont(AKOLibrary)
 Helper methods on UIFont.
 */
@interface UIFont(AKOLibrary)

/**
 Creates and returns a CTFontRef object that corresponds to the parameters.
 This method loads the font stored in the main bundle of the application. The
 font should be stored in a file "name.ttf" in the bundle, where "name" is
 the first parameter of this method, corresponding to a TrueType file (TTF).
 @param name The name of the TTF file to load.
 @param size The size of the font to load.
 @return A CTFontRef object, owned by the caller.
 */
+ (CTFontRef)ako_createBundledFontNamed:(NSString *)name size:(CGFloat)size;

/**
 Returns the CTFontRef object that corresponds to the current instance.
 This method creates and returns a new CTFontRef object that corresponds
 to the current UIFont object. The caller is responsible to call CFRelease
 on the object created by this method.
 @return A CTFontRef object, owned by the caller.
 */
- (CTFontRef)ako_createCTFont;

@end
