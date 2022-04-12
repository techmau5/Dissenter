//
//  ASMyScene.m
//  Dissenter
//
//  Created by Adrian Siwy on 11/2/13.
//  Copyright (c) 2013 adriansiwy. All rights reserved.
//

#import "ASGameScene.h"
#import "ASLayerNode.h"
#import "ASThemeController.h"
#import "ASPauseMenu.h"

//default value for speedFactor
#define DEFAULT_VELOCITY 0
#define DEFAULT_MAXVEL 7

@interface ASGameScene ()

//create the pause menu
@property ASPauseMenu *pauseMenu;

//create the speedFactor
@property float velocity, maxVel;

//point locations
@property (nonatomic) CGPoint midPoint, onPoint;

//player touches
@property (nonatomic) UITouch *leftTouch, *rightTouch;

//used for regulating the time interval
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval, lastUpdateTimeInterval;

//create the timers
@property (nonatomic) NSTimer *playerTimer, *endTimer, *lazerTimer, *gameClock;

//use lazerTouchActive to determine if the user is touching the right side; use collisionInProgress to determine player accel or decel
@property BOOL collisionInProgress, leftTouchAlive, rightTouchAlive;

//test properties (to be deleted)
@property SKLabelNode *speedLabel;

//color property
@property SKSpriteNode *color;

@end

//vector math
static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint rwMult(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}

static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

@implementation ASGameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        NSLog(@"init");
        
        //initilizations
        {  
            //init the theme
            self.themeController = [[ASThemeController alloc]init];
            
            //set the speedFactor
            self.velocity = DEFAULT_VELOCITY;
            self.maxVel = DEFAULT_MAXVEL;
            
            //set the lazerTouchActive and collisionInProgress
            self.leftTouchAlive = NO;
            self.rightTouchAlive = NO;
            self.collisionInProgress = NO;
            
            //set the three needed CGPoints (we use them a bit so lets have them ahead of time)
            self.midPoint = CGPointMake(284, self.frame.size.height/2);
            self.onPoint  = CGPointMake(852, self.frame.size.height/2);
            
            //init layers
            self.layerS = [[ASLayerNode alloc]init];
            self.staticBar1 = [SKSpriteNode spriteNodeWithImageNamed:@"StaticBar"]; self.staticBar1.anchorPoint = CGPointMake(0, 0);
            self.staticBar2 = self.staticBar1.copy; self.staticBar2.anchorPoint = CGPointMake(0, 1); self.staticBar2.position = CGPointMake(0, self.frame.size.height);
            //self.environmentBlendOverlay = [SKSpriteNode spriteNodeWithColor:self.themeController.environmentBlendColor size:self.frame.size];
            //self.environmentBlendOverlay.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            self.layer1 = [[ASLayerNode alloc]init];
            self.layer2 = [[ASLayerNode alloc]init];
            self.layer3 = [[ASLayerNode alloc]init];
            self.layer4 = [[ASLayerNode alloc]init];
            self.layer5 = [[ASLayerNode alloc]init];
            self.layer6 = [[ASLayerNode alloc]init];
            self.staticBG = [SKSpriteNode spriteNodeWithImageNamed:@"staticBG"]; self.staticBG.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            
            //player animation (to be placed somewhere else)
            //for (int i = 1; i <= 18; i++) {
            //    SKTexture *frame = [self.themeController.playerAtlas textureNamed:[NSString stringWithFormat:@"b%i",i]];
            //   [playerFrames addObject:frame];
            //}
            
            //blendcolor blendmode
            //self.environmentBlendOverlay.blendMode = SKBlendModeMultiply;
            
            //init layer types
            self.layer1.type = 1;
            self.layer2.type = 2;
            self.layer3.type = 3;
            self.layer4.type = 4;
            self.layer5.type = 5;
            self.layer6.type = 6;
            
            //set the zPosition of each layer
            self.layerS.zPosition =  1; [self addChild:self.layerS];
            [self.layerS addChild:self.staticBar1]; [self.layerS addChild:self.staticBar2];
            //self.environmentBlendOverlay.zPosition = -1; [self addChild:self.environmentBlendOverlay];
            self.layer1.zPosition = -1; [self addChild:self.layer1];
            self.layer2.zPosition = -3; [self addChild:self.layer2];
            self.layer3.zPosition = -4; [self addChild:self.layer3];
            self.layer4.zPosition = -5; [self addChild:self.layer4];
            self.layer5.zPosition = -9; [self addChild:self.layer5];
            self.layer6.zPosition = -11; [self addChild:self.layer6];
            self.staticBG.zPosition = -13; [self addChild:self.staticBG];
            
            //init the default parallax bg's
            [self refreshLayer:self.layer1 WithStage:initLayers]; [self.layer1 addChild:self.layer1.bg1]; [self.layer1 addChild:self.layer1.bg2];
            [self refreshLayer:self.layer2 WithStage:initLayers]; [self.layer2 addChild:self.layer2.bg1]; [self.layer2 addChild:self.layer2.bg2];
            [self refreshLayer:self.layer3 WithStage:initLayers]; [self.layer3 addChild:self.layer3.bg1]; [self.layer3 addChild:self.layer3.bg2];
            [self refreshLayer:self.layer4 WithStage:initLayers]; [self.layer4 addChild:self.layer4.bg1]; [self.layer4 addChild:self.layer4.bg2];
            [self refreshLayer:self.layer5 WithStage:initLayers]; [self.layer5 addChild:self.layer5.bg1]; [self.layer5 addChild:self.layer5.bg2];
            [self refreshLayer:self.layer6 WithStage:initLayers]; [self.layer6 addChild:self.layer6.bg1]; [self.layer6 addChild:self.layer6.bg2];
            
            //start game clock
            self.gameClock = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshClock) userInfo:nil repeats:YES];
            
            //test label to delete
            self.speedLabel = [SKLabelNode labelNodeWithFontNamed:@"ArialMT"];
            self.speedLabel.fontSize = 20;
            self.speedLabel.position = CGPointMake(30, 10);
            self.speedLabel.fontColor = [UIColor blueColor];
            self.speedLabel.text = @"0";
            [self addChild:self.speedLabel];
            
            
            //init color
            self.color = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:self.size];
            self.color.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            self.color.blendMode = 3;
            self.color.zPosition = 200;
            [self addChild:self.color];
            
            [self changeGameStateTo:gamePlay];
        }
    }
    return self;
}

-(void)switchToMainMenuScene {
    
    SKView *spriteView = (SKView *) self.view;
    ASMainMenuScene *mainMenu = [ASMainMenuScene sceneWithSize:self.frame.size];
    mainMenu.scaleMode = SKSceneScaleModeAspectFill;
    mainMenu.backgroundColor = [SKColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
    [spriteView presentScene:mainMenu];
}

-(void)changeGameStateTo:(gameState)state {
    
    switch (state) {
        case gamePlay: {
            self.gameState = gamePlay;
            self.pauseButton = [SKSpriteNode spriteNodeWithImageNamed:@"PauseButton"]; self.pauseButton.position = CGPointMake(self.frame.size.width - 10, 312.5);
            self.pauseButton.alpha = 0; [self.pauseButton runAction:[SKAction fadeInWithDuration:2]]; self.pauseButton.zPosition = 100;
            [self addChild:self.pauseButton];
        }
            break;
        case pauseMenu: {
            self.gameState = pauseMenu;
            self.pauseMenu = [[ASPauseMenu alloc]init]; [self.pauseMenu runAction:[SKAction fadeInWithDuration:.5]];
            [self.pauseMenu.resumeButton runAction:[SKAction moveToX:self.frame.size.width - 38 duration:.5]];
            [self.pauseMenu.mainMenuButton runAction:[SKAction moveToX:self.frame.size.width - 38 duration:.7]];
            [self addChild:self.pauseMenu];
        }
            break;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.color removeFromParent];
    
    switch (self.gameState) {
        case gamePlay: {
            for (UITouch *touch in touches) {
                CGPoint location = [touch locationInNode:self];
                
                if ([(SKSpriteNode*)[self nodeAtPoint:location] isEqual:self.pauseButton]) {
                    [self changeGameStateTo:pauseMenu];
                    break;
                }
                
                if (location.x < self.frame.size.width/2 && self.leftTouchAlive == NO) {
                    
                    self.leftTouchAlive = YES;
                    self.leftTouch = touch;
                    [self.endTimer invalidate];
                    [self.playerTimer invalidate];
                    self.playerTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(movePlayer) userInfo:nil repeats:YES];
                }
                
                if (location.x >= self.frame.size.width/2 && self.rightTouchAlive == NO) {
                    
                    self.rightTouchAlive = YES;
                    self.rightTouch = touch;
                    [self.lazerTimer invalidate];
                    //[self createProjectile]; this could be added for a super shoot mode "shoots right when screen is tapped"
                    self.lazerTimer = [NSTimer scheduledTimerWithTimeInterval:.25 target:self selector:@selector(createProjectile) userInfo:nil repeats:YES];
                }
            }
        }
            break;
        case pauseMenu: {
            
        }
            break;
    }
    
    [self addChild:self.color];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    switch (self.gameState) {
        case gamePlay: {
            
        }
            break;
        case pauseMenu: {
            
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.color removeFromParent];
    
    switch (self.gameState) {
        case gamePlay: {
            for (UITouch *touch in touches) {
                
                if (touch == self.leftTouch) {
                    self.leftTouchAlive = NO;
                    self.endTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopTimer) userInfo:nil repeats:NO];
                } else if (touch == self.rightTouch) {
                    self.rightTouchAlive = NO;
                    [self.lazerTimer invalidate];
                }
            }
        }
            break;
        case pauseMenu: {
            for (UITouch *touch in touches) {
                CGPoint location = [touch locationInNode:self];
                
                if ([(SKSpriteNode*)[self nodeAtPoint:location] isEqual:self.pauseMenu.resumeButton] && self.pauseMenu.resumeButton.alpha == 1) {
                    [self.pauseMenu runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:.5],[SKAction removeFromParent]]]];
                    [self.pauseMenu.resumeButton runAction:[SKAction sequence:@[[SKAction moveToX:self.frame.size.width - 250 duration:.5],[SKAction fadeOutWithDuration:.5],[SKAction moveToX:self.frame.size.width - 38 duration:0],[SKAction removeFromParent]]]];
                    [self changeGameStateTo:gamePlay];
                    
                } else if ([(SKSpriteNode*)[self nodeAtPoint:location] isEqual:self.pauseMenu.mainMenuButton] && self.pauseMenu.mainMenuButton.alpha == 1) {
                    [self.pauseMenu.mainMenuButton runAction:[SKAction moveToX:self.frame.size.width - 250 duration:.5]];
                    self.pauseMenu.mainMenuButton.alpha = .9;
                    [self.pauseMenu goToMainMenuConfirm];
                    
                } else if ([(SKSpriteNode*)[self nodeAtPoint:location] isEqual:self.pauseMenu.yesButton] && self.pauseMenu.yesButton.alpha == 1) {
                    SKSpriteNode *shade = [SKSpriteNode spriteNodeWithImageNamed:@"logo.png"];
                    shade.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
                    shade.zPosition = 100; shade.alpha = 0;
                    [shade runAction:[SKAction fadeInWithDuration:.5]];
                    [self addChild:shade];
                    [self.pauseMenu.yesButton runAction:[SKAction fadeOutWithDuration:.5]];
                    [self.pauseMenu.noButton runAction:[SKAction fadeOutWithDuration:.5]];
                    [self.pauseMenu.yesButton runAction:[SKAction sequence:@[[SKAction moveToX:self.frame.size.width - 250 duration:.5],[SKAction performSelector:@selector(switchToMainMenuScene) onTarget:self]]]];
                    
                } else if ([(SKSpriteNode*)[self nodeAtPoint:location] isEqual:self.pauseMenu.noButton] && self.pauseMenu.noButton.alpha == 1) {
                    [self.pauseMenu.noButton runAction:[SKAction moveToX:self.frame.size.width - 250 duration:.5]];
                    ASPauseMenu *oldMenu = self.pauseMenu;
                    [oldMenu runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:.5],[SKAction runBlock:^{
                        [oldMenu removeFromParent];
                    }]]]];
                    [self changeGameStateTo:pauseMenu];
                }
            }
        }
            break;
    }
    
    [self addChild:self.color];
    
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    switch (self.gameState) {
        case gamePlay: {
            for (UITouch *touch in touches) {
                
                if (touch == self.leftTouch) {
                    self.leftTouchAlive = NO;
                    self.endTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopTimer) userInfo:nil repeats:NO];
                } else if (touch == self.rightTouch) {
                    self.rightTouchAlive = NO;
                    [self.lazerTimer invalidate];
                }
            }
        }
            break;
        case pauseMenu:
            
            break;
    }
}

-(void)movePlayer {
    
    CGPoint leftLocation = [self.leftTouch locationInNode:self];
    
    if (leftLocation.x < 150) {
        [self.player runAction:[SKAction moveToX:leftLocation.x + 50 duration:.3]];
    } else if (leftLocation.x >= 150) {
        [self.player runAction:[SKAction moveToX:200 duration:.3]];
    }
    
    if (leftLocation.y > 25 && leftLocation.y < self.frame.size.height - 25) {
        [self.player runAction:[SKAction moveToY:leftLocation.y duration:.3]];
    } else if (leftLocation.y >= self.frame.size.height - 25) {
        [self.player runAction:[SKAction moveToY:self.frame.size.height - 25 duration:.3]];
    } else if (leftLocation.y <= 25) {
        [self.player runAction:[SKAction moveToY:25 duration:.3]];
    }
}

-(void)stopTimer {
    
    [self.playerTimer invalidate];
    
}

-(void)createProjectile {
    
    SKSpriteNode *projectile = [SKSpriteNode spriteNodeWithImageNamed:@"lazer"];
    projectile.anchorPoint = CGPointMake(0, .5);
    //location based on shooting origin (eyes) change the 0's
    projectile.position = CGPointMake(self.player.position.x + 0, self.player.position.y + 0);
    projectile.alpha = .5;
    
    CGPoint offset = rwSub([self.rightTouch locationInNode:self], projectile.position);
    
    if (offset.x <= 0) return;
    
    [self runAction:self.themeController.assets.shared.playerLazer];
    [self addChild:projectile];
    
    CGPoint direction = rwNormalize(offset);
    CGPoint shootAmount = rwMult(direction, 1000);
    CGPoint realDest = rwAdd(shootAmount, projectile.position);
    projectile.zRotation = atan2f(offset.y, offset.x);
    
    float velocity = 480.0/1.0;
    float realMoveDuration = self.size.width / velocity;
    [projectile runAction:[SKAction fadeAlphaTo:1.0 duration:1/60]];
    [projectile runAction:[SKAction sequence:@[[SKAction moveTo:realDest duration:realMoveDuration], [SKAction removeFromParent]]]];
}

-(void)refreshLayer:(ASLayerNode*)layer WithStage:(refreshStage)stage {
    
    switch (stage) {
        case initLayers:
        {
            layer.bg1 = [SKSpriteNode spriteNodeWithTexture:[self.themeController.textureAtlas textureNamed:[NSString stringWithFormat:@"parallax%i%i",layer.type,0]]];
            layer.bg1.position = self.midPoint;
            layer.bg1.name = [NSString stringWithFormat:@"layer%i",layer.type];
            layer.bg2 = [SKSpriteNode spriteNodeWithTexture:[self.themeController.textureAtlas textureNamed:[NSString stringWithFormat:@"parallax%i%i",layer.type,1]]];
            layer.bg2.position = self.onPoint;
            layer.bg2.name = [NSString stringWithFormat:@"layer%i",layer.type];
            layer.rand = 2;
            layer.bgQueue = [SKSpriteNode spriteNodeWithTexture:[self.themeController.textureAtlas textureNamed:[NSString stringWithFormat:@"parallax%i%i",layer.type,layer.rand]]];
            NSLog(@"layers init");
        }
            break;
        case shiftLayers:
        {
            if (layer.position.x <= -568) {
                layer.zeroDistance = 0;
                layer.lastSpawnedEnemy = layer.lastSpawnedEnemy - 568;
                layer.lastSpawnedObstacle = layer.lastSpawnedObstacle - 568;
                layer.lastSpawnedVisualElement = layer.lastSpawnedVisualElement - 568;
                layer.position = CGPointMake(0, 0);
                [layer.bg1 removeFromParent];
                layer.bg1 = [SKSpriteNode spriteNodeWithTexture:layer.bg2.texture];
                layer.bg1.position = self.midPoint;
                layer.bg1.name = [NSString stringWithFormat:@"layer%i",layer.type];
                [layer addChild:layer.bg1];
                [layer.bg2 removeFromParent];
                layer.bg2 = layer.bgQueue;
                layer.bg2.position = self.onPoint;
                layer.bg2.name = [NSString stringWithFormat:@"layer%i",layer.type];
                [layer addChild:layer.bg2];
                layer.rand = arc4random() %3 +1;
                //gcd can be used here \/ \/
                layer.bgQueue = [SKSpriteNode spriteNodeWithTexture:[self.themeController.textureAtlas textureNamed:[NSString stringWithFormat:@"parallax%i%i",layer.type,layer.rand]]];
                
                //moves layer mutable array (sprites on layer) also deletes objects that are offscreen
                NSMutableArray *toDelete = [NSMutableArray array];
                for (SKSpriteNode *sprite in layer.layerArray) {
                    
                    if (sprite.position.x < 568) {
                        NSLog(@"sprite deleted");
                        [sprite removeFromParent];
                        [toDelete addObject:sprite];
                    } else {
                        NSLog(@"sprite moved");
                        sprite.position = CGPointMake(sprite.position.x -568, sprite.position.y);
                    }
                }
                [layer.layerArray removeObjectsInArray:toDelete];
                NSLog(@"layers refresh");
            }
        }
            break;
        case waveTransition:
        {
            //wave transition
        }
            break;
        case areaTransition:
        {
            //area transition
        }
            break;
        case themeTransition:
        {
            //theme transition
        }
            break;
    }
}

-(void)moveLayers {
    
    //adds new distance to overall distance
    self.themeController.currentDistance += self.velocity;
    
    //moves the layers based on speedFactor at 60fps
    //changing the duration allows for gradual speed change
    SKAction* move = [SKAction moveByX:-1*self.velocity y:0 duration:1/60]; self.layer1.zeroDistance += self.velocity;
    [self.layer1 runAction:move];
    move = [SKAction moveByX:-self.velocity/1.5 y:0 duration:1/60]; self.layer2.zeroDistance += self.velocity/1.5;
    [self.layer2 runAction:move];
    move = [SKAction moveByX:-self.velocity/2 y:0 duration:1/60]; self.layer3.zeroDistance += self.velocity/2;
    [self.layer3 runAction:move];
    move = [SKAction moveByX:-self.velocity/3 y:0 duration:1/60]; self.layer4.zeroDistance += self.velocity/3;
    [self.layer4 runAction:move];
    move = [SKAction moveByX:-self.velocity/4 y:0 duration:1/60]; self.layer5.zeroDistance += self.velocity/4;
    [self.layer5 runAction:move];
    move = [SKAction moveByX:-self.velocity/5 y:0 duration:1/60]; self.layer6.zeroDistance += self.velocity/5;
    [self.layer6 runAction:move];
}

-(void)refreshLayers {
    //refreshes the layer positions (calls moveLayers) and calls refreshLayer to check for a bg change
    [self moveLayers];
    
    [self refreshLayer:self.layer1 WithStage:shiftLayers];
    [self refreshLayer:self.layer2 WithStage:shiftLayers];
    [self refreshLayer:self.layer3 WithStage:shiftLayers];
    [self refreshLayer:self.layer4 WithStage:shiftLayers];
    [self refreshLayer:self.layer5 WithStage:shiftLayers];
    [self refreshLayer:self.layer6 WithStage:shiftLayers];
}

-(void)acceleratePlayer {
    
    //this is where collision speed reduction and speed change takes place
    //this is laggy in the simulator use "test" project to reference this
    //  *still needed: if player collides with obstacle at very edge...
    
    if (self.collisionInProgress == NO) {
        if (self.velocity < 3) {
            self.velocity += .04 * (self.maxVel/7);
        } else if (self.velocity < self.maxVel) {
            self.velocity += .01 * (self.maxVel/7);
        }
    } else if (self.collisionInProgress == YES) {
        if (self.velocity > 0) {
            self.velocity -= .1;
        } else if (self.velocity < 0) {
            self.velocity = 0;
        }
    }
}

-(void)refreshClock {
    
    self.themeController.overallTime += 1;
    
}

-(void)createCountdownTimerWithTime:(int)seconds {
    
    self.themeController.countdownInt = seconds;
    self.themeController.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    
}

-(void)countdown {
    
    self.themeController.countdownInt -= 1;
    
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 1/60) {
        self.lastSpawnTimeInterval = 0;
        [self refreshLayers];
        [self acceleratePlayer];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    switch (self.gameState) {
        case gamePlay: {
            //test to be deleted
            self.speedLabel.text = [NSString stringWithFormat:@"%.2f",self.velocity];
            
            [self.themeController refreshThemeController];
            [self.themeController refreshLayersOnScene:self];
            
            // Handle time delta.
            // If we drop below 60fps, we still want everything to move the same distance.
            CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
            self.lastUpdateTimeInterval = currentTime;
            if (timeSinceLast > 1) { // more than a second since last update
                timeSinceLast = 1.0 / 60.0;
                self.lastUpdateTimeInterval = currentTime;
            }
            [self updateWithTimeSinceLastUpdate:timeSinceLast];
        }
            break;
        case pauseMenu:{
            
        }
            break;
    }
}
@end
