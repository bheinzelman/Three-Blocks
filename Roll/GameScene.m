//
//  GameScene.m
//  Roll
//
//  Created by Bert Heinzelman on 6/27/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import <GameKit/GameKit.h>

#import "GameScene.h"
#import "SKPlatformNode.h"
#import "SKBallNode.h"
#import "Constants.h"
#import "SELRunLoop.h"
#import "BasicPlatformDifficulty.h"

@interface GameScene()

@property (nonatomic) BOOL isGameOver;

@property (nonatomic, strong) SKSpriteNode* gameOverNode;

@property (nonatomic, strong) SKSpriteNode* backButton;

@property (nonatomic, strong) SELRunLoop* runloop;

@property (nonatomic) int shrinkCount;

@property BOOL isUp;

@end

@implementation GameScene


#pragma mark set-up
-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    _isGameOver = NO;
    
    _isUp = NO;
    
    _shrinkCount = 0;
    
    [self drawGrid];
    
    self.backgroundColor = [Constants systemBackgroundColor];
    
    self.physicsWorld.contactDelegate = self;
    
    /* Platforms */
    
    const CGSize platformSize = CGSizeMake(self.size.width / 6 , self.size.height / 16);
    
    CGPoint pos1 = CGPointMake(0, self.size.height/5.5);
    
    CGPoint pos2 = CGPointMake(self.size.width/3, self.size.height/5.5);
    
    CGPoint pos3 = CGPointMake(self.size.width*2/3, self.size.height/5.5);
    
    self.platform1 = [[SKPlatformNode alloc] init:0 xf:self.size.width/3 size:platformSize position:pos1];
    
    self.platform1.name = @"Platform1";
    
    self.platform1.anchorPoint = CGPointMake(0, self.platform1.anchorPoint.y);
    
    self.platform1.nodeSpeed = 2;
    
    self.platform2 = [[SKPlatformNode alloc] init:self.size.width/3 xf:self.size.width*2/3 size:platformSize position:pos2];
    
    self.platform2.anchorPoint = CGPointMake(0, self.platform2.anchorPoint.y);
    
    self.platform2.nodeSpeed = 2;
    
    self.platform2.name = @"Platform2";
    
    self.platform3 = [[SKPlatformNode alloc] init:self.size.width*2/3 xf:self.size.width size:platformSize position:pos3];
    
    self.platform3.anchorPoint = CGPointMake(0, self.platform3.anchorPoint.y);
    
    self.platform3.nodeSpeed = 2;
    
    self.platform3.name = @"Platform3";
    
    [self addChild:self.platform1];
    
    [self addChild:self.platform2];
    
    [self addChild:self.platform3];
    
    /* ball */
    
    CGFloat radius = (self.size.height/25);
    
    CGPoint ballPos = CGPointMake(self.size.width/2, self.size.height + radius);
    
    self.ball = [[SKBallNode alloc] init:ballPos radius:radius];
    
    self.ball.name = @"Ball";

    [self addChild:self.ball];
    
    /* Core Motion */
    
    self.manager = [[CMMotionManager alloc] init];
    
    [self.manager startAccelerometerUpdates];
    
    /* Walls */
    
    self.leftWall = [[SKSpriteNode alloc] init];
    
    self.leftWall.name = @"LeftWall";
    
    self.leftWall.position = CGPointMake(0, 0);
    
    self.leftWall.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, self.size.height)];
    
    self.leftWall.physicsBody.categoryBitMask = [Constants collisionWall];
    
    self.leftWall.physicsBody.collisionBitMask = [Constants collisionBall];
    
    self.leftWall.physicsBody.contactTestBitMask = [Constants collisionBall];
    
    [self addChild:self.leftWall];
    
    self.rightWall = [[SKSpriteNode alloc] init];
    
    self.rightWall.name = @"RightWall";
    
    self.rightWall.position = CGPointMake(0, 0);
    
    self.rightWall.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(self.size.width, 0) toPoint:CGPointMake(self.size.width, self.size.height)];
    
    self.rightWall.physicsBody.categoryBitMask = [Constants collisionWall];
    
    self.rightWall.physicsBody.collisionBitMask = [Constants collisionBall];
    
    self.rightWall.physicsBody.contactTestBitMask = [Constants collisionBall];

    [self addChild:self.rightWall];
    
    /*
     * score label
     */
    
    self.scoreLabel = [SKLabelNode labelNodeWithText:@"0"];
    
    self.scoreLabel.position = CGPointMake(self.size.width * 0.8, self.size.height * 0.7);
    
    self.scoreLabel.fontSize = 60;
    
    self.scoreLabel.fontColor = [SKColor blackColor];
    
    self.scoreLabel.fontName = @"Menlo-Bold";
    
    [self addChild:self.scoreLabel];
    
    [self clearCount];
    
    /*
     * game over text
     */
    
    self.gameOverNode = [SKSpriteNode spriteNodeWithImageNamed:@"playAgain.png"];
    
    self.gameOverNode.position = CGPointMake(self.size.width/2, self.size.height/2);
    
    
    /*
     * back button
     */
    
    /*self.backButton = [SKSpriteNode spriteNodeWithImageNamed:@"back.png"];
    
    self.backButton.position = CGPointMake(self.size.width/10, self.size.height/1.3);
    
    [self addChild:self.backButton];*/
    
    
    /*
     * run loop
     */
    
    self.runloop = [[SELRunLoop alloc] init:self];
    
    [self.runloop addSelector:@"moveBall"];
    
    
    /*
     * difficulty
     */
    
    self.difficulty = [[BasicPlatformDifficulty alloc] init];
    
    [self.difficulty initPlatforms:_platform1 platform2:_platform2 platform3:_platform3];
    
}

-(void)dealloc
{
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isGameOver)
    {
        [self.gameOverNode removeFromParent];
        
        self.ball.physicsBody.affectedByGravity = YES;
        
        [self.runloop removeSelector:@"shrinkGameOverLabel"];
        
        [self.runloop addSelector:@"moveBall"];
    }
    
    _isGameOver = NO;
}

#pragma mark update scene
-(void)update:(CFTimeInterval)currentTime
{
    [self.runloop run];
   
    if (self.ball.position.y < 0)
    {
        [self gameOver];
    }
    
    if (self.scoreCount % 10 == 0 && self.scoreCount != 0)
    {
        [self changePlatformDif];
    }
    
    if (!_isGameOver && !(self.scoreCount % 10 == 0 && self.scoreCount != 0))
    {
        [self.platform1 movePlatform];
        
        [self.platform2 movePlatform];
        
        [self.platform3 movePlatform];
    }
    else
    {
        [self returnBallsHome];
    }
    

}

#pragma mark collion delegate
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *block;
    
    SKPhysicsBody *ball;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        block = contact.bodyA;
        ball = contact.bodyB;
    }
    else
    {
        block = contact.bodyB;
        ball = contact.bodyA;
    }
    
    if (block.categoryBitMask == [Constants collisionPlatform])
    {
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, 19)];
        
        [self incCount];
    }
    
}

#pragma mark end game
- (void)gameOver
{
    self.ball.physicsBody.velocity = CGVectorMake(0, 0);
    
    self.ball.physicsBody.affectedByGravity = NO;
    
    self.ball.position = CGPointMake(self.size.width/2, self.size.height);
    
    [self reportScore:_scoreCount];
    
    [self clearCount];
    
    self.platform1.nodeSpeed = 2;
    
    self.platform2.nodeSpeed = 2;
    
    self.platform3.nodeSpeed = 2;
    
    _isGameOver = YES;
    
    [self addChild:self.gameOverNode];
    
    [self.runloop addSelector:@"shrinkGameOverLabel"];
    
    [self.runloop removeSelector:@"moveBall"];
    
}

-(BOOL)reportScore:(int)score
{
    
    [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error)
        {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else
            {
                GKScore *gk_score = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardIdentifier];
                
                gk_score.value = score;
                
                [GKScore reportScores:@[gk_score] withCompletionHandler:^(NSError *error) {
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                        
                    }
                }];
            }
         }];

    return  YES;
}

-(void)shrinkGameOverLabel
{
    if (!self.isUp)
    {
        self.gameOverNode.size = CGSizeMake(_gameOverNode.size.width - 0.30, _gameOverNode.size.height - 0.30);
        
        self.shrinkCount--;
        
        if (self.shrinkCount == -10)
        {
            self.isUp = YES;
        }
    }
    else
    {
        self.gameOverNode.size = CGSizeMake(_gameOverNode.size.width + 0.30, _gameOverNode.size.height + 0.30);
        
        self.shrinkCount++;
        
        if (self.shrinkCount == 10)
        {
            self.isUp = NO;
        }
        
    }
}

-(BOOL)returnBallsHome
{
    BOOL one = [self.platform1 moveHome];
    BOOL two = [self.platform2 moveHome];
    BOOL three = [self.platform3 moveHome];
    
    return !(one && two && three);
}

#pragma mark count

-(void)incCount
{
    self.scoreCount++;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", _scoreCount];
}

-(void)clearCount
{
    self.scoreCount = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", _scoreCount];
}

#pragma mark ball movement

- (void)moveBall
{
    CMAccelerometerData* data = self.manager.accelerometerData;
    
    [self.ball.physicsBody applyForce:CGVectorMake(40.0 * data.acceleration.y, 0)];
}

#pragma mark change platform difficulty
-(void)changePlatformDif
{
    [self.difficulty change];
}


@end
