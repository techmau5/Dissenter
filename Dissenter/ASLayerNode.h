//
//  ASLayerNode.h
//  Parallax 2.0
//
//  Created by Adrian Siwy on 10/5/13.
//  Copyright (c) 2013 Adrian Siwy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASLayerNode : SKNode

@property SKSpriteNode *bg1, *bg2, *bgQueue;

@property int type, rand;

@property BOOL spawnEnemies, spawnObstacles, spawnVisualElements;

@property float zeroDistance, lastSpawnedEnemy, lastSpawnedObstacle, lastSpawnedVisualElement, enemyBuffer, obstacleBuffer, visualElementBuffer;

//create layer mutable array
@property NSMutableArray *layerArray;

@end
