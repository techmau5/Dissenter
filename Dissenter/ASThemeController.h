//
//  ASTheme.h
//  Dissenter
//
//  Created by Adrian Siwy on 11/2/13.
//  Copyright (c) 2013 adriansiwy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASEnemyNode.h"
#import "ASObstacleNode.h"
#import "ASVisualElementNode.h"
@class ASMainMenuScene;
@class ASGameScene;
@class ASAssets;

@interface ASThemeController : SKNode

-(void)addToMainMenu:(ASMainMenuScene*)menu;

-(void)refreshThemeController;

-(void)refreshLayersOnScene:(ASGameScene*)scene;

-(void)changeTheme;
-(void)changeArea;
-(void)changeWave;

-(void)refreshBlendColorsOnScene:(ASGameScene*)scene;

@property int themeNumber, waveNumber, currentDistance, requiredDistance, enemiesKilled, requiredKills, totalElapsedTime, timeSinceTimerStart, overallTime, countdownInt;

@property ASEnemyNode *enemyQueue;
@property ASObstacleNode *obstacleQueue;
@property ASVisualElementNode *visualElementQueue;

//all of the games assets are loaded in before the ASGameScene is loaded and passed here...
@property ASAssets *assets;

@property BOOL spawnNodes;

@property (nonatomic) SKTextureAtlas *textureAtlas;

//create the menu, player, enemy, and environment blend colors;
@property SKColor *envColor1, *envColor2, *activeColor1, *activeColor2, *playerColor;

@property id theme;

@property NSTimer *countdownTimer;



@end
