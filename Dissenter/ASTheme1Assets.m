//
//  ASTheme1Assets.m
//  Dissenter
//
//  Created by Adrian Siwy on 1/3/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import "ASTheme1Assets.h"

@implementation ASTheme1Assets

- (id)init
{
    self = [super init];
    if (self) {
        self.color1 = [SKColor colorWithRed:0 green:.4 blue:.7 alpha:1];
        self.color2 = [SKColor colorWithRed:0 green:.6 blue:.3 alpha:1];
    }
    return self;
}

@end
