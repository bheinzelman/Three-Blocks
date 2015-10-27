//
//  ARollScene.m
//  Roll
//
//  Created by Bert Heinzelman on 7/14/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import "ARollScene.h"

@implementation ARollScene

-(void)didMoveToView:(SKView *)view
{
    [self drawGrid];
}

-(void)drawGrid
{
    const double inc = self.size.width / 20;
    double xPos = 0;
    for (int i = 0; i < 20; i++)
    {
        SKShapeNode *line = [SKShapeNode node];
        
        line.lineWidth = self.size.height / 2000;
        
        CGMutablePathRef pathToDraw = CGPathCreateMutable();
        
        CGPathMoveToPoint(pathToDraw, nil, xPos, 0);
        
        CGPathAddLineToPoint(pathToDraw, nil, xPos, self.size.height);
        
        line.path = pathToDraw;
        
        [line setStrokeColor:[UIColor grayColor]];
        
        [self addChild:line];
        
        xPos += inc;
    }
    
    double yPos = 0;
    
    while (yPos < self.size.width)
    {
        SKShapeNode *line = [SKShapeNode node];
        
        line.lineWidth = self.size.height / 2000;
        
        CGMutablePathRef pathToDraw = CGPathCreateMutable();
        
        CGPathMoveToPoint(pathToDraw, nil, 0, yPos);
        
        CGPathAddLineToPoint(pathToDraw, nil, self.size.width, yPos);
        
        line.path = pathToDraw;
        
       [line setStrokeColor:[UIColor grayColor]];
        
        [self addChild:line];
        
        yPos += inc;
    }
}

@end
