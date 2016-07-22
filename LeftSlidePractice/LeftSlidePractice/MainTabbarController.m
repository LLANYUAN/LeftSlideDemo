//
//  MainTabbarController.m
//  LeftSlidePractice
//
//  Created by anyuan on 16/7/21.
//  Copyright © 2016年 anyuan. All rights reserved.
//

#import "MainTabbarController.h"

#import "HomeViewController.H"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
@interface MainTabbarController()
@property (nonatomic, strong) UITabBarController *tabbarController;
@property (nonatomic, strong) HomeViewController *homeViewController;
@property (nonatomic, strong) SecondViewController *secondViewController;
@property (nonatomic, strong) ThirdViewController *thirdViewController;
@property (nonatomic, strong) FourViewController *fourViewController;
@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加视图到tabbar中
    
    //首页
    self.homeViewController = [[HomeViewController alloc]init];
    [self addChild:self.homeViewController title:@"首页" navigationTitle:@"aaa" image:@"tabbar_home"selectImage:@"tabbar_home_selected.png"];
   
    
    
    //第二页
    self.secondViewController = [[SecondViewController alloc]init];
    [self addChild:self.secondViewController title:@"消息" navigationTitle:@"bbb" image:@"tabbar_message_center"selectImage:@"tabbar_message_center_selected"];
    
    //第三页
    self.thirdViewController=[[ThirdViewController alloc]init];
    [self addChild:self.thirdViewController title:@"新建" navigationTitle:@"ccc" image:@"tabbar_profile"selectImage:@"tabbar_profile_selected"];
    
    
    //第四页
    self.fourViewController=[[FourViewController alloc]init];
    [self addChild:self.fourViewController title:@"发现" navigationTitle:@"ddd" image:@"tabbar_discover"selectImage:@"tabbar_discover_selected"];
    
    
}
-(void)addChild:(UIViewController *)childVc title:(NSString *)title navigationTitle:(NSString *)navigationTitle image:(NSString *)image selectImage:(NSString *)selectImage{
    
    
    childVc.title= title;
    childVc.tabBarItem.image=[UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage=[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    label.text = navigationTitle;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    childVc.navigationItem.titleView = label;

    
    //设置tabbaritem文字的属性
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=[UIColor blackColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置tabbaritem文字选中时的属性
    NSMutableDictionary *selectTextAttrs=[NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName]=[UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
}


@end
