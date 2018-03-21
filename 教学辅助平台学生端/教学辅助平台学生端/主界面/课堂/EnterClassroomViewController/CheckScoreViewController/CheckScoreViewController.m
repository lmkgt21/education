//
//  CheckScoreViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/3/18.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "CheckScoreViewController.h"
#import "PersonalTableViewCell.h"
#import "TotalPointViewController.h"
#import "ChoiceScoreViewController.h"
#import "UserManager.h"
#import <Masonry.h>
static NSString *const checkScoreViewControllerTalbeViewCellId = @"checkScoreViewControllerTalbeViewCellId";

@interface CheckScoreViewController ()

@end

@implementation CheckScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTableView];
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
-(void)loadTableView
{
    _checkScoreTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_checkScoreTableView];
    _checkScoreTableView.dataSource = self;
    _checkScoreTableView.delegate = self;
    [_checkScoreTableView registerClass:[PersonalTableViewCell class] forCellReuseIdentifier:checkScoreViewControllerTalbeViewCellId];
    _checkScoreTableView.tableHeaderView = [self createHeaderView];
}
-(UIView *)createHeaderView
{
    UserManager *userManager = [UserManager sharedUserManager];
    double total = 0;
    double average = 0;
    unsigned long count = 0;
    NSArray *allValues = [[userManager getScoreWithType:@"choice" course:self.course] allValues];
    for (NSNumber *num in allValues) {
        total = total + [num doubleValue];
    }
    count = allValues.count;
    if (count) {
        average = total/count;
    }
    else
    {
        average = 0;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 105)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *totalScoreLabel = [[UILabel alloc] init];
    [headerView addSubview:totalScoreLabel];
    [totalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(10);
        make.left.equalTo(headerView.mas_left).offset(20);
        make.right.equalTo(headerView.mas_right).offset(-20);
        make.height.equalTo(@25);
    }];
    totalScoreLabel.font = [UIFont systemFontOfSize:17];
    totalScoreLabel.text = [NSString stringWithFormat:@"总分：%f",total];
    totalScoreLabel.textColor = [UIColor darkGrayColor];
    
    UILabel *averageScoreLabel = [[UILabel alloc] init];
    [headerView addSubview:averageScoreLabel];
    [averageScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalScoreLabel.mas_bottom).offset(5);
        make.left.equalTo(headerView.mas_left).offset(20);
        make.right.equalTo(headerView.mas_right).offset(-20);
        make.height.equalTo(@25);
    }];
    averageScoreLabel.font = [UIFont systemFontOfSize:17];
    averageScoreLabel.text = [NSString stringWithFormat:@"平均分：%f",average];
    averageScoreLabel.textColor = [UIColor darkGrayColor];
    
    UILabel *countScoreLabel = [[UILabel alloc] init];
    [headerView addSubview:countScoreLabel];
    [countScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(averageScoreLabel.mas_bottom).offset(5);
        make.left.equalTo(headerView.mas_left).offset(20);
        make.right.equalTo(headerView.mas_right).offset(-20);
        make.height.equalTo(@25);
    }];
    countScoreLabel.font = [UIFont systemFontOfSize:17];
    countScoreLabel.text = [NSString stringWithFormat:@"作业次数：%lu",count];
    countScoreLabel.textColor = [UIColor darkGrayColor];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:checkScoreViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"选择题";
    }
    else if (indexPath.row == 1)
    {
        cell.titleLabel.text = @"总分";
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ChoiceScoreViewController *choiceScoreViewController = [[ChoiceScoreViewController alloc] init];
        choiceScoreViewController.title = @"选择题";
        choiceScoreViewController.hidesBottomBarWhenPushed = YES;
        choiceScoreViewController.course = self.course;
        [self.navigationController pushViewController:choiceScoreViewController animated:YES];
    }
    else if (indexPath.row == 1)
    {
        TotalPointViewController *totalPointViewController = [[TotalPointViewController alloc] init];
        totalPointViewController.title = @"总分";
        totalPointViewController.hidesBottomBarWhenPushed = YES;
        totalPointViewController.course = self.course;
        [self.navigationController pushViewController:totalPointViewController animated:YES];
    }
}

@end
