//
//  ScrollMenuView.m
//  ScrollMenuDIY_FBC
//
//  Created by Derek on 20/05/18.
//  Copyright © 2018年 Derek. All rights reserved.
//

#import "ScrollMenuView.h"

@implementation ScrollMenuView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        /*注释 ：1.实现了上面“菜单“ 和 下面“滚动内容页面”的分离，
        你可以根据需求把菜单放在任何一个地方，
        把滚动内容页面放在任何一个地方，
        联动效果丝毫不影响
         */
        
    }
    return self;
}
//菜单栏的标题数组和坐标
-(void)initScrollMenuFrame:(CGRect)MenuFrame andTitleArray:(NSArray *)myTitleArray andDisplayNumsOfMenu:(int)Num{
    
    self.titleArray = myTitleArray;//菜单标题数组
    self.MenuFrame = MenuFrame;//菜单的布局
    self.NumsOfMenu = Num;//单个页面最大显示的数量，其他的需要滚动后可见
    
    //菜单栏的ScrollView背景滚动视图
    [self.menuBackScrollView addSubview:self.mySegmentedC];
    [self addSubview:self.menuBackScrollView];
    
    //这是菜单栏的下滑线
    [self.mySegmentedC addSubview:self.mylineLable];
    
    
    //点击加号后，显示和隐藏视图，菜单多少就会显示多少了button
    int n=0;
    
    for (int i = 0; i < 100; i++) {
        
        for (int j = 0; j < 4; j++) {
            
            if (n == (int)_titleArray.count) {
                break;
            }
            
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(10 * (j+1) + j * ((SCW-50)/4), 10 * (i +1) + i * 40 , (SCW-50)/4, 40)];
            [btn setTitle:[NSString stringWithFormat:@"%@",_titleArray[n]] forState:UIControlStateNormal];
            btn.tag = 1000 + n;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickBTN:) forControlEvents:UIControlEventTouchUpInside];
            [self.myPlusShowView addSubview:btn];
            
            n++;
        }
        
    }
    
    [self.myPlusShowBackView addSubview:self.myPlusShowView];
}
//内容页面的翻页
-(void)ScrollViewContent:(CGRect)ScrollViewContentFrame{
    
    self.contentScrollView.frame = ScrollViewContentFrame;
    
}
//点击空白隐藏背景
-(void)tapHideView{
    self.myPlusShowBackView.hidden = YES;
}
//点击”+“号出现和隐藏弹窗视图
-(void)ClickPlusMenuBTNShowView:(UIButton *)button{
    
    self.myPlusShowBackView.hidden = !self.myPlusShowBackView.hidden;
    
    if ([_delegate respondsToSelector:@selector(PlusButtonIsReallyClick:)]) {
        [_delegate PlusButtonIsReallyClick:button];
    }
}
//点击弹窗视图的按钮跳转菜单对应滚动
-(void)clickBTN:(UIButton *)btn{
    NSLog(@"-----------%ld---------",btn.tag);
    
    [_mySegmentedC setSelectedSegmentIndex:btn.tag - 1000];
    
    self.myPlusShowBackView.hidden = YES;
    
    [_contentScrollView setContentOffset:CGPointMake((btn.tag - 1000) * SCW, 0)];
    
    __weak __typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        //下划线的位置根据点击位置，变化位置
        weakSelf.mylineLable.frame = CGRectMake((btn.tag - 1000) * (weakSelf.mySegmentedC.frame.size.width/weakSelf.titleArray.count) + 5, weakSelf.mySegmentedC.frame.origin.y + weakSelf.mySegmentedC.frame.size.height - 5, weakSelf.mySegmentedC.frame.size.width/weakSelf.titleArray.count - 10, 2);
        
        if (weakSelf.NumsOfMenu >= weakSelf.titleArray.count) {
            
            //显示的数量小于_titleArray.count的时候，不做处理，也即是不滚动
        }else{
            //菜单标题的位置偏移
            if ((btn.tag-1000) >= weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2)) {
                
                if (weakSelf.NumsOfMenu % 2 == 0) {
                    //如果是_NumsOfMenu是偶数
                    [weakSelf.menuBackScrollView setContentOffset:CGPointMake((weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2) - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu) + (MENUW/weakSelf.NumsOfMenu) * 0.5, 0)];
                    
                }else{
                    //如果是_NumsOfMenu是奇数
                    [weakSelf.menuBackScrollView setContentOffset:CGPointMake((weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2) - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu), 0)];
                }
                
                
            }else if((btn.tag - 1000) > (weakSelf.NumsOfMenu/2) && (btn.tag - 1000) < weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2)){
                
                //如果是_NumsOfMenu是偶数
                if (weakSelf.NumsOfMenu % 2 == 0) {
                    [weakSelf.menuBackScrollView setContentOffset:CGPointMake(((btn.tag-1000)-(weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu) + (MENUW/weakSelf.NumsOfMenu) * 0.5, 0)];
                }else{
                    //如果是_NumsOfMenu是奇数
                    [weakSelf.menuBackScrollView setContentOffset:CGPointMake(((btn.tag-1000)-(weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu), 0)];
                }
                
            }else{
                [weakSelf.menuBackScrollView setContentOffset:CGPointMake(0, 0)];
            }
        }
    }];
    //响应点击了哪个myPlusShowView上的button，对应传出button的tag，也同时传出了对应的菜单标题
    if ([_delegate respondsToSelector:@selector(PlusShowViewInsideButtonIsReallyClick:)]) {
        [_delegate PlusShowViewInsideButtonIsReallyClick:btn];
    }
    
}
//Segment的点击事件
-(void)SegmentOnClick:(UISegmentedControl *)sgc{

    NSLog(@"st.selectIndex = %ld",sgc.selectedSegmentIndex);
    
    
    [_contentScrollView setContentOffset:CGPointMake(sgc.selectedSegmentIndex * SCW, 0)];
    
    __weak __typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        weakSelf.mylineLable.frame = CGRectMake(sgc.selectedSegmentIndex * (sgc.frame.size.width/weakSelf.titleArray.count) + 5, sgc.frame.origin.y + sgc.frame.size.height - 5, sgc.frame.size.width/weakSelf.titleArray.count - 10, 2);
        
        if (weakSelf.NumsOfMenu >= weakSelf.titleArray.count) {
            
            //显示的数量小于_titleArray.count的时候，不做处理，也即是不滚动
        }else{
            if (sgc.selectedSegmentIndex >= weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2)) {
                
                if (weakSelf.NumsOfMenu % 2 == 0) {
                    //如果是_NumsOfMenu是偶数
                    [weakSelf.menuBackScrollView setContentOffset:CGPointMake((weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2) - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu) + (MENUW/weakSelf.NumsOfMenu) * 0.5, 0)];
                }else{
                    //如果是_NumsOfMenu是奇数
                    [weakSelf.menuBackScrollView setContentOffset:CGPointMake((weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2) - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu), 0)];
                }
                
            }else if(sgc.selectedSegmentIndex > (weakSelf.NumsOfMenu/2) && sgc.selectedSegmentIndex < weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2)){
                
                if (weakSelf.NumsOfMenu % 2 == 0) {
                    //如果是_NumsOfMenu是偶数
                    [weakSelf.menuBackScrollView setContentOffset:CGPointMake((sgc.selectedSegmentIndex - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu) + (MENUW/weakSelf.NumsOfMenu) * 0.5, 0)];
                }else{
                    //如果是_NumsOfMenu是奇数
                    [weakSelf.menuBackScrollView setContentOffset:CGPointMake((sgc.selectedSegmentIndex - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu), 0)];
                }
                
            }else{
                //如果是_NumsOfMenu是偶数
                if (weakSelf.NumsOfMenu % 2 == 0) {
                    
                    if (sgc.selectedSegmentIndex == weakSelf.NumsOfMenu/2) {
                        [weakSelf.menuBackScrollView setContentOffset:CGPointMake((sgc.selectedSegmentIndex - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu) + (MENUW/weakSelf.NumsOfMenu) * 0.5, 0)];
                    }else{
                        [weakSelf.menuBackScrollView setContentOffset:CGPointMake(0, 0)];
                    }
                    
                }else{
                    //如果是_NumsOfMenu是奇数
                    [weakSelf.menuBackScrollView setContentOffset:CGPointMake(0, 0)];
                }
            }
        }
        
    }];
    
    //响应点击selectedSegmentIndex，对应传出selectedSegmentIndex
    if ([_delegate respondsToSelector:@selector(MenuButtonIsReallyClick:)]) {
        [_delegate MenuButtonIsReallyClick:sgc];
    }

}
//scrollView代理事件
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.contentScrollView) {
        
        int n=(scrollView.contentOffset.x/SCW);
        
        NSLog(@"n===%d",n);
        
        __weak __typeof(self) weakSelf = self;
        
        
        [UIView animateWithDuration:0.2 animations:^{
            
            
            [weakSelf.mySegmentedC setSelectedSegmentIndex:n];
            
            weakSelf.mylineLable.frame = CGRectMake(n * (weakSelf.mySegmentedC.frame.size.width/weakSelf.titleArray.count) + 5, weakSelf.mySegmentedC.frame.origin.y + weakSelf.mySegmentedC.frame.size.height - 5, weakSelf.mySegmentedC.frame.size.width/weakSelf.titleArray.count - 10, 2);
            
            if (weakSelf.NumsOfMenu >= weakSelf.titleArray.count) {
                
                //显示的数量小于_titleArray.count的时候，不做处理，也即是不滚动
            }else{
                
                if (n > 2 && n < weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2)) {
                    //如果是_NumsOfMenu是偶数
                    if (weakSelf.NumsOfMenu % 2 == 0) {
                        [weakSelf.menuBackScrollView setContentOffset:CGPointMake((n - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu) + (MENUW/weakSelf.NumsOfMenu) * 0.5, 0)];
                    }else{
                        //如果是_NumsOfMenu是奇数
                        [weakSelf.menuBackScrollView setContentOffset:CGPointMake((n - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu), 0)];
                    }
                    
                }else if(n >= weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2)){
                    //如果是_NumsOfMenu是偶数
                    if (weakSelf.NumsOfMenu % 2 == 0) {
                        [weakSelf.menuBackScrollView setContentOffset:CGPointMake((weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2) - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu) + (MENUW/weakSelf.NumsOfMenu) * 0.5, 0)];
                    }else{
                        //如果是_NumsOfMenu是奇数
                        [weakSelf.menuBackScrollView setContentOffset:CGPointMake((weakSelf.titleArray.count - (weakSelf.NumsOfMenu/2) - (weakSelf.NumsOfMenu/2)) * (MENUW/weakSelf.NumsOfMenu), 0)];
                    }
                }else{
                    [weakSelf.menuBackScrollView setContentOffset:CGPointMake(0, 0)];
                    
                }
            }
            
        }];
        
        //响应滚动内容页面滑动到什么地方，对应传出菜单标题tag
        if ([_delegate respondsToSelector:@selector(scrollToWhichMenu:)]) {
            [_delegate scrollToWhichMenu:n];
        }
        
    }else if (scrollView == self.menuBackScrollView){
        
        
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}
-(UISegmentedControl *)mySegmentedC {
    if (!_mySegmentedC) {
        
        //UISegmentedControl分段
        _mySegmentedC = [[UISegmentedControl alloc] initWithItems:_titleArray];
        //添加点击方法 添加事件
        [_mySegmentedC addTarget:self action:@selector(SegmentOnClick:) forControlEvents:UIControlEventValueChanged];
        _mySegmentedC.frame=CGRectMake(10, 0, _titleArray.count * (MENUW/_NumsOfMenu)-20, 44);
        //默认颜色
        [_mySegmentedC setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} forState:UIControlStateNormal];
        //点击后的颜色
        [_mySegmentedC setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]} forState:UIControlStateSelected];
        
        //设置镂空颜色
        _mySegmentedC.tintColor = [UIColor clearColor];
        [_mySegmentedC setSelectedSegmentIndex:0];
    }
    return _mySegmentedC;
}
//这是菜单栏的下滑线
-(UILabel *)mylineLable{
    if (!_mylineLable) {
    
        _mylineLable=[[UILabel alloc] initWithFrame:CGRectMake(0 * (_mySegmentedC.frame.size.width/_titleArray.count) + 5, _mySegmentedC.frame.origin.y + _mySegmentedC.frame.size.height - 5, _mySegmentedC.frame.size.width/_titleArray.count - 10, 2)];
        _mylineLable.backgroundColor = [UIColor redColor];
        //self.mylineLable.hidden=YES;
    }
    return _mylineLable;
}
//加号按钮
-(UIButton *)plusMenuBTN{
    
    if (!_plusMenuBTN) {
        
        _plusMenuBTN = [[UIButton alloc] initWithFrame:CGRectMake(SCW - 44, 0, 44, 44)];
        _plusMenuBTN.tag = 99;
        [_plusMenuBTN setTitle:@"+" forState:UIControlStateNormal];
        _plusMenuBTN.titleLabel.font = [UIFont systemFontOfSize:22];
        [_plusMenuBTN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _plusMenuBTN.backgroundColor = [UIColor whiteColor];
        [_plusMenuBTN addTarget:self action:@selector(ClickPlusMenuBTNShowView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusMenuBTN;
    
}
//菜单栏的滚动ScrollView
-(UIScrollView *)menuBackScrollView {
    
    if (!_menuBackScrollView) {
        
        _menuBackScrollView = [[UIScrollView alloc] init];
        _menuBackScrollView.contentOffset = CGPointMake(0 , 0);
        _menuBackScrollView.bounces = YES;
        _menuBackScrollView.showsVerticalScrollIndicator = NO;
        _menuBackScrollView.showsHorizontalScrollIndicator = NO;
        //_menuBackScrollView.backgroundColor=[UIColor redColor];
        _menuBackScrollView.delegate = self;
        _menuBackScrollView.frame = _MenuFrame;
        _menuBackScrollView.contentSize = CGSizeMake(self.mySegmentedC.frame.size.width, 44);

    }
    return _menuBackScrollView;
}
-(UIView *)myPlusShowBackView{
    
    if (!_myPlusShowBackView) {
        //弹窗父和子视图
        _myPlusShowBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCW, SCH)];
        //self.myPlusShowBackView.backgroundColor=[UIColor yellowColor];
        _myPlusShowBackView.hidden = YES;
        UITapGestureRecognizer * tapHide = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHideView)];
        [_myPlusShowBackView addGestureRecognizer:tapHide];
    }
    return _myPlusShowBackView;
}
-(UIView *)myPlusShowView{
    
    if (!_myPlusShowView) {
        //弹窗父和子视图
        _myPlusShowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCW, 210)];
        _myPlusShowView.backgroundColor = [UIColor orangeColor];
        //[self.view addSubview:plusShowView];
    }
    return _myPlusShowView;
}

-(UIScrollView *)contentScrollView {
    
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.contentSize = CGSizeMake(SCW * _titleArray.count, SCH );
        _contentScrollView.contentOffset = CGPointMake(0 , 0);
        _contentScrollView.bounces = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = YES;
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
    }
    return _contentScrollView;
}
-(NSArray *)titleArray{
    if (!_titleArray) {

        _titleArray = [[NSArray alloc] init];
    }
    return _titleArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
