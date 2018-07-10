//
//  ViewController.m
//  ScrollMenuDIY_FBC
//
//  Created by Derek on 20/05/18.
//  Copyright © 2018年 Derek. All rights reserved.
//

#import "ViewController.h"
#import "ScrollMenuView.h"
#import "MainViewController.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<ScrollMenuDIYFBCDelgate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent=NO;
    
    ScrollMenuView *scrollMenu = [[ScrollMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 44)];
    scrollMenu.delegate = self;//代理事件根据需要添加，ScrollMenuDIYFBCDelgate
    //NSArray *array=@[@"首页",@"热点",@"最新"];
    //NSArray *array=@[@"首页",@"热点",@"最新",@"最火",@"最冷",@"商业"];
    NSArray *array=@[@"首页",@"热点",@"最新",@"最火",@"最冷",@"商业",@"艺术",@"文化",@"教育",@"历史",@"文学",@"社会",@"美术",@"地理",@"科学"];
    //初始化菜单栏
    [scrollMenu initScrollMenuFrame:CGRectMake(0, 0, SCREENW, 44) andTitleArray:array andDisplayNumsOfMenu:6];
    //初始化内容翻页
    [scrollMenu ScrollViewContent:CGRectMake(0, 0, SCREENW, SCREENH) andScrollDirection:FBScrollVertical andPagingEnabled:YES];
    
    [self.navigationController.navigationBar addSubview:scrollMenu];//添加菜单栏
    [self.navigationController.navigationBar addSubview:scrollMenu.plusMenuBTN];//添加加号按钮
    
    //添加滚动内容页面到指定视图
    [self.view addSubview:scrollMenu.contentScrollView];
    
    
    if (scrollMenu.ScrollViewContentDirectionstate == FBScrollVertical) {
        
        //添加子视图，请求数据
        for (int i = 0 ; i < array.count; i++) {
            MainViewController *vc = [[MainViewController alloc]init];
            vc.view.frame=CGRectMake(0, i * SCREENH, SCREENW, SCREENH);
            [vc postNetWorkingWithTitle:array[i]];//传递请求数据
            [scrollMenu.contentScrollView addSubview:vc.view];
            [self addChildViewController:vc];
            
        }
        
    }else{
        
        //添加子视图，请求数据
        for (int i = 0 ; i < array.count; i++) {
            MainViewController *vc = [[MainViewController alloc]init];
            vc.view.frame=CGRectMake(i * SCREENW, 0, SCREENW, SCREENH);
            [vc postNetWorkingWithTitle:array[i]];//传递请求数据
            [scrollMenu.contentScrollView addSubview:vc.view];
            [self addChildViewController:vc];
            
        }
    }
    
    
    [self.view addSubview:scrollMenu.myPlusShowBackView];
}
/*
 ScrollMenuDIYFBCDelgate  代理事件，根据需求可用可不用
 */
-(void)MenuButtonIsReallyClick:(UISegmentedControl *)SegmentedC{
    NSLog(@"v----selectedSegmentIndex = %ld",SegmentedC.selectedSegmentIndex);
}
-(void)PlusButtonIsReallyClick:(UIButton *)button{
    NSLog(@"v----PlusButtonIsReallyClick =%ld",button.tag);
}
-(void)PlusShowViewInsideButtonIsReallyClick:(UIButton *)button{
    NSLog(@"v----PlusShowViewInsideButtonIsReallyClick = %ld",button.tag);
}
-(void)scrollToWhichMenu:(int)MenuSegmentIndex{
    NSLog(@"v----scrollToWhichMenu = %d",MenuSegmentIndex);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
