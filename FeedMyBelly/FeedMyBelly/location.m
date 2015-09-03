//
//  location.m
//  FeedMyBelly
//
//  Created by Sashidhar on 8/29/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import "location.h"

@implementation location

- (id)init
{
    self = [super init];
    if (self)
    {
        _address = @"";
        _crossStreet = @"";
        _lat = @"";
        _lng= @"";
        _postalCode = @"";
        _city = @"";
        _state = @"";
        _cc = @"";
        _country = @"";
    }
    return self;
}

@end
