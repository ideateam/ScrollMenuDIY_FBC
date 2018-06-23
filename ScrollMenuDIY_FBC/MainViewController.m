//
//  MainViewController.m
//  ScrollMenuDIY_FBC
//
//  Created by Derek on 20/05/18.
//  Copyright © 2018年 Derek. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //NSLog(@"==========self.vcTitle=%@===========",self.title);
}
-(void)postNetWorkingWithTitle:(NSString *)title{
    
    NSLog(@"==========self.vcTitle=%@===========",title);
    
    
    UIButton * b=[[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    b.backgroundColor=[UIColor blackColor];
    [b setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:b];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
