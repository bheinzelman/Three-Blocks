//
//  GameScene.h
//  Roll
//

//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKBallNode.h"
#import "SKPlatformNode.h"
#import "PPlatformDifficulty.h"
#import "ARollScene.h"

@interface GameScene : ARollScene <SKPhysicsContactDelegate>
-(void)gameOver;

-(BOOL)returnBallsHome;

-(void)changePlatformDif;

-(void)moveBall;

-(void) incCount;

-(void)clearCount;

-(void)dealloc;

-(void)shrinkGameOverLabel;

-(BOOL)reportScore : (int)score;

@property (nonatomic, strong) SKPlatformNode* platform1;

@property (nonatomic, strong) SKPlatformNode* platform2;

@property (nonatomic, strong) SKPlatformNode* platform3;

@property (nonatomic, strong) SKBallNode* ball;

@property (strong)CMMotionManager* manager;

@property(nonatomic, strong) SKSpriteNode* leftWall;

@property(nonatomic, strong) SKSpriteNode* rightWall;

@property(nonatomic, strong) SKLabelNode* scoreLabel;

@property (nonatomic) id<PPlatformDifficulty> difficulty;

@property (nonatomic) int scoreCount;

@end
