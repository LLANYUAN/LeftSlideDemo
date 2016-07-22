//
//  MainScrollViewController.m
//  LeftSlidePractice
//
//  Created by anyuan on 16/7/21.
//  Copyright © 2016年 anyuan. All rights reserved.


#import "MainScrollViewController.h"
#import "MainTabbarController.h"
#import "LeftViewController.h"
@interface MainScrollViewController()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) LeftViewController *leftViewController;
@property (nonatomic, strong) MainTabbarController *mainViewController;

@end

@implementation MainScrollViewController

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
    }
    return _mainScrollView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatScrollView];
    
    
    //接受通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(menu) name:@"menu" object:nil];
    
    //监听scrollview是否可以滑动的通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopScroll) name:@"stopScroll" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(beginScroll) name:@"beginScroll" object:nil];
    
}
- (void)creatScrollView{
   
    self.mainScrollView = [[UIScrollView alloc] init];
    self.mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.mainScrollView.scrollEnabled = YES;
    self.mainScrollView.bounces = NO;//禁止弹动
    self.mainScrollView.delegate = self;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.pagingEnabled = YES;//整页翻动
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *9 / 5, 0);
    self.mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH *4 / 5, 0);
    [self.view addSubview:self.mainScrollView];
    
    
    self.leftViewController = [[LeftViewController alloc] init];
   
    self.leftViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH *4 / 5, SCREEN_HEIGHT);
    [self.mainScrollView addSubview:self.leftViewController.view];
    

    self.mainViewController = [[MainTabbarController alloc] init];
    self.mainViewController.view.frame = CGRectMake(SCREEN_WIDTH *4 / 5, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.mainScrollView addSubview:self.mainViewController.view];
    
}
- (void)menu{
    BOOL isHide = self.mainScrollView.contentOffset.x == SCREEN_WIDTH * 4 / 5;
    [UIView animateWithDuration:0.5 animations:^{
        self.mainScrollView.contentOffset = CGPointMake(isHide ? 0 : SCREEN_WIDTH * 4 / 5, 0);

    }];
}

//滑动scrollview的时候会调用此方法，然后发出通知，产生蒙板
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float scrollX = scrollView.contentOffset.x;
    NSString *scrollXString = [NSString stringWithFormat:@"%f",scrollX];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeX" object:@{@"scrollXStringKey":scrollXString}];  
}
- (void)stopScroll{
    self.mainScrollView.scrollEnabled = NO;
}
- (void)beginScroll{
    self.mainScrollView.scrollEnabled = YES;
}

@end
