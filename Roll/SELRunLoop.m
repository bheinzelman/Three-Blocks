//
//  SELRunLoop.m
//  Roll
//
//  Created by Bert Heinzelman on 7/12/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import "SELRunLoop.h"

@interface SELRunLoop ()

@property (nonatomic, strong) NSMutableArray* selectors;
@property (nonatomic, weak) id controller;

@end

@implementation SELRunLoop

-(instancetype)init:(id)controller
{
    self = [super init];
    
    _controller = controller;
    
    self.selectors = [[NSMutableArray alloc] init];
    
    return self;
}


-(instancetype) init:(id)controller selArray:(NSArray *)selArray
{
    self = [super init];
    
    _controller = controller;
    
    self.selectors = [[NSMutableArray alloc] initWithArray:selArray];
    
    return self;
}


-(void)removeSelector:(NSString *)sel
{
    [self.selectors removeObject:sel];
}

-(void)addSelector:(NSString *)sel
{
    [self.selectors addObject:sel];
}

-(void)run
{
    for (int i = 0; i < [self.selectors count]; i++)
    {
        SEL selector = NSSelectorFromString(self.selectors[i]);
        ((void (*)(id, SEL))[_controller methodForSelector:selector])(_controller, selector);
        
    }
   
}



@end
