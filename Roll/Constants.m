//
//  Constants.m
//  Roll
//
//  Created by Bert Heinzelman on 6/28/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import "Constants.h"

@implementation Constants

static uint32_t const NONE_COLLISION     = 0x1 << 0;
    
static uint32_t const PLATFORM_COLLISION = 0x1 << 1;

static uint32_t const BALL_COLLISION     = 0x1 << 2;

static uint32_t const WALL_COLLISION     = 0x1 << 3;

+(uint32_t)collisionNone
{
    return NONE_COLLISION;
}

+(uint32_t)collisionPlatform
{
    return PLATFORM_COLLISION;
}

+(uint32_t)collisionBall
{
    return BALL_COLLISION;
}

+(uint32_t)collisionWall
{
    return WALL_COLLISION;
}

+(UIColor*)systemBackgroundColor
{
    return  [UIColor colorWithRed:122/255.0f green:239/255.0f blue:224/255.0f alpha:1.0f];
}

+(UIColor*)systemAccentColor
{
    return [UIColor colorWithRed:255/255.0f green:80/255.0f blue:109/255.0f alpha:1.0f];
}

@end