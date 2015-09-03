//
//  FMBRestListController.h
//  FeedMyBelly
//
//  Created by Sashidhar on 8/21/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "contact.h"
#import "location.h"

@interface FMBRestListController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

- (contact*) loadContact:(id)contactObject;
- (location*) loadLocation:(id)locationObject;

@end

