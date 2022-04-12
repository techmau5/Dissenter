//
//  ASPlayerHeadNode.h
//  Dissenter
//
//  Created by Adrian Siwy on 1/26/14.
//  Copyright (c) 2014 adriansiwy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASPlayerHeadNode : SKNode

-(id)initWithAssets:(SKTextureAtlas*)atlas;

@property SKSpriteNode *head, *headBack, *antenna, *eyes, *eyebrows;

@end
