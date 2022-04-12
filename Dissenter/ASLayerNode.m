//
//  ASLayerNode.m
//  Parallax 2.0
//
//  Created by Adrian Siwy on 10/5/13.
//  Copyright (c) 2013 Adrian Siwy. All rights reserved.
//

#import "ASLayerNode.h"

@implementation ASLayerNode

- (id)init
{
    self = [super init];
    if (self) {
        self.bg1 = [[SKSpriteNode alloc]init]; self.bg1.zPosition = -1;
        self.bg2 = [[SKSpriteNode alloc]init]; self.bg2.zPosition = -1;
        self.rand = 1;
        self.zeroDistance = 0;
        self.lastSpawnedEnemy = 0;
        self.lastSpawnedObstacle = 0;
        self.lastSpawnedVisualElement = 0;
        
        //buffers and BOOLs will be changed according to the first area
        self.enemyBuffer = 40;
        self.obstacleBuffer = 40;
        self.visualElementBuffer = 40;
        self.spawnEnemies = YES;
        self.spawnObstacles = YES;
        self.spawnVisualElements = YES;
        
        self.layerArray = [NSMutableArray array];
        [self addChild:self.bg1];
        [self addChild:self.bg2];
    }
    return self;
}

@end
