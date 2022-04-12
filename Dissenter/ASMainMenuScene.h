//
//  ASMainMenuScene.h
//  Dissenter
//
//  Created by Adrian Siwy on 1/1/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASViewController.h"
#import "ASOptionsNode.h"
#import "ASGameScene.h"
#import "ASPlayerNode.h"

typedef enum {mainMenu, optionsMenu, aboutPage} menuState;

@interface ASMainMenuScene : SKScene

//to replace the ASMainMenuNode and the merged main menu in ASGameScene

-(void)changeMenuStateTo:(menuState)state;

@property ASPlayerNode *player;

@property SKSpriteNode *title, *aboutPage, *shade, *layer1, *layer2, *layer3, *layer4, *layer5, *layer6, *staticBG, *optionsButton, *playButton, *trialsButton, *aboutButton, *staticBar1, *staticBar2;
@property ASOptionsNode *optionsMenu;

@property menuState menuState;

@end
