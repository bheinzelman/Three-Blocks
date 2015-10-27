//
//  SELRunLoop.h
//  Roll
//
//  Created by Bert Heinzelman on 7/12/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

/*
 class used to add animations to method 'update'
 allows you to add and remove animations without use of
 conditionals that muck up the method
 */

#import <Foundation/Foundation.h>

@interface SELRunLoop : NSObject

-(instancetype)init : (id)controller;

-(instancetype)init : (id)controller selArray:(NSArray*) selArray;

-(void)removeSelector : (NSString*)sel;

-(void)addSelector : (NSString*)sel;

-(void)run;
@end
