//
//  MainViewController.m
//  My2048
//
//  Created by zhuang chaoxiao on 14-5-21.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "MainViewController.h"
#import "GameView.h"
#import "GADBannerView.h"
#import <iAd/iAd.h>
#import "YouMiWall.h"
#import "youmiconfuse.h"
#import "YouMiAdvViewController.h"
#import "AppsViewController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"

#define SHOW_ADV_YEAR  2014
#define SHOW_ADV_MONTH  10
#define SHOW_ADV_DAY   29



@interface MainViewController ()
{
    GADBannerView *_bannerView;
    GameView * _gameView;
    
    BOOL _canShowAdv;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _gameView = [[GameView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:_gameView];
    
    [self laytouADVView];
    
    
    //菜单
    {
        
        CGRect rect = CGRectMake(100, 80, 60, 30);
        UIButton * btn = [[UIButton alloc]initWithFrame:rect];
        [btn setTitle:@"菜单" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = [UIColor orangeColor];
        
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(menuClicken) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
//  显示广告
    {
        CGRect rect = CGRectMake(165, 30, 60, 30);
        UIButton * btn = [[UIButton alloc]initWithFrame:rect];
        [btn setTitle:@"你妹" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = [UIColor orangeColor];
        
        if([self canShowAdv] )
        {
            btn.hidden = NO;
        }
        else
        {
            btn.hidden = YES;
        }
        
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(showAdvClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    //应用推荐
    
    {
        
        CGRect rect = CGRectMake(165, 80, 60, 30);
        UIButton * btn = [[UIButton alloc]initWithFrame:rect];
        [btn setTitle:@"来三" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = [UIColor orangeColor];
        
        [self.view addSubview:btn];
        
        
        if([self canShowAdv] )
        {
            btn.hidden = NO;
        }
        else
        {
            btn.hidden = YES;
        }
        
        
        [btn addTarget:self action:@selector(showAppClicked) forControlEvents:UIControlEventTouchUpInside];

    }
    
    //微信分享
    {
        
        CGRect rect = CGRectMake(230, 30, 80, 30);
        UIButton * btn = [[UIButton alloc]initWithFrame:rect];
        [btn setTitle:@"分享我们" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = [UIColor orangeColor];
        
        [self.view addSubview:btn];
    
        
        [btn addTarget:self action:@selector(WeChatShare) forControlEvents:UIControlEventTouchUpInside];
        
    }

    
    // 给我打分
    {
        
        CGRect rect = CGRectMake(230, 80, 80, 30);
        UIButton * btn = [[UIButton alloc]initWithFrame:rect];
        [btn setTitle:@"给我打分" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = [UIColor orangeColor];
        
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(Evalute) forControlEvents:UIControlEventTouchUpInside];
        
    }

    _canShowAdv = YES;
}


-(void)WeChatShare
{
    
}

-(void)Evalute
{
    NSString *str =  [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"884886468"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)menuClicken
{
    MenuViewController * vc = [[MenuViewController alloc]initWithNibName:nil bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)showAppClicked
{
    AppsViewController * vc = [[AppsViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
    vc = nil;
}

-(void)showAdvClicked
{
    YouMiAdvViewController * vc = [[YouMiAdvViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
    vc = nil;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    if( [self canShowAdv]  && _canShowAdv )
    {
        YouMiAdvViewController * vc = [[YouMiAdvViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        
        vc = nil;
        
        _canShowAdv = NO;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    
    if( [app getSkinChange] )
    {
        [_gameView refreshGameSkin];
        //
        [app setSkinChange:NO];
    }
}


-(BOOL)canShowAdv
{
    NSDateComponents * data = [[NSDateComponents alloc]init];
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    [data setCalendar:cal];
    [data setYear:SHOW_ADV_YEAR];
    [data setMonth:SHOW_ADV_MONTH];
    [data setDay:SHOW_ADV_DAY];
    
    NSDate * farDate = [cal dateFromComponents:data];
    
    NSDate *now = [NSDate date];
    
    NSTimeInterval farSec = [farDate timeIntervalSince1970];
    NSTimeInterval nowSec = [now timeIntervalSince1970];
    
    if( nowSec - farSec >= 0 )
    {
        return YES;
    }
    
    return NO;
}


-(void)showYOUMIAdv
{
    [YouMiWall showOffers:YES didShowBlock:^{
        NSLog(@"有米积分墙已显示");
    } didDismissBlock:^{
        NSLog(@"有米积分墙已退出");
    }];
}


-(void)laytouADVView
{
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    NSLog(@"rect height:%f",rect.size.height);
    
    if( rect.size.height >= 568 )
    {
        _bannerView = [[GADBannerView alloc]initWithFrame:CGRectMake(0.0,rect.size.height - 100-20,320,100)];//设置位置
    }
    else
    {
        _bannerView = [[GADBannerView alloc]initWithFrame:CGRectMake(0.0,rect.size.height - 50-5,320,50)];//设置位置
    }
    
    
    _bannerView.adUnitID = @"a1527e3f3d6c7bc";//调用你的id
    
    _bannerView.rootViewController = self;
    
    
    [self.view addSubview:_bannerView];//添加bannerview到你的试图
    
    [_bannerView loadRequest:[GADRequest request]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
