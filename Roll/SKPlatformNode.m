//
//  SKPlatformNode.m
//  Roll
//
//  Created by Bert Heinzelman on 6/27/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import "SKPlatformNode.h"
#import "Constants.h"

@implementation SKPlatformNode


-(instancetype) init : (int)x0 xf:(int) xf size:(CGSize)size position: (CGPoint)position
{
    self = [super init];
    
    self.texture = [SKTexture textureWithImageNamed:@"block.png"];
    
    _x0 = x0;
    
    _xf = xf;
    
    self.size = size;
    
    self.position = position;
    
    self.currentDirection = RIGHT;
    
    //self.color = [Constants systemAccentColor];
    
    self.nodeSpeed = DEFAULT_NODE_SPEED;
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size center:CGPointMake(self.size.width/2, self.size.height/4)];
    
    self.physicsBody.affectedByGravity = NO;
    
    self.physicsBody.categoryBitMask = [Constants collisionPlatform];
    
    self.physicsBody.collisionBitMask = [Constants collisionNone];
    
    self.physicsBody.contactTestBitMask = [Constants collisionBall];
    
    return  self;
}

- (void) movePlatform
{
    CGFloat x = self.position.x;
    
    if (self.currentDirection == RIGHT)
    {
        x += (CGFloat)self.nodeSpeed;
        
        if (self.position.x + self.size.width >= self.xf)
        {
            //self.currentDirection = LEFT;
            [self flipDirection];
        }
    }
    
    else
    {
        x -= (CGFloat)self.nodeSpeed;
        
        if (self.position.x <= self.x0)
        {
            [self flipDirection];
        }
            //self.currentDirection = RIGHT;
    }
    
    
    self.position = CGPointMake(x, self.position.y);
}

-(BOOL)moveHome
{
    if (self.position.x > self.x0)
    {
        self.position = CGPointMake(self.position.x - 2, self.position.y);
        
        return NO;
    }
    return YES;
}

-(void)flipDirection
{
    if (self.currentDirection == LEFT)
        self.currentDirection = RIGHT;
    else
        self.currentDirection = LEFT;
}

@end
