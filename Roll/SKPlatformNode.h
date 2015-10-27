//
//  SKPlatformNode.h
//  Roll
//
//  Created by Bert Heinzelman on 6/27/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define DEFAULT_NODE_SPEED 4

@interface SKPlatformNode : SKSpriteNode


enum Direction
{
    LEFT,
    RIGHT
};

- (instancetype) init : (int)x0 xf:(int) xf size:(CGSize)size position: (CGPoint)position;

- (void) movePlatform;

- (void) flipDirection;

- (BOOL)moveHome;

@property (nonatomic, readonly) int x0;

@property (nonatomic, readonly) int xf;

@property (nonatomic) int nodeSpeed;

@property (nonatomic) enum Direction currentDirection;


@end
