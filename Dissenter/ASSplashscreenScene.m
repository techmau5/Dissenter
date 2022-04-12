//
//  ASSplashscreenScene.m
//  Dissenter
//
//  Created by Adrian Siwy on 6/7/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import "ASSplashscreenScene.h"
#import "ASMainMenuScene.h"

@implementation ASSplashscreenScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode *logo = [SKSpriteNode spriteNodeWithImageNamed:@"logo"];
        logo.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        logo.alpha = 0;
        [self addChild:logo];
        
        SKSpriteNode *logoGradient = [SKSpriteNode spriteNodeWithImageNamed:@"logoGradient"];
        logoGradient.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        logoGradient.alpha = 0;
        logoGradient.blendMode = 2;
        
        [self addChild:logoGradient];
        
        [logo runAction:[SKAction fadeInWithDuration:2]];
        [logoGradient runAction:[SKAction sequence:@[[SKAction waitForDuration:1.5],[SKAction fadeInWithDuration:2],[SKAction performSelector:@selector(switchToMainMenuScene) onTarget:self]]]];
        
    }
    return self;
}

-(void)switchToMainMenuScene {
    
    //pass nodes from the main menu to the gameScene here
    
    SKView *skView = (SKView *) self.view;
    ASMainMenuScene *scene = [ASMainMenuScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.backgroundColor = [SKColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
    SKTransition *none = [SKTransition crossFadeWithDuration:0];
    [skView presentScene:scene transition:none];
}

@end
