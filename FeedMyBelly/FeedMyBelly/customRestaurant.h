//
//  customRestaurant.h
//  BRTestApp
//
//  Created by Sashidhar on 8/24/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customRestaurant : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *restImage;
@property (weak, nonatomic) IBOutlet UILabel *restName;
@property (weak, nonatomic) IBOutlet UILabel *restCategory;

@end
