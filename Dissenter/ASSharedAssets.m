//
//  ASSharedAssets.m
//  Dissenter
//
//  Created by Adrian Siwy on 1/3/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import "ASSharedAssets.h"

@implementation ASSharedAssets

- (id)init
{
    self = [super init];
    if (self) {
        //assets loaded in here
        self.playerLazer = [SKAction playSoundFileNamed:@"lazer.mp3" waitForCompletion:NO];
        //[NSThread sleepForTimeInterval:2];
    }
    return self;
}

@end
