//
//  SKBallNode.m
//  Roll
//
//  Created by Bert Heinzelman on 6/27/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//
#import "SKBallNode.h"
#import "Constants.h"

@interface SKBallNode()
@end

@implementation SKBallNode


- (instancetype) init:(CGPoint)position radius:(CGFloat)radius
{
    self = (SKBallNode*)[SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
    
    self.position = position;
    
    self.size = CGSizeMake(radius*2, radius*2);
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius/2];
    
    self.physicsBody.affectedByGravity = YES;
    
    self.physicsBody.categoryBitMask = [Constants collisionBall];
    
    self.physicsBody.collisionBitMask = [Constants collisionPlatform] |  [Constants collisionWall];
    
    self.physicsBody.contactTestBitMask = [Constants collisionPlatform];
    
    self.physicsBody.mass = 0.02;

    return  self;
}

@end
