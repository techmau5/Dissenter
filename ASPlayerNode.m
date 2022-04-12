//
//  ASPlayerNode.m
//  Dissenter
//
//  Created by Adrian Siwy on 1/26/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import "ASPlayerNode.h"

@implementation ASPlayerNode

- (id)initInMenuWithAssets:(SKTextureAtlas *)atlas {
    self = [super init];
    if (self) {
        [self setScale:.3];
        self.torso = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerTorso"]]];
        self.torso.zRotation = 1.57;
        [self addChild:self.torso];
        
        self.leftArm = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerLeftArm"]]];
        //[self.leftArm runAction:[SKAction rotateToAngle:0 duration:0]];
        self.leftArm.anchorPoint = CGPointMake(.9, .9);
        self.leftArm.position = CGPointMake(100, 8);
        [self addChild:self.leftArm];
        
        self.rightArm = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerRightArm"]]];
        [self addChild:self.rightArm];
        
        self.head = [[ASPlayerHeadNode alloc]initWithAssets:atlas];
        [self addChild:self.head];
    }
    return self;
}

-(id)initInGameWithAssets:(SKTextureAtlas *)atlas {
    self = [super init];
    if (self) {
        
        [self setScale:.3];
        self.torso = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerTorso"]]];
        self.zRotation = 5.5;
        [self addChild:self.torso];
        
        self.leftArm = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerLeftArm"]]];
        self.leftArm.anchorPoint = CGPointMake(.9, .9);
        self.leftArm.zRotation = -.35;
        self.leftArm.position = CGPointMake(-30, 6);
        [self addChild:self.leftArm];
        
        //self.rightArm = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerRightArm"]]];
        //[self addChild:self.rightArm];
        
        //self.head = [[ASPlayerHeadNode alloc]initWithAssets:atlas];
        //[self addChild:self.head];
        
        //self.fire = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:[NSString stringWithFormat:@"PlayerFire1"]]];
        
        self.rotationState = up;
    }
    return self;
}

-(void)refreshRotationWithSpeed:(float)velocity InDirection:(float)direction {
    
    self.maxRotate = -.35 + velocity/4 + direction;
    self.minRotate = 0 - velocity/4 - direction;
    
    
    if (self.rotationState == up) {
        
        
        
    } else if (self.rotationState == down) {
        
        
        
    }
    
}

@end
