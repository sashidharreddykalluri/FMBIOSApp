//
//  FMBRestListController.m
//  FeedMyBelly
//
//  Created by Sashidhar on 8/21/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import "FMBRestListController.h"
#import "customRestaurant.h"
#import "Restaurant.h"
#import "FMBDetailedViewController.h"
#import "FMBMapWithAllRestaurants.h"

@interface FMBRestListController ()

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *restaurantData;
@property (strong, nonatomic) NSCache* imageCache;
@property NSInteger selectedIndex;

@end

@implementation FMBRestListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set the map bar button with action method
    self.imageCache = [[NSCache alloc] init];
    self.restaurantData = [[NSMutableArray alloc] init];
    [self jsonCall];
    UIBarButtonItem *_btn=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"map.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(showAllRestaurants:)];
    self.navigationItem.rightBarButtonItem=_btn;
}

#pragma mark - Creating Restaurant data object
//json call to load the data asynchronously
- (void)jsonCall
{
    NSString *urlString = @"http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
         if (!error)
         {
             NSError* parseError;
             NSDictionary* parse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
             NSArray* restArray = [parse objectForKey:@"restaurants"];
             for (id singleRestaurant in restArray)
             {
                 Restaurant* restaurant = [[Restaurant alloc] init];
                 restaurant.name = [singleRestaurant valueForKey:@"name"];
                 restaurant.category = [singleRestaurant valueForKey:@"category"];
                 restaurant.backgroundImageURL = [singleRestaurant valueForKey:@"backgroundImageURL"];
                 restaurant.objContact = [self  loadContact:[singleRestaurant valueForKey:@"contact"]];
                 restaurant.objectLocation = [self loadLocation:[singleRestaurant valueForKey:@"location"]];
                 [_restaurantData addObject:restaurant];
             }
             dispatch_async(dispatch_get_main_queue(), ^{
                 // Update the UI
                 [_collectionView reloadData];
                 
             });
         }
     }];
}

//Creates contact object for loading data into **Restaurant** Model
- (contact*)loadContact:(id)contactObject
{
    contact *con = [[contact alloc] init];
    con.phone = [contactObject valueForKey:@"phone"];
    con.formattedPhone = [contactObject valueForKey:@"formattedPhone"];
    con.twitter = [contactObject valueForKey:@"twitter"];
    con.facebook = [contactObject valueForKey:@"facebook"];
    con.facebookUsername = [contactObject valueForKey:@"facebookUsername"];
    
    return con;
}

//Creates Location object for loading data into **Restaurant** Model
- (location*)loadLocation:(id)locationObject
{
    location *loc = [[location alloc] init];
    
    loc.address = [locationObject valueForKey:@"address"];
    loc.crossStreet = [locationObject valueForKey:@"crossStreet"];
    loc.lat = [locationObject valueForKey:@"lat"];
    loc.lng = [locationObject valueForKey:@"lng"];
    loc.postalCode = [locationObject valueForKey:@"postalCode"];
    loc.cc = [locationObject valueForKey:@"cc"];
    loc.city = [locationObject valueForKey:@"city"];
    loc.state = [locationObject valueForKey:@"state"];
    loc.country = [locationObject valueForKey:@"country"];
    loc.formattedAddress = [locationObject valueForKey:@"formattedAddress"];
    
    return loc;
}

//Perform manual segue to Map with all Restaurants
- (void)showAllRestaurants:(id)sender
{
    FMBMapWithAllRestaurants *maps = [self.storyboard instantiateViewControllerWithIdentifier:@"showAll"];
    maps.restaurantData = _restaurantData;
    //Set back bar button to have only back arrow.
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    [self.navigationController pushViewController:maps animated:YES];
}

#pragma mark - UICollectionView Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_restaurantData count];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0; // This is the minimum inter item spacing, can be more
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger) section
{
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    customRestaurant *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restaurantCell" forIndexPath:indexPath];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    Restaurant *res = [[Restaurant alloc] init];
    res = [_restaurantData objectAtIndex:indexPath.row];
    NSString *restaurantImage =  res.backgroundImageURL;
    UIImage *image = [_imageCache objectForKey:restaurantImage];
    cell.restName.text = res.name ;
    cell.restCategory.text = res.category;
    if (image)
    {
        NSLog(@"Image from cache");
        cell.restImage.image = image;
        return cell;
    }
    else
    {
        NSLog(@"downloading image");
        cell.restImage.image = nil;
        dispatch_queue_t downloadQueue = dispatch_queue_create("image downloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:restaurantImage]];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.restImage.image = image;
            });
            [_imageCache setObject:image forKey:restaurantImage];
        });
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    return CGSizeMake(self.view.bounds.size.width, 180);
}

//Action for cell selection.
- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    _selectedIndex = indexPath.row;
    [self performSegueWithIdentifier: @"restaurantDetails" sender: self];
}

//Perform segue to Restaurant Details
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"restaurantDetails"])
    {
        FMBDetailedViewController *vc = [segue destinationViewController]; // Get destination view
        [vc setRestaurant:[_restaurantData objectAtIndex:_selectedIndex]]; // Pass the information to your destination view
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
