//
//  MenuViewController.m
//  fruit2048
//
//  Created by zhuang chaoxiao on 14-9-4.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"


#define BACK_POS_X  20
#define BACK_POS_Y  20
#define BACK_HEIGHT  40
#define BACK_WIDTH   40


#define BASE_TAG  10086


@interface MenuViewController ()
{
    UIImageView * _imgViewSelected;
    
}
@end

@implementation MenuViewController

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
    
    
    [self layoutView];
    
    
    {
        UIButton * btnBack = [[UIButton alloc]initWithFrame:CGRectMake(BACK_POS_X-10, BACK_POS_Y, BACK_WIDTH, BACK_HEIGHT)];
        [btnBack setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnBack];
    }
    
    self.view.backgroundColor = [UIColor grayColor];
}


-(void)layoutView
{
    
    CGRect rect;
    
    {
        rect = CGRectMake(50, 30, 80, 80);
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:rect];
        imgView.image = [UIImage imageNamed:@"2_0"];
        imgView.layer.cornerRadius = 20;
        imgView.layer.masksToBounds = YES;
        imgView.userInteractionEnabled = YES;
        imgView.tag = BASE_TAG + 0;
        
        [self.view addSubview:imgView];
        
        UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgViewClicked:)];
        [imgView addGestureRecognizer:g];
        
    }
    
    {
        rect = CGRectMake(190, 30, 80, 80);
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:rect];
        imgView.image = [UIImage imageNamed:@"2_1"];
        imgView.layer.cornerRadius = 20;
        imgView.layer.masksToBounds = YES;
        imgView.userInteractionEnabled = YES;
        imgView.tag = BASE_TAG + 1;
        
        [self.view addSubview:imgView];
        
        UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgViewClicked:)];
        [imgView addGestureRecognizer:g];
    }
    
    
    {
        rect = CGRectMake(50, 130, 80, 80);
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:rect];
        imgView.image = [UIImage imageNamed:@"2_2"];
        imgView.layer.cornerRadius = 20;
        imgView.layer.masksToBounds = YES;
        imgView.userInteractionEnabled = YES;
        imgView.tag = BASE_TAG + 2;
        
        [self.view addSubview:imgView];
        
        UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgViewClicked:)];
        [imgView addGestureRecognizer:g];
    }
    
    {
        rect = CGRectMake(190, 130, 80, 80);
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:rect];
        imgView.image = [UIImage imageNamed:@"2_3"];
        imgView.layer.cornerRadius = 20;
        imgView.layer.masksToBounds = YES;
        imgView.userInteractionEnabled = YES;
        imgView.tag = BASE_TAG + 3;
        
        [self.view addSubview:imgView];
        
        UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgViewClicked:)];
        [imgView addGestureRecognizer:g];
    }
    
    {
        rect = CGRectMake(90, 70, 40, 40);
        _imgViewSelected = [[UIImageView alloc]initWithFrame:rect];
        _imgViewSelected.image = [UIImage imageNamed:@"select"];
        _imgViewSelected.layer.cornerRadius = 20;
        _imgViewSelected.layer.masksToBounds = YES;
        _imgViewSelected.userInteractionEnabled = YES;
        _imgViewSelected.tag = BASE_TAG + 3;
        
        [self.view addSubview:_imgViewSelected];
        
        [self setSelectView:[(AppDelegate*)[[UIApplication sharedApplication] delegate] getSkin] ];
        
    }
    
}


-(void)setSelectView:(NSInteger)tag
{
    CGPoint pt;
    
    switch (tag)
    {
        case 0:
        {
            pt = CGPointMake(110, 90);
            
        }
            break;
            
        case 1:
        {
            pt = CGPointMake(250, 90);
        }
            break;
            
        case 2:
        {
            pt = CGPointMake(110, 190);
        }
            break;
            
        case 3:
        {
            pt = CGPointMake(250, 190);
        }
            break;
            
        default:
            
            pt = CGPointMake(100, 100);
            
            break;
    }
    
    _imgViewSelected.center = pt;
}

-(void)imgViewClicked:(UITapGestureRecognizer*)g
{
    UIImageView * imgView =(UIImageView*)g.view;
    
    int tag = imgView.tag - BASE_TAG;
    
    
    AppDelegate * appDel = [[UIApplication sharedApplication] delegate];
    
    [self setSelectView:tag];
    
    [appDel setSkin:tag];

    
    
}


-(void)btnBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
