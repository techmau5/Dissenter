//
//  ASPlayerNode.h
//  Dissenter
//
//  Created by Adrian Siwy on 1/26/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASPlayerHeadNode.h"

typedef enum {up, down} rotationState;

@interface ASPlayerNode : SKSpriteNode

-(id)initInMenuWithAssets:(SKTextureAtlas*)atlas;
-(id)initInGameWithAssets:(SKTextureAtlas*)atlas;

-(void)refreshRotationWithSpeed:(float)velocity InDirection:(float)direction;

@property ASPlayerHeadNode *head;
@property SKSpriteNode *torso, *leftArm, *rightArm, *fire;

@property float maxRotate, minRotate;
@property rotationState rotationState;

@end
