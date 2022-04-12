//
//  ASPauseMenu.m
//  Dissenter
//
//  Created by Adrian Siwy on 1/1/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import "ASPauseMenu.h"

@implementation ASPauseMenu



- (id)init
{
    self = [super init];
    if (self) {
        
        CGFloat width;
        //this is now required because apple fixed width and hight switch when in landscape
        NSString *iOSVersion = [[UIDevice currentDevice] systemVersion];
        if ([iOSVersion intValue] < 8) {
            width = [UIScreen mainScreen].bounds.size.height;
        } else {
            width = [UIScreen mainScreen].bounds.size.width;
        }
        
        self.zPosition = 99;
        
        self.background = [SKSpriteNode spriteNodeWithImageNamed:@"PauseMenu"]; self.background.zPosition = -1;
        self.background.anchorPoint = CGPointMake(0, 0); self.alpha = 0; [self addChild:self.background];
        
        self.resumeButton = [SKSpriteNode spriteNodeWithImageNamed:@"ResumeButton"]; self.resumeButton.anchorPoint = CGPointMake(1, .5);
        self.resumeButton.position = CGPointMake(width + self.resumeButton.size.width, 185); [self addChild:self.resumeButton];
        
        self.mainMenuButton = [SKSpriteNode spriteNodeWithImageNamed:@"MainMenuButton"]; self.mainMenuButton.anchorPoint = CGPointMake(1, .5);
        self.mainMenuButton.position = CGPointMake(width + self.mainMenuButton.size.width, 125); [self addChild:self.mainMenuButton];
        
        self.yesButton = [SKSpriteNode spriteNodeWithImageNamed:@"YesButton"]; self.yesButton.anchorPoint = CGPointMake(1, .5);
        self.yesButton.position = CGPointMake(width + self.yesButton.size.width, 185);
        
        self.noButton = [SKSpriteNode spriteNodeWithImageNamed:@"NoButton"]; self.noButton.anchorPoint = CGPointMake(1, .5);
        self.noButton.position = CGPointMake(width + self.noButton.size.width, 125);
    }
    return self;
}

-(void)goToMainMenuConfirm {
    
    CGFloat width;
    //this is now required because apple fixed width and hight switch when in landscape
    NSString *iOSVersion = [[UIDevice currentDevice] systemVersion];
    if ([iOSVersion intValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    } else {
        width = [UIScreen mainScreen].bounds.size.width;
    }
    
    SKAction *fadeOut = [SKAction fadeOutWithDuration:.5];
    
    [self.background runAction:fadeOut];
    [self.resumeButton runAction:fadeOut];
    [self.mainMenuButton runAction:fadeOut];
    
    SKSpriteNode *newBackground = [SKSpriteNode spriteNodeWithImageNamed:@"GoToMainMenu"]; newBackground.zPosition = -1;
    newBackground.anchorPoint = CGPointMake(0, 0); newBackground.alpha = 0;
    [newBackground runAction:[SKAction sequence:@[[SKAction fadeInWithDuration:.5],[SKAction runBlock:^{
        self.background = newBackground;
    }]]]];
    [self addChild:newBackground];
    [self.yesButton runAction:[SKAction moveToX:width - 38 duration:.5]]; [self addChild:self.yesButton];
    [self.noButton runAction:[SKAction moveToX:width - 38 duration:.7]]; [self addChild:self.noButton];
    
    
}

@end
