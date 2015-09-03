//
//  FMBDetailedViewController.m
//  FeedMyBelly
//
//  Created by Sashidhar on 8/27/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import "FMBDetailedViewController.h"
#import<GoogleMaps/GoogleMaps.h>


@interface FMBDetailedViewController ()

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property Restaurant *restaurantData;
@property (weak, nonatomic) IBOutlet UILabel *restName;
@property (weak, nonatomic) IBOutlet UILabel *restCategory;
@property (weak, nonatomic) IBOutlet UITextView *restAddress;
@property (weak, nonatomic) IBOutlet UILabel *restPhonenumber;
@property (weak, nonatomic) IBOutlet UILabel *restTwitter;

@end

@implementation FMBDetailedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadGoogleMap]; //adds google map using coordinates of the selected restaurant
    [self loadDetails]; //loads all other details on to the page.
}

//sets values for Google map
- (void) loadGoogleMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: [_restaurantData.objectLocation.lat doubleValue]
                                                            longitude: [_restaurantData.objectLocation.lng doubleValue] zoom: 15];
    [self.mapView animateToCameraPosition:camera];
    GMSMarker *marker = [ [GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([_restaurantData.objectLocation.lat doubleValue], [_restaurantData.objectLocation.lng doubleValue]);
    marker.title = _restaurantData.name;
    marker.snippet = _restaurantData.objContact.formattedPhone;
    marker.map = self.mapView;
}

//collects restaurant data object from RestListController
- (void) setRestaurant:(Restaurant *) restData
{
    _restaurantData = restData;
}

// loading the details for each restaurant.
- (void) loadDetails
{
    _restName.text = _restaurantData.name;
    _restCategory.text = _restaurantData.category;
    NSArray *address = _restaurantData.objectLocation.formattedAddress;
    NSString *street = address[0];
    NSString *fullAddress = [street stringByAppendingString:address[1]];
    _restAddress.text = fullAddress;
    if (![_restaurantData.objContact.formattedPhone isKindOfClass:[NSNull class]] && _restaurantData.objContact.formattedPhone != nil)
    {
        NSString *formatting = @" ";
        _restPhonenumber.text = [formatting stringByAppendingString:_restaurantData.objContact.formattedPhone];
    }
    if (![_restaurantData.objContact.twitter isKindOfClass:[NSNull class]] && _restaurantData.objContact.twitter != nil)
    {
        NSString *twitter = @" @";
        _restTwitter.text = [twitter stringByAppendingString:_restaurantData.objContact.twitter];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

















