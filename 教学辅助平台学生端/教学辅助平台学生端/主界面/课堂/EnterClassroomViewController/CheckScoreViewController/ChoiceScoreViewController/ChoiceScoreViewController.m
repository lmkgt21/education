//
//  ChoiceScoreViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/3/18.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "ChoiceScoreViewController.h"
#import "UserManager.h"
#import <Masonry.h>
#import "ScoreTableViewCell.h"
static NSString *const choiceScoreViewControllerTalbeViewCellId = @"choiceScoreViewControllerTalbeViewCellId";

@interface ChoiceScoreViewController ()

@end

@implementation ChoiceScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UserManager *userManager = [UserManager sharedUserManager];
    _choiceDic = [userManager getScoreWithType:@"choice" course:self.course];
    _titles = _choiceDic.allKeys;
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
    _choiceScoreTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_choiceScoreTableView];
    _choiceScoreTableView.dataSource = self;
    _choiceScoreTableView.delegate = self;
    [_choiceScoreTableView registerClass:[ScoreTableViewCell class] forCellReuseIdentifier:choiceScoreViewControllerTalbeViewCellId];
    _choiceScoreTableView.tableHeaderView = [self createHeaderView];
}
-(UIView *)createHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(10);
        make.left.equalTo(headerView.mas_left).offset(20);
        make.height.equalTo(@30);
    }];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.text = @"作业标题";
    titleLabel.textColor = [UIColor darkGrayColor];
    
    UILabel *choiceScoreLabel = [[UILabel alloc] init];
    [headerView addSubview:choiceScoreLabel];
    [choiceScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(10);
        make.left.equalTo(titleLabel.mas_right);
        make.right.equalTo(headerView.mas_right).offset(-20);
        make.height.equalTo(@30);
        make.width.equalTo(titleLabel.mas_width);
    }];
    choiceScoreLabel.font = [UIFont systemFontOfSize:17];
    choiceScoreLabel.text = @"选择题得分";
    choiceScoreLabel.textColor = [UIColor darkGrayColor];

    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:choiceScoreViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = _titles[indexPath.row];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%f",[_choiceDic[_titles[indexPath.row]] doubleValue]];
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

@end
