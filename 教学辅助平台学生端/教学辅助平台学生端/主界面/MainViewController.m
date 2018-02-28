//
//  MainViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/28.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadFourViews];
}
-(void)loadFourViews
{
    ClassroomViewController *classroomViewController = [[ClassroomViewController  alloc] init];
    classroomViewController.title = @"课堂";
    UINavigationController *classroomNavigationController = [[UINavigationController alloc] initWithRootViewController:classroomViewController];
    UITabBarItem *classroomTabBarItem = [[UITabBarItem alloc] initWithTitle:@"课堂" image:[UIImage imageNamed:@"课堂"] selectedImage:[UIImage imageNamed:@"课堂_selected"]];
    classroomNavigationController.tabBarItem = classroomTabBarItem;
    classroomNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    classroomNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
    classroomNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    DataViewController *dataViewController = [[DataViewController  alloc] init];
    dataViewController.title = @"资料";
    dataViewController.path = @"root";
    UINavigationController *dataNavigationController = [[UINavigationController alloc] initWithRootViewController:dataViewController];
    UITabBarItem *dataTabBarItem = [[UITabBarItem alloc] initWithTitle:@"资料" image:[UIImage imageNamed:@"资料"] selectedImage:[UIImage imageNamed:@"资料_selected"]];
    dataNavigationController.tabBarItem = dataTabBarItem;
    dataNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    dataNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
    dataNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    CommunityViewController *communityViewController = [[CommunityViewController  alloc] init];
    communityViewController.title = @"社区";
    UINavigationController *communityNavigationController = [[UINavigationController alloc] initWithRootViewController:communityViewController];
    UITabBarItem *communityTabBarItem = [[UITabBarItem alloc] initWithTitle:@"社区" image:[UIImage imageNamed:@"社区"] selectedImage:[UIImage imageNamed:@"社区_selected"]];
    communityNavigationController.tabBarItem = communityTabBarItem;
    communityNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    communityNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
    communityNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    PersonalViewController *personalViewController = [[PersonalViewController  alloc] init];
    personalViewController.title = @"个人";
    UINavigationController *personalNavigationController = [[UINavigationController alloc] initWithRootViewController:personalViewController];
    UITabBarItem *personalTabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:[UIImage imageNamed:@"个人"] selectedImage:[UIImage imageNamed:@"个人_selected"]];
    personalNavigationController.tabBarItem = personalTabBarItem;
    personalNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    personalNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
    personalNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    NSArray *viewControllers = @[classroomNavigationController,dataNavigationController,personalNavigationController];
    [self setViewControllers:viewControllers];
    
    [[UINavigationBar appearance] setTranslucent:NO];//设置所有导航为不透明
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UserManager *userManager = [UserManager sharedUserManager];
    if (![userManager isLogin]) {
        //如果没有登录就先登录
        LogInViewController *loginViewController = [[LogInViewController alloc] init];
        loginViewController.title = @"登录";
        UINavigationController *loginNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        loginNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
        loginNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
        [self presentViewController:loginNavigationController animated:NO completion:^{}];
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
@end
