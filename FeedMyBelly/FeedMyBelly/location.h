//
//  location.h
//  FeedMyBelly
//
//  Created by Sashidhar on 8/29/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface location : NSObject

@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *crossStreet;
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSString *lng;
@property (nonatomic,strong) NSString *postalCode;
@property (nonatomic,strong) NSString *cc;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSArray *formattedAddress;

@end
