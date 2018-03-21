//
//  PersonalViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/28.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalInfoViewController.h"
#import "UserManager.h"
static NSString *const personalViewControllerTalbeViewCellId = @"personalViewControllerTalbeViewCellId";
@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTableView
{
    _personalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStyleGrouped];
    [self.view addSubview:_personalTableView];
    //设置
    _personalTableView.delegate = self;
    _personalTableView.dataSource = self;
    [_personalTableView registerClass:[PersonalTableViewCell class] forCellReuseIdentifier:personalViewControllerTalbeViewCellId];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else if (section == 1)
    {
        return 1;
    }
    else if (section == 2)
    {
        return 2;
    }
    else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:personalViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"用户名：";
            cell.arrowsLabel.text = [[UserManager sharedUserManager] getUsernameFromLocal];
        }
        else if (indexPath.row == 1)
        {
            cell.titleLabel.text = @"是否管理员：";
            if ([[UserManager sharedUserManager] getIsManagerFromLocal]) {
                cell.arrowsLabel.text = @"是";
            }
            else
            {
                cell.arrowsLabel.text = @"否";
            }
        }
    }
    else if (indexPath.section == 1)
    {
        cell.titleLabel.text = @"修改密码";
        cell.arrowsLabel.text = @">";
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            cell.titleLabel.text = @"意见反馈";
            cell.arrowsLabel.text = @">";
        }
        else if (indexPath.row == 1)
        {
            cell.titleLabel.text = @"关于我们";
            cell.arrowsLabel.text = @">";
        }
    }
    else
    {
        cell.titleLabel.text = @"退出登录";
        cell.arrowsLabel.text = @">";
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    }
    else if (indexPath.section == 1)
    {
        ChangePasswordViewController *changePasswordViewController = [[ChangePasswordViewController alloc] init];
        changePasswordViewController.title = @"修改密码";
        changePasswordViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changePasswordViewController animated:YES];
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            SuggestionViewController *suggestionViewController = [[SuggestionViewController alloc] init];
            suggestionViewController.title = @"意见反馈";
            suggestionViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:suggestionViewController animated:YES];
        }
        else if (indexPath.row == 1)
        {
            AboutUsViewController *aboutUsViewController = [[AboutUsViewController alloc] init];
            aboutUsViewController.title = @"关于我们";
            aboutUsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutUsViewController animated:YES];
        }
    }
    else
    {
        [self loadLogOutAlertController];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loadLogOutAlertController
{
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"" otherButtonTitles:@"", nil];
//    [alert show];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确认要退出吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UserManager *userManager = [UserManager sharedUserManager];
        [userManager logOut];//清除信息后弹出登录界面
        LogInViewController *loginViewController = [[LogInViewController alloc] init];
        loginViewController.title = @"登录";
        UINavigationController *loginNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        loginNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
        loginNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
        [self.tabBarController presentViewController:loginNavigationController animated:NO completion:^{
            self.tabBarController.selectedIndex = 0;
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction         * _Nonnull action) {}]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
@end
