//
//  ASOptionsNode.m
//  Dissenter
//
//  Created by Adrian Siwy on 12/31/13.
//  Copyright (c) 2013 adriansiwy. All rights reserved.
//

#import "ASOptionsNode.h"

@implementation ASOptionsNode

- (id)init
{
    self = [super init];
    if (self) {
        self = [ASOptionsNode spriteNodeWithImageNamed:@"OptionsMenu.png"];
        self.anchorPoint = CGPointMake(0, 0);
        self.alpha = 0;
    }
    return self;
}

@end
