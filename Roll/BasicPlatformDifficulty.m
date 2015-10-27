//
//  BasicPlatformDifficulty.m
//  Roll
//
//  Created by Bert Heinzelman on 7/13/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import "BasicPlatformDifficulty.h"

@implementation BasicPlatformDifficulty

-(instancetype)init
{
    return [super init];
}

-(void)initPlatforms:(SKPlatformNode *)platform1 platform2:(SKPlatformNode *)platform2 platform3:(SKPlatformNode *)platform3
{
    self.p1 = platform1;
    
    self.p2 = platform2;
    
    self.p3 = platform3;
}

-(void)change
{
    NSArray* platforms = [[NSArray alloc] initWithObjects:self.p1, self.p2, self.p3, nil];
    
    //flip one platform direction
    int randPlat = arc4random() % 3;
    
    [(SKPlatformNode*)platforms[randPlat] flipDirection];
    
    for (int i = 0; i < 3; i++)
    {
        int speed = arc4random() % 5;
        
        SKPlatformNode* p = (SKPlatformNode*)platforms[i];
        
        p.nodeSpeed = speed;
        
        p = nil;
    }
}


@end
