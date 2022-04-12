//
//  ASTheme2.h
//  Dissenter
//
//  Created by Adrian Siwy on 11/19/13.
//  Copyright (c) 2013 adriansiwy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASLayerNode.h"

@interface ASTheme2 : SKNode

-(void)spawnEnemyOnLayer:(ASLayerNode*)layer ForWave:(int)wave;

-(void)spawnObstacleOnLayer:(ASLayerNode*)layer ForWave:(int)wave;

-(void)spawnVisualElementOnLayer:(ASLayerNode*)layer ForWave:(int)wave;

@end
