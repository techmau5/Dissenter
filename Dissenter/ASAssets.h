//
//  ASAssets.h
//  Dissenter
//
//  Created by Adrian Siwy on 12/28/13.
//  Copyright (c) 2013 adriansiwy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASSharedAssets.h"
#import "ASTheme1Assets.h"
#import "ASTheme2Assets.h"
#import "ASTheme3Assets.h"
#import "ASTheme4Assets.h"

@interface ASAssets : SKNode

//assets are loaded here as properties of ASAssets

@property SKTextureAtlas *player;

@property ASSharedAssets *shared;
@property ASTheme1Assets *theme1;
@property ASTheme2Assets *theme2;
@property ASTheme3Assets *theme3;
@property ASTheme4Assets *theme4;

@end
