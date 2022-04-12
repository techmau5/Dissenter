//
//  ASTheme1.m
//  Dissenter
//
//  Created by Adrian Siwy on 11/19/13.
//  Copyright (c) 2013 adriansiwy. All rights reserved.
//

#import "ASTheme1.h"
#import "ASGameScene.h"

@implementation ASTheme1

//size will vary for the layer (bigger if closer to front)

-(void)spawnEnemyOnLayer:(id)layer ForWave:(int)wave {
    
    //enemies will have a name "enemy"
    
    int type = arc4random() %4;
    
    switch (type) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            
            break;
    }
}

-(void)spawnObstacleOnLayer:(id)layer ForWave:(int)wave {
    
    //obstacles will have a name "obstacle"
    
    
}

-(void)spawnVisualElementOnLayer:(id)layer ForWave:(int)wave {
    
    //visual elements will have a name "visualElement"
    
    
}

-(void)refreshNodesOnLayer:(ASLayerNode *)layer {
    
    //enemies, obstacles, and visual elements are enumerated here... stuff like enemy shooting of moving, obstacles spinning or moving occur here.
    
}

@end
