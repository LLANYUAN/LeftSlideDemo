//
//  HomeViewController.m
//  LeftSlidePractice
//
//  Created by anyuan on 16/7/21.
//  Copyright © 2016年 anyuan. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"
#import "LeftDetailViewController.h"
#import "LeftViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *coverView;//蒙板
@property (nonatomic, strong) LeftViewController *leftViewController;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = defRandomColor;
    //创建tableview
    [self creatTableView];
    //创建左侧的菜单按钮
    [self creatLeftBackBtn];
    //接收通知
    [self receive];

}

- (void)creatTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *id = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}





#pragma mark - 当scrollview滑动的时候会调用这个通知方法，产生和取消蒙板
- (void)receive{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollXStringChange:) name:@"changeX" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushOtherController) name:@"pushOtherController" object:nil];
  
}


- (void)pushOtherController{
    [UIView animateWithDuration:0.25 animations:^{
        LeftDetailViewController *vc = [[LeftDetailViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self performSelector:@selector(abcd) withObject:nil afterDelay:0.1];
    
}
- (void)abcd{
    
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"menu" object:nil];
   
    
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
        
        //在弹出蒙板的时候，下面的tabbar不可点击
         self.tabBarController.tabBar.userInteractionEnabled = NO;
    }else{
        //在蒙板消失的时候，下面的tabbar恢复点击
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
