//
//  CurrentWorkViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/3/18.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "CurrentWorkViewController.h"
#import "PersonalTableViewCell.h"
#import "ChoiceQuestionViewController.h"
static NSString *const currentWorkViewControllerTalbeViewCellId = @"currentWorkViewControllerTalbeViewCellId";

@interface CurrentWorkViewController ()

@end

@implementation CurrentWorkViewController

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
    _currentWorkTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_currentWorkTableView];
    _currentWorkTableView.dataSource = self;
    _currentWorkTableView.delegate = self;
    [_currentWorkTableView registerClass:[PersonalTableViewCell class] forCellReuseIdentifier:currentWorkViewControllerTalbeViewCellId];
    _currentWorkTableView.tableHeaderView = [self createHeaderView];
}
-(UIView *)createHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, self.view.frame.size.width-50, 20)];
    [headerView addSubview:label];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:17];
    if ([self.course objectForKey:@"title"]) {
        label.text = [self.course objectForKey:@"title"];
    }
    else
    {
        label.text = @"无当前作业";
    }
    label.textAlignment = NSTextAlignmentCenter;
    return headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.course objectForKey:@"choice"])
    {
        return 1;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:currentWorkViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"选择题";
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
        ChoiceQuestionViewController *choiceQuestionViewController = [[ChoiceQuestionViewController alloc] init];
        choiceQuestionViewController.title = @"选择题1";
        choiceQuestionViewController.hidesBottomBarWhenPushed = YES;
        choiceQuestionViewController.course = self.course;
        choiceQuestionViewController.score = 0;
        choiceQuestionViewController.count = 0;
        choiceQuestionViewController.currentWorkViewController = self;
        [self.navigationController pushViewController:choiceQuestionViewController animated:YES];
    }
}

@end
