//
//  Restaurant.m
//  FeedMyBelly
//
//  Created by Sashidhar on 8/26/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant
- (id)init{
    self = [super init];
    if (self)
    {
        _category = @"";
        _name = @"";
        _backgroundImageURL = @"";
    }
    return self;
}

@end


