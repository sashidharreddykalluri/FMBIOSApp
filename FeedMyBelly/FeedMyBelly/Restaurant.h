//
//  Restaurant.h
//  BRTestApp
//
//  Created by Sashidhar on 8/26/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "contact.h"
#import "location.h"

@interface Restaurant : NSObject

@property (nonatomic,strong) location *objectLocation;
@property (nonatomic,strong) contact *objContact;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *backgroundImageURL;
@property (nonatomic,strong) NSString *category;

@end