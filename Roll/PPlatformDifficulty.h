//
//  PPlatformDifficulty.h
//  Roll
//
//  Created by Bert Heinzelman on 7/13/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import "SKPlatformNode.h"

@protocol PPlatformDifficulty<NSObject>

-(void)initPlatforms: (SKPlatformNode*)platform1 platform2:(SKPlatformNode*)platform2 platform3: (SKPlatformNode*)platform3;

-(void)change;

@end


