//
//  ASMainMenuScene.m
//  Dissenter
//
//  Created by Adrian Siwy on 1/1/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import "ASMainMenuScene.h"
#import "ASGameScene.h"
#import "ASThemeController.h"

@implementation ASMainMenuScene

ASGameScene *gameScene;
SKSpriteNode *color;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //init the shade
        {
            self.shade = [SKSpriteNode spriteNodeWithImageNamed:@"logo"];
            self.shade.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            self.shade.zPosition = 100;
            self.shade.blendMode = 0;
            [self addChild:self.shade];
        }
        
        //init ASGameScene
        {
            gameScene = [ASGameScene sceneWithSize:size];
            gameScene.scaleMode = SKSceneScaleModeAspectFill;
            ASAssets* assets = [[ASAssets alloc]init];
            gameScene.themeController.assets = assets;
            gameScene.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        }
        
        //init game layers and player
        {
            self.staticBar1 = gameScene.staticBar1.copy; [self.staticBar1 removeFromParent]; [self addChild:self.staticBar1];
            self.staticBar2 = gameScene.staticBar2.copy; [self.staticBar2 removeFromParent]; [self addChild:self.staticBar2];
            self.player = [[ASPlayerNode alloc]initInMenuWithAssets:gameScene.themeController.assets.player]; self.player.position = CGPointMake(16, 20); [self addChild:self.player];
            //gamescene player created here because doing so in the gamescene doesnt work for some stupid reason
            gameScene.player = [[ASPlayerNode alloc]initInGameWithAssets:gameScene.themeController.assets.player]; gameScene.player.position = CGPointMake(60, self.frame.size.height/2); [gameScene addChild:gameScene.player];
            self.layer1 = (SKSpriteNode*)gameScene.layer1.copy; [self.layer1 removeFromParent]; [self addChild:self.layer1];
            self.layer2 = (SKSpriteNode*)gameScene.layer2.copy; [self.layer2 removeFromParent]; [self addChild:self.layer2];
            self.layer3 = (SKSpriteNode*)gameScene.layer3.copy; [self.layer3 removeFromParent]; [self addChild:self.layer3];
            self.layer4 = (SKSpriteNode*)gameScene.layer4.copy; [self.layer4 removeFromParent]; [self addChild:self.layer4];
            self.layer5 = (SKSpriteNode*)gameScene.layer5.copy; [self.layer5 removeFromParent]; [self addChild:self.layer5];
            self.layer6 = (SKSpriteNode*)gameScene.layer6.copy; [self.layer6 removeFromParent]; [self addChild:self.layer6];
            self.staticBG = gameScene.staticBG.copy; [self.staticBG removeFromParent]; [self addChild:self.staticBG];
        }
        
        //init menu items
        {
            self.title = [SKSpriteNode spriteNodeWithImageNamed:@"dissenter"];
            self.title.position = CGPointMake(150, 290); [self addChild:self.title]; self.title.name = @"menuItem";
            
            self.optionsButton = [SKSpriteNode spriteNodeWithImageNamed:@"OptionsButton"];
            self.optionsButton.position = CGPointMake(self.frame.size.width - 28, 290); [self addChild:self.optionsButton]; self.optionsButton.name = @"menuItem";
            
            self.playButton = [SKSpriteNode spriteNodeWithImageNamed:@"PlayButton"]; self.playButton.anchorPoint = CGPointMake(1, .5);
            [self addChild:self.playButton]; self.playButton.name = @"menuItem";
            
            self.trialsButton = [SKSpriteNode spriteNodeWithImageNamed:@"TrialsButton"]; self.trialsButton.anchorPoint = CGPointMake(1, .5);
            [self addChild:self.trialsButton]; self.trialsButton.name = @"menuItem";
            
            self.aboutButton = [SKSpriteNode spriteNodeWithImageNamed:@"AboutButton"]; self.aboutButton.anchorPoint = CGPointMake(1, .5);
            [self addChild:self.aboutButton]; self.aboutButton.name = @"menuItem";
            
            self.optionsMenu = [[ASOptionsNode alloc]init]; self.optionsMenu.zPosition = 1; [self addChild:self.optionsMenu];
            self.optionsMenu.position = CGPointMake(self.frame.size.width, 0);
            
            self.aboutPage = [SKSpriteNode spriteNodeWithImageNamed:@"AboutPage"];
            self.aboutPage.zPosition = 1; self.aboutPage.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2); self.aboutPage.alpha = 0;
        }
        
        //init color
        {
            color = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:self.size];
            color.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            color.blendMode = 3;
            color.zPosition = 200;
            [self addChild:color];
        }
            
        [self changeMenuStateTo:mainMenu];
        
    }
    return self;
}

-(void)changeMenuStateTo:(menuState)state {
    
    switch (state) {
        case mainMenu: {
            self.menuState = mainMenu;
            self.playButton.position = CGPointMake(self.frame.size.width + self.playButton.size.width, 220); [self.playButton runAction:[SKAction sequence:@[[SKAction waitForDuration:.5],[SKAction moveToX:self.size.width - 38 duration:.4]]]];
            self.trialsButton.position = CGPointMake(self.frame.size.width + self.trialsButton.size.width, 160); [self.trialsButton runAction:[SKAction sequence:@[[SKAction waitForDuration:.5],[SKAction moveToX:self.size.width - 38 duration:.6]]]];
            self.aboutButton.position = CGPointMake(self.frame.size.width + self.aboutButton.size.width, 100); [self.aboutButton runAction:[SKAction sequence:@[[SKAction waitForDuration:.5],[SKAction moveToX:self.size.width - 38 duration:.8]]]];
            [self.shade runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:2],[SKAction removeFromParent]]]];
        }
            break;
        case optionsMenu: {
            self.menuState = optionsMenu;
        }
            break;
        case aboutPage: {
            self.menuState = aboutPage;
            [self.aboutPage runAction:[SKAction fadeInWithDuration:.5]];
            [self addChild:self.aboutPage];
        }
            break;
    }
    
}

-(void)switchToGameScene {
    
    //pass nodes from the main menu to the gameScene here
    
    SKView *spriteView = (SKView *) self.view;
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    gameScene.backgroundColor = [SKColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
    SKTransition *none = [SKTransition crossFadeWithDuration:0];
    [spriteView presentScene:gameScene transition:none];
}

-(void)switchToTrialsScene {
    
    NSLog(@"load trials scene");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [color removeFromParent];
    
    switch (self.menuState) {
        case mainMenu: {
            for (UITouch* touch in touches) {
                CGPoint location = [touch locationInNode:self];
                
                if ([(SKSpriteNode*)[self nodeAtPoint:location] isEqual:self.playButton]) {
                    [self enumerateChildNodesWithName:@"menuItem" usingBlock:^(SKNode *node, BOOL *stop) {
                        [node runAction:[SKAction fadeOutWithDuration:1]];
                    }];
                    [self.playButton runAction:[SKAction sequence:@[[SKAction moveToX:self.frame.size.width - 250 duration:1],[SKAction performSelector:@selector(switchToGameScene) onTarget:self]]]];
                    
                } else if ([(SKSpriteNode*)[self nodeAtPoint:location] isEqual:self.optionsButton]) {
                    if (self.optionsMenu.position.x == self.frame.size.width) {
                        [self.optionsButton runAction:[SKAction moveToX:self.frame.size.width - 200 duration:.5]];
                        [self.optionsButton runAction:[SKAction fadeOutWithDuration:.5]];
                        [self.optionsButton runAction:[SKAction rotateByAngle:-90 duration:.7]];
                        [self.optionsMenu runAction:[SKAction moveToX:self.frame.size.width - 200 duration:.5]];
                        [self.optionsMenu runAction:[SKAction fadeInWithDuration:.5]];
                        [self changeMenuStateTo:optionsMenu];
                    }
                } else if ([(SKSpriteNode*)[self nodeAtPoint:location] isEqual:self.trialsButton]) {
                    [self.trialsButton runAction:[SKAction fadeOutWithDuration:.5]];
                    [self.trialsButton runAction:[SKAction sequence:@[[SKAction moveToX:self.frame.size.width - 250 duration:1],[SKAction performSelector:@selector(switchToTrialsScene) onTarget:self]]]];
                    
                } else if ([(SKSpriteNode*)[self nodeAtPoint:location] isEqual:self.aboutButton]) {
                    [self.aboutButton runAction:[SKAction fadeOutWithDuration:.5]];
                    [self.aboutButton runAction:[SKAction sequence:@[[SKAction moveToX:self.frame.size.width - 250 duration:1],[SKAction moveToX:self.frame.size.width - 38 duration:0]]]];
                    [self changeMenuStateTo:aboutPage];
                }
            }
        }
            break;
        case optionsMenu:
        {
            for (UITouch* touch in touches) {
                CGPoint location = [touch locationInNode:self];
                if (self.optionsMenu.position.x == self.frame.size.width - 200 && location.x < self.frame.size.width - 200) {
                    [self.optionsButton runAction:[SKAction moveToX:self.frame.size.width - 28 duration:.5]];
                    [self.optionsButton runAction:[SKAction fadeInWithDuration:.5]];
                    [self.optionsButton runAction:[SKAction rotateByAngle:90 duration:.7]];
                    [self.optionsMenu runAction:[SKAction moveToX:self.frame.size.width duration:.5]];
                    [self.optionsMenu runAction:[SKAction fadeOutWithDuration:.5]];
                    [self changeMenuStateTo:mainMenu];
                }
            }
        }
            break;
        case aboutPage:
        {
            [self.aboutPage runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:.7],[SKAction removeFromParent]]]];
            [self.aboutButton removeAllActions]; self.aboutButton.position = CGPointMake(self.frame.size.width - 38, 100);
            [self.aboutButton runAction:[SKAction fadeInWithDuration:.5]];
            [self changeMenuStateTo:mainMenu];
            
        }
            break;
    }
    
    [self addChild:color];
    
}

-(void)update:(NSTimeInterval)currentTime {
    
    //[gameScene.themeController addToMainMenu:self];
    
}

@end
