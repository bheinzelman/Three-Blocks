//
//  IntroScene.m
//  Roll
//
//  Created by Bert Heinzelman on 6/28/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import <GameKit/GameKit.h>

#import "IntroScene.h"
#import "GameScene.h"
#import "Constants.h"
#import "SELRunLoop.h"

@interface IntroScene ()

-(void)playButtonAnimation;

@property (nonatomic, strong) SELRunLoop* runLoop;

@end

@implementation IntroScene
{
    BOOL isUp;
}

-(void) didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    [self drawGrid];
    
    self.runLoop = [[SELRunLoop alloc] init:self];
    
    [self.runLoop addSelector:@"bounceEmblem"];
    
    self.backgroundColor = [Constants systemBackgroundColor];
    
    self.emblem = [SKSpriteNode spriteNodeWithImageNamed:@"Emblem.png"];
    
    self.emblem.size = CGSizeMake(self.size.width/4, self.size.width/4);
    
    self.emblem.position = CGPointMake(self.size.width/2, self.size.height/1.5);
    
    [self addChild:self.emblem];
    
    self.playButton = [SKSpriteNode spriteNodeWithImageNamed:@"Play.png"];
    
    self.playButton.size = CGSizeMake(self.emblem.size.width, self.emblem.size.height / 3.0);
    
    self.playButton.position = CGPointMake(self.size.width / 2, self.size.height / 3);
    
    self.playButton.name = @"PlayButton";
    
    [self addChild:_playButton];
    
    SKSpriteNode* hs = [SKSpriteNode spriteNodeWithImageNamed:@"hs"];
    
    hs.name = @"hs";
    
    hs.position = CGPointMake(self.size.width * 0.05, self.size.height * 0.80);
    
    [self addChild:hs];
    
    isUp = YES;
}

-(void)dealloc
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"PlayButton"])
    {
        [self buttonPressed];
    }
    
    else if ([node.name isEqualToString:@"hs"])
    {
        [self presentHighScores];
    }
    
}

-(void)update:(NSTimeInterval)currentTime
{
    
    [self.runLoop run];

}


-(void)bounceEmblem
{
        if (isUp)
        {
            self.emblem.position = CGPointMake(_emblem.position.x, _emblem.position.y + 2);
            
            if (self.emblem.position.y > self.size.height/1.5 + self.emblem.size.height/10)
            {
                isUp = NO;
            }
        }
        else
        {
            self.emblem.position = CGPointMake(_emblem.position.x, _emblem.position.y - 2);
            
            if (self.emblem.position.y < self.size.height/1.5 - self.emblem.size.height/10)
            {
                isUp = YES;
            }
        }
}

-(void)buttonPressed
{
    [self.runLoop addSelector:@"playButtonAnimation"];
}

-(void)playButtonAnimation
{
    if ( _playButton.size.height <= 0 )
    {
        GameScene* game = [[GameScene alloc] initWithSize:self.size];
        
        game.scaleMode = SKSceneScaleModeAspectFill;
        
        SKTransition* trans = [SKTransition flipVerticalWithDuration:0.2];
        
        [self.view presentScene:game transition:trans];
        
        [self.emblem removeFromParent];
        
        [self.runLoop removeSelector:@"playButtonAnimation"];
        
    }
    else
    {
        self.playButton.size = CGSizeMake(self.playButton.size.width, self.playButton.size.height - 6);
    }
    
}


-(void)presentHighScores
{
    if (self.rollDelegate != nil)
    {
        [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error)
         {
             if (error != nil) {
                 [self.rollDelegate gameCenterErrorMessage:@"Not signed into Game Center"];
             }
             else
             {
                 GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
                 
                 gcViewController.gameCenterDelegate = self;
                 
                 gcViewController.leaderboardIdentifier = leaderboardIdentifier;
                 
                 gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
                 
                 [self.rollDelegate presentGameCenterViewController:gcViewController];

             }
         }];
    }
}


-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}



@end
