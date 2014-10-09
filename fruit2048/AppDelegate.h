//
//  AppDelegate.h
//  fruit2048
//
//  Created by zhuang chaoxiao on 14-6-2.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    
}
@property (strong, nonatomic) UIWindow *window;


-(void)setSkin:(NSInteger)skin;
-(NSInteger)getSkin;

-(void)setSkinChange:(BOOL)bFlag;
-(BOOL)getSkinChange;

@end
