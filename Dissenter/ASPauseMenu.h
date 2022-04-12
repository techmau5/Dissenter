//
//  ASPauseMenu.h
//  Dissenter
//
//  Created by Adrian Siwy on 1/1/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASPauseMenu : SKNode

-(void)goToMainMenuConfirm;

@property SKSpriteNode *background, *resumeButton, *mainMenuButton, *yesButton, *noButton;

@end
