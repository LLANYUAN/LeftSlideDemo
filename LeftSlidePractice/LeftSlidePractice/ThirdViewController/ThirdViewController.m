//
//  ThirdViewController.m
//  LeftSlidePractice
//
//  Created by anyuan on 16/7/21.
//  Copyright © 2016年 anyuan. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@property (nonatomic, strong) UIView *coverView;//蒙板
@end

@implementation ThirdViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = defRandomColor;
    //创建左侧的菜单按钮
    [self creatLeftBackBtn];
    //接收通知
    [self receive];
}


#pragma mark - 当scrollview滑动的时候会调用这个通知方法，产生和取消蒙板
- (void)receive{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollXStringChange:) name:@"changeX" object:nil];
}
#pragma mark - 当scrollview滑动的时候会调用这个通知方法，产生和取消蒙板
- (void)scrollXStringChange:(NSNotification *)no{
    NSString *changeX = [no.object valueForKey:@"scrollXStringKey"];
    if (changeX.floatValue < SCREEN_WIDTH / 2) {//产生蒙板
        [self.coverView removeFromSuperview];
        self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, -100, SCREEN_WIDTH, SCREEN_HEIGHT + 200)];
        self.coverView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.coverView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCoverView)];
        tap.numberOfTapsRequired = 1;
        [self.coverView addGestureRecognizer:tap];
        
        
        self.tabBarController.tabBar.userInteractionEnabled = NO;
        
    }else{
        self.tabBarController.tabBar.userInteractionEnabled = YES;
        [self.coverView removeFromSuperview];
        //取消蒙板
    }
}
#pragma mark - 当蒙板产生的时候点击蒙板，scrollview开始滑动
- (void)clickCoverView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"menu" object:nil];
    
}
#pragma mark - 创建左侧的菜单按钮
- (void)creatLeftBackBtn{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 46, 30)];
    [leftBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(playMenu) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 菜单按钮的点击方法
- (void)playMenu{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"menu" object:nil];
}


@end
