//
//  ScrollMenuView.h
//  ScrollMenuDIY_FBC
//
//  Created by Derek on 20/05/18.
//  Copyright © 2018年 Derek. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MENUW self.bounds.size.width
#define SCW [UIScreen mainScreen].bounds.size.width
#define SCH [UIScreen mainScreen].bounds.size.height



@protocol ScrollMenuDIYFBCDelgate<NSObject>
-(void)MenuButtonIsReallyClick:(UISegmentedControl *)SegmentedC;
-(void)PlusButtonIsReallyClick:(UIButton *)button;
-(void)PlusShowViewInsideButtonIsReallyClick:(UIButton *)button;
-(void)scrollToWhichMenu:(int)MenuSegmentIndex;
@end

@interface ScrollMenuView : UIView<UIScrollViewDelegate>
@property (nonatomic,strong) UISegmentedControl *mySegmentedC;//使用UISegmentedControl分段来实现的菜单联动
@property (nonatomic,strong) UIScrollView *menuBackScrollView;//ISegmentedControl的父视图，目的是实现可任意滚动
@property (nonatomic,strong) NSArray * titleArray;//标题数组
@property (nonatomic,assign) CGRect MenuFrame;//菜单的位置布局
@property (nonatomic,assign) int NumsOfMenu;//可视的菜单数量（非总共的菜单标题数量）
@property (nonatomic,assign) CGRect ScrollViewContentFrame;//滚动内容页面位置布局
@property (nonatomic,strong) UIScrollView *contentScrollView;//滚动内容页面
@property (nonatomic,strong) UILabel * mylineLable;//菜单的下划线
@property (nonatomic,strong) UIButton * plusMenuBTN;//菜单右侧的加号“+”
@property (nonatomic,strong) UIView * myPlusShowBackView;//点击加号，myPlusShowView的父视图
@property (nonatomic,strong) UIView * myPlusShowView;//点击加号，显示各个菜单的跳转button，myPlusShowBackView的子视图

@property (nonatomic,strong) id<ScrollMenuDIYFBCDelgate> delegate;

//初始化滚动内容ScrollView
-(void)ScrollViewContent:(CGRect)ScrollViewContentFrame;
//初始化菜单标题scrollMenu
-(void)initScrollMenuFrame:(CGRect)MenuFrame andTitleArray:(NSArray *)myTitleArray andDisplayNumsOfMenu:(int)Num;
@end
