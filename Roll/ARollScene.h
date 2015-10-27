//
//  ARollScene.h
//  Roll
//
//  Created by Bert Heinzelman on 7/14/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ARollSceneDelegate.h"

@interface ARollScene : SKScene

-(void)drawGrid;

@property (nonatomic, weak) id<ARollSceneDelegate> rollDelegate;

@end
