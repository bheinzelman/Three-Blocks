//
//  IntroScene.h
//  Roll
//
//  Created by Bert Heinzelman on 6/28/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

#include "ARollScene.h"

@interface IntroScene : ARollScene <GKGameCenterControllerDelegate>

-(void)bounceEmblem;

-(void)buttonPressed;

-(void)presentHighScores;

-(void)dealloc;

//@property (nonatomic, strong) NSMutableArray* selectors;

@property (nonatomic, strong) SKSpriteNode* emblem;

@property (nonatomic, strong) SKSpriteNode* playButton;

@end
