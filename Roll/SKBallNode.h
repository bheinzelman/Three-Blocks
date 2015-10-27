//
//  SKBallNode.h
//  Roll
//
//  Created by Bert Heinzelman on 6/27/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@interface SKBallNode : SKSpriteNode

- (instancetype) init: (CGPoint) position radius:(CGFloat)radius;

@end
