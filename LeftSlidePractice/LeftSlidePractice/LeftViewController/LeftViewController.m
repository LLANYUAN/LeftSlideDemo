//
//  LeftViewController.m
//  LeftSlidePractice
//
//  Created by anyuan on 16/7/21.
//  Copyright © 2016年 anyuan. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftDetailViewController.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"sss";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTabelView];
}
- (void)creatTabelView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH *4 / 5, 440) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    ;
    bgImageView.image = [UIImage imageNamed:@"top_bg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"companyLogo"]];
    
    [bgImageView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageView.image.size.width*0.6);
        make.height.mas_equalTo(imageView.image.size.height*0.6);
        make.center.equalTo(bgImageView);
    }];
    
    return bgImageView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *id = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushOtherController" object:nil];

}







@end
