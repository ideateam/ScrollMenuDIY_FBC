//
//  MainViewController.h
//  ScrollMenuDIY_FBC
//
//  Created by Derek on 20/05/18.
//  Copyright © 2018年 Derek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (nonatomic,strong) NSString *vcTitle;
-(void)postNetWorkingWithTitle:(NSString *)title;
@end
