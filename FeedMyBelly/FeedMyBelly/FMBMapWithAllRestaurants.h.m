//
//  FMBMapWithAllRestaurants.m
//  FeedMyBelly
//
//  Created by Sashidhar on 8/29/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import "FMBMapWithAllRestaurants.h"
#import<GoogleMaps/GoogleMaps.h>
#import "Restaurant.h"

@implementation FMBMapWithAllRestaurants

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadGoogleMap];
}

//Google Map with all restaurants
- (void)loadGoogleMap
{
    Restaurant *initialRestaurant = _restaurantData[0];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: [initialRestaurant.objectLocation.lat doubleValue]
                                                            longitude: [initialRestaurant.objectLocation.lng doubleValue] zoom: 16];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    for (Restaurant *res in _restaurantData)
    {
        GMSMarker *marker = [ [GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([res.objectLocation.lat doubleValue], [res.objectLocation.lng doubleValue]);
        marker.title = res.name;
        if (res.objContact.formattedPhone != (id)[NSNull null]) //perform nil check.
        {
            marker.snippet = res.objContact.formattedPhone;
        }else
            marker.snippet = @"(no ph number)";
        marker.map = mapView;
    }
    self.view = mapView;
}

@end
