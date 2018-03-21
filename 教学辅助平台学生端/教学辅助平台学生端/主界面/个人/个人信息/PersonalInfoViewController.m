//
//  PersonalInfoViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/3/19.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "PersonalInfoViewController.h"

static NSString *const personalInfoViewControllerTalbeViewCellId = @"personalInfoViewControllerTalbeViewCellId";

@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController

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
    _personalInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_personalInfoTableView];
    _personalInfoTableView.dataSource = self;
    _personalInfoTableView.delegate = self;
    [_personalInfoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:personalInfoViewControllerTalbeViewCellId];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:personalInfoViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
}

@end
