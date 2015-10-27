//
//  Collision.h
//  Roll
//
//  Created by Bert Heinzelman on 6/27/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#ifndef Roll_Collision_h
#define Roll_Collision_h

#import <UIKit/UIKit.h>


@interface Constants : NSObject

+(uint32_t)collisionNone;

+(uint32_t)collisionPlatform;

+(uint32_t)collisionBall;

+(uint32_t)collisionWall;

+(UIColor*)systemBackgroundColor;

+(UIColor*)systemAccentColor;

@end

#endif
