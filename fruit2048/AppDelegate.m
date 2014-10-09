//
//  AppDelegate.m
//  fruit2048
//
//  Created by zhuang chaoxiao on 14-6-2.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "YouMiConfig.h"

#define SKIN_SETTING  @"SKIN_SETTING"
#define SKIN_CHANGE_STATE @"SKIN_CHAGE_STATE"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //
    MainViewController * vc = [[MainViewController alloc]init];
    self.window.rootViewController = vc;
    
    //
    [YouMiConfig launchWithAppID:@"93bf8a79d9940719" appSecret:@"e8de9ae6004e9d60"];
    [YouMiConfig setFullScreenWindow:self.window];
    
    //
    [WXApi registerApp:@"wx8ae0a52d0b488e34"];
    
    return YES;
}


-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication*)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}


-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        //NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
        // NSLog(@"strMsg:%@",strMsg);
        
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        NSLog(@"strMsg:%@",strMsg);
        
        
        if( resp.errCode == 0 )
        {
            //发送成功
        }
        else if( resp.errCode == -2 )
        {
            //主动取消
        }
    }
}

-(void) shareWithTextUrl
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"我在用'上海迪士尼旅游攻略'，获得免费门票，还有公仔送哦~.";
    [message setThumbImage:[UIImage imageNamed:@"res2.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"https://itunes.apple.com/cn/app/shang-hai-lu-you-gong-e-zhi/id804556227?mt=8";
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

- (void)shareWithImage
{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"weixin_share"]];
    
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"weixin_share" ofType:@"png"];
    NSLog(@"filepath :%@",filePath);
    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}



-(void)setSkinChange:(BOOL)bFlag
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setBool:bFlag forKey:SKIN_CHANGE_STATE];
    
    [def synchronize];
}

-(BOOL)getSkinChange
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    return [def boolForKey:SKIN_CHANGE_STATE];
}

-(void)setSkin:(NSInteger)skin
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setInteger:skin forKey:SKIN_SETTING];
    [def synchronize];
    
    [self setSkinChange:YES];
}

-(NSInteger)getSkin
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    
    return [def integerForKey:SKIN_SETTING];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
