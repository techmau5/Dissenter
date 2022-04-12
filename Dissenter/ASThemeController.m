//
//  ASTheme.m
//  Dissenter
//
//  Created by Adrian Siwy on 11/2/13.
//  Copyright (c) 2013 adriansiwy. All rights reserved.
//

#import "ASThemeController.h"
#import "ASGameScene.h"
#import "ASTheme1.h"
#import "ASTheme2.h"
#import "ASTheme3.h"
#import "ASTheme4.h"

@implementation ASThemeController

- (id)init
{
    self = [super init];
    if (self) {
        self.themeNumber = 1;
        self.waveNumber = 1;
        self.textureAtlas = [SKTextureAtlas atlasNamed:@"theme3"];
        self.theme = [[ASTheme1 alloc]init];
        self.spawnNodes = YES;
        self.requiredDistance = 10000;
        
        //init the default colors
    }
    return self;
}

-(void)addToMainMenu:(ASMainMenuScene *)menu {
    
    
    
}

-(void)refreshBlendColorsOnScene:(ASGameScene *)scene {
    
    
    
}

-(void)refreshThemeController {
    
    if (self.countdownInt <= 0) {
        [self.countdownTimer invalidate];
        //game over here
    }
    
    if (self.waveNumber %4 != 0) {
        if (self.currentDistance >= self.requiredDistance) {
            self.waveNumber += 1;
            [self changeWave];
        }
    } else if (self.waveNumber %4 == 0) {
        if (self.enemiesKilled >= self.requiredKills) {
            if (self.waveNumber != 16) {
                self.waveNumber += 1;
                [self changeArea];
                [self changeWave];
            } else if (self.waveNumber == 16) {
                self.themeNumber += 1;
                self.waveNumber = 1;
                [self changeTheme];
                [self changeArea];
                [self changeWave];
            }
        }
    }
}

-(void)refreshLayersOnScene:(ASGameScene *)scene {
    
    //handling of layerS to be determined...
    [self refreshLayer:scene.layer1];
    [self refreshLayer:scene.layer2];
    [self refreshLayer:scene.layer3];
    [self refreshLayer:scene.layer4];
    [self refreshLayer:scene.layer5];
    [self refreshLayer:scene.layer6];
    
    [self.theme refreshNodesOnLayer:scene.layerS];
    [self.theme refreshNodesOnLayer:scene.layer1];
    [self.theme refreshNodesOnLayer:scene.layer2];
    [self.theme refreshNodesOnLayer:scene.layer3];
    [self.theme refreshNodesOnLayer:scene.layer4];
    [self.theme refreshNodesOnLayer:scene.layer5];
    [self.theme refreshNodesOnLayer:scene.layer6];
}

-(void)refreshLayer:(ASLayerNode *)layer {
    
    if (self.spawnNodes != YES) return;
    
    if (layer.spawnEnemies) {
        if (layer.zeroDistance >= layer.enemyBuffer + layer.lastSpawnedEnemy) {
            layer.lastSpawnedEnemy = layer.zeroDistance;
            [self.theme spawnEnemyOnLayer:layer ForWave:self.waveNumber];
            //NSLog(@"enemy spawned on layer%i",layer.type);
            //here the enemy in the queue will be spawned and a new enemy will be created in the queue
        }
    }
    
    if (layer.spawnObstacles) {
        if (layer.zeroDistance >= layer.obstacleBuffer + layer.lastSpawnedObstacle) {
            layer.lastSpawnedObstacle = layer.zeroDistance;
            [self.theme spawnObstacleOnLayer:layer ForWave:self.waveNumber];
            //NSLog(@"obstacle spawned on layer%i",layer.type);
            //here the obstacle in the queue will be spawned and a new obstacle will be created in the queue
        }
    }
    
    if (layer.spawnVisualElements) {
        if (layer.zeroDistance >= layer.visualElementBuffer + layer.lastSpawnedVisualElement) {
            layer.lastSpawnedVisualElement = layer.zeroDistance;
            [self.theme spawnVisualElementOnLayer:layer ForWave:self.waveNumber];
            //NSLog(@"visual element spawned on layer%i",layer.type);
            //here the visual element in the queue will be spawned and a new visual element will be created in the queue
        }
    }
    
    //shared visual elements will also be controlled here
    
}

-(void)changeTheme {
    //switches the assets and effects to the next theme
    
    self.spawnNodes = NO;
    
    
}

-(void)changeArea {
    
    
    
}

-(void)changeWave {
    
    
    
}

-(void)createSharedVisualElement:(int)ofType {
    // mist, dust, shake... (controlled effects)
    
    
}

@end
