//
//  ASViewController.m
//  Dissenter
//
//  Created by Adrian Siwy on 11/2/13.
//  Copyright (c) 2013 adriansiwy. All rights reserved.
//

#import "ASViewController.h"
#import "ASAssets.h"

@implementation ASViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.multipleTouchEnabled = YES;
    
    // Create and configure the scene.
    ASSplashscreenScene *scene = [ASSplashscreenScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.backgroundColor = [SKColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
    
    // Present the scene.
    [skView presentScene:scene];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
