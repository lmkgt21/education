//
//  EnterClassroomViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/3/18.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "EnterClassroomViewController.h"
#import "PersonalTableViewCell.h"
#import "CheckScoreViewController.h"
#import "CurrentWorkViewController.h"
static NSString *const enterClassroomViewControllerTalbeViewCellId = @"enterClassroomViewControllerTalbeViewCellId";

@interface EnterClassroomViewController ()

@end

@implementation EnterClassroomViewController

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
    _enterClassroomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_enterClassroomTableView];
    _enterClassroomTableView.dataSource = self;
    _enterClassroomTableView.delegate = self;
    [_enterClassroomTableView registerClass:[PersonalTableViewCell class] forCellReuseIdentifier:enterClassroomViewControllerTalbeViewCellId];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:enterClassroomViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"当前作业";
    }
    else if (indexPath.row == 1)
    {
        cell.titleLabel.text = @"查看分数";
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
        CurrentWorkViewController *currentWorkViewController = [[CurrentWorkViewController alloc] init];
        currentWorkViewController.title = @"当前作业";
        currentWorkViewController.hidesBottomBarWhenPushed = YES;
        currentWorkViewController.course = self.course;
        [self.navigationController pushViewController:currentWorkViewController animated:YES];
    }
    else if (indexPath.row == 1)
    {
        CheckScoreViewController *checkScoreViewController = [[CheckScoreViewController alloc] init];
        checkScoreViewController.title = @"查看分数";
        checkScoreViewController.hidesBottomBarWhenPushed = YES;
        checkScoreViewController.course = self.course;
        [self.navigationController pushViewController:checkScoreViewController animated:YES];
    }
}

@end
