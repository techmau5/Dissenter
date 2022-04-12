//
//  ASMyScene.h
//  Dissenter
//

//  Copyright (c) 2013 adriansiwy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASLayerNode.h"
#import "ASAssets.h"
#import "ASMainMenuScene.h"
#import "ASThemeController.h"
#import "ASPlayerNode.h"

typedef enum {gamePlay, pauseMenu} gameState;
typedef enum {initLayers, shiftLayers, waveTransition, areaTransition, themeTransition} refreshStage;

@interface ASGameScene : SKScene
{
    @public ASAssets *assets;
}

-(void)changeGameStateTo:(gameState)state;

-(void)refreshLayer:(ASLayerNode*)layer WithStage:(refreshStage)stage;

-(void)createCountdownTimerWithTime:(int)seconds;

//create the theme
@property ASThemeController *themeController;

//creates an integer that displays the game's state (switch statements in the code determine what happens)
@property gameState gameState;

//layer for UI and static forground and layer for enemies and bosses
@property (nonatomic) ASLayerNode *layerS;

//create each parallax layer
@property (nonatomic) ASLayerNode *layer1, *layer2, *layer3, *layer4, *layer5, *layer6;

//create the player
@property (nonatomic) ASPlayerNode *player;

//create the player and the static background, pause menu button, and the blend overlay for the environment
@property (nonatomic) SKSpriteNode *staticBG, *pauseButton, *environmentBlendOverlay, *staticBar1, *staticBar2;

@end
