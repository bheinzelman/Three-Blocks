//
//  BasicPlatformDifficulty.h
//  Roll
//
//  Created by Bert Heinzelman on 7/13/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPlatformDifficulty.h"
#import "SKPlatformNode.h"

@interface BasicPlatformDifficulty : NSObject<PPlatformDifficulty>

-(instancetype)init;

-(void)initPlatforms:(SKPlatformNode *)platform1 platform2:(SKPlatformNode *)platform2 platform3:(SKPlatformNode *)platform3;

-(void)change;

@property (nonatomic, weak)SKPlatformNode* p1;

@property (nonatomic, weak)SKPlatformNode* p2;

@property (nonatomic, weak)SKPlatformNode* p3;

@end
