//
//  MKMapView+AKOLibrary.m
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

#import "MKMapView+AKOLibrary.h"

// Adapted from 
// http://troybrant.net/blog/2010/01/set-the-zoom-level-of-an-mkmapview/

static double MERCATOR_OFFSET = 268435456;
static double MERCATOR_RADIUS = 85445659.44705395;


double longitudeToPixelSpaceX(double longitude)
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

double latitudeToPixelSpaceY(double latitude)
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

double pixelSpaceXToLongitude(double pixelX)
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

double pixelSpaceYToLatitude(double pixelY)
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}

MKCoordinateSpan coordinateSpan(MKMapView *mapView, CLLocationCoordinate2D centerCoordinate, NSUInteger zoomLevel)
{
    // convert center coordiate to pixel space
    double centerPixelX = longitudeToPixelSpaceX(centerCoordinate.longitude);
    double centerPixelY = latitudeToPixelSpaceY(centerCoordinate.latitude);

    // determine the scale value from the zoom level
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);

    // scale the map’s size in pixel space
    CGSize mapSizeInPixels = mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;

    // figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);

    // find delta between left and right longitudes
    CLLocationDegrees minLng = pixelSpaceXToLongitude(topLeftPixelX);
    CLLocationDegrees maxLng = pixelSpaceXToLongitude(topLeftPixelX + scaledMapWidth);
    CLLocationDegrees longitudeDelta = maxLng - minLng;

    // find delta between top and bottom latitudes
    CLLocationDegrees minLat = pixelSpaceYToLatitude(topLeftPixelY);
    CLLocationDegrees maxLat = pixelSpaceYToLatitude(topLeftPixelY + scaledMapHeight);
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);

    // create and return the lat/lng span
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    return span;
}


@implementation MKMapView(AKOLibrary)

#pragma mark - Public methods

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated
{
    // clamp large numbers to 28
    zoomLevel = MIN(zoomLevel, 28);
    
    // use the zoom level to compute the region
    MKCoordinateSpan span = coordinateSpan(self, centerCoordinate, zoomLevel);
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    // set the region like normal
    [self setRegion:region animated:animated];
}

@end
