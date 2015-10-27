//
//  ARollSceneDelegate.h
//  Three Blocks
//
//  Created by Bert Heinzelman on 7/19/15.
//  Copyright (c) 2015 heinzelmanb. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ARollSceneDelegate <NSObject>

-(void)presentGameCenterViewController : (UIViewController*)vc;

-(void)gameCenterErrorMessage : (NSString*)errorString;

@end
