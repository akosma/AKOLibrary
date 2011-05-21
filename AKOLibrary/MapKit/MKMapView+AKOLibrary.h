//
//  MKMapView+AKOLibrary.h
//  AKOLibrary
//
//  Created by Adrian on 2/23/10.
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
 @file MKMapView+AKOLibrary.h
 Contains extensions to the MKMapView class.
 */

#import <MapKit/MapKit.h>

/**
 @category MKMapView(AKOLibrary)
 Adds helper methods to the MKMapView class.
 */
@interface MKMapView(AKOLibrary)

/**
 Provides a way to interact with a map using an API similar to that in JavaScript.
 This method mimics the behavior of the JavaScript API, providing ways to
 zoom in and out in a map providing zoom levels.
 @param centerCoordinate The location where to zoom.
 @param zoomLevel The level of zoom, similar as the JavaScript API. Maps on 
 Google Maps have an integer "zoom level" which defines the resolution of the 
 current view. Zoom levels between 0 (the lowest zoom level, in which the
 entire world can be seen on one map) to 21+ (down to individual buildings) 
 are possible within the default roadmap maps view.
 @param animated Boolean specifying whether the zooming is animated or not.
 */
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end