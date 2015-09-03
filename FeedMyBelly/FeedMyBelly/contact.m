//
//  contact.m
//  FeedMyBelly
//
//  Created by Sashidhar on 8/29/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import "contact.h"

@implementation contact

- (id)init
{
    self = [super init];
    if (self)
    {
        _phone = @"";
        _formattedPhone = @"";
        _twitter = @"";
        _facebook = @"";
        _facebookUsername = @"";
    }
    return self;
}

@end
