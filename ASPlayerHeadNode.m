//
//  ASPlayerHeadNode.m
//  Dissenter
//
//  Created by Adrian Siwy on 1/26/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import "ASPlayerHeadNode.h"

@implementation ASPlayerHeadNode

- (id)initWithAssets:(SKTextureAtlas *)atlas {
    self = [super init];
    if (self) {
        self.head = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerHead"]]];
        self.headBack = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerHeadBack"]]];
        self.antenna = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerAntenna"]]];
        self.eyes = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerEyes"]]];
        self.eyebrows = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerEyebrows"]]];
    }
    return self;
}

@end
