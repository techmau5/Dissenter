//
//  ASAssets.m
//  Dissenter
//
//  Created by Adrian Siwy on 12/28/13.
//  Copyright (c) 2013 adriansiwy. All rights reserved.
//

#import "ASAssets.h"

@implementation ASAssets

- (id)init
{
    self = [super init];
    if (self) {
        //assets loaded in here
        self.player = [SKTextureAtlas atlasNamed:@"PlayerAtlas"];
        self.shared = [[ASSharedAssets alloc]init];
        self.theme1 = [[ASTheme1Assets alloc]init];
        self.theme2 = [[ASTheme2Assets alloc]init];
        self.theme3 = [[ASTheme3Assets alloc]init];
        self.theme4 = [[ASTheme4Assets alloc]init];
    }
    return self;
}

@end
