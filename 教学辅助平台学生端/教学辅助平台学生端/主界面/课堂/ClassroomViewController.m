//
//  ClassroomViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/28.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import "ClassroomViewController.h"
#import "EnterClassroomViewController.h"
#import <MJRefresh.h>
static NSString *const classroomViewControllerTalbeViewCellId = @"classroomViewControllerTalbeViewCellId";
@interface ClassroomViewController ()

{
    NSString *_tempObjectId;
}
@end

@implementation ClassroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNavigationControllerSetting];
    UserManager *userManager = [UserManager sharedUserManager];
    _tempObjectId = [userManager getObjectIdFromLocal];//视图加载完成，记录当前用户
    [self loadTableView];
    [self loadTransitionView];
    [self loadEmptyDirView];
    [self loadNoNetWorkingView];
    [self downLoadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UserManager *userManager = [UserManager sharedUserManager];
    if (![_tempObjectId isEqualToString: [userManager getObjectIdFromLocal]]) {
        _tempObjectId = [userManager getObjectIdFromLocal];//更新当前用户
        //当用户发生改变时，进行的操作
        [self downLoadData];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadNavigationControllerSetting
{
    UIBarButtonItem *menulButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonAction)];
    self.navigationItem.rightBarButtonItem = menulButton;
}
-(void)menuButtonAction
{
    //弹出添加课堂界面界面
    AddCourseViewController *addCourseViewController = [[AddCourseViewController alloc] init];
    addCourseViewController.title = @"添加";
    addCourseViewController.classroomViewController = self;
    UINavigationController *addCourseNavigationController = [[UINavigationController alloc] initWithRootViewController:addCourseViewController];
    addCourseNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
    addCourseNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
    addCourseNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController presentViewController:addCourseNavigationController animated:YES completion:^{}];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)downLoadData
{
    //先关闭无网络界面和空目录界面
    [_noNetWorkingView NoNetWorkingViewDisappear];
    [_titleView titleViewDisappear];
    //下载前先开启动画
    [_transitionView transitionStart];
    UserManager *userManager = [UserManager sharedUserManager];
    [userManager getCoursesOfSutentWithBlock:^(int result, NSArray *array) {
        //请求完不管成功与否先关闭动画
        [_transitionView transitionStop];
        if (result == 1) {
            //下载成功
            if (array.count == 0) {
                //显示未加入课程
                [_titleView titleViewAppear];
            }
            else
            {
                _classroomArray = array;
                [_classroomTableView reloadData];
            }
        }
        else
        {
            //下载失败，显示无网络界面
            [_noNetWorkingView NoNetWorkingViewAppear];
        }
    }];
}
-(void)loadEmptyDirView
{
    _titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) title:@"您还没有加入任何课程"];
    [self.view addSubview:_titleView];
}
-(void)loadNoNetWorkingView
{
    _noNetWorkingView = [[NoNetWorkingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:_noNetWorkingView];
    _noNetWorkingView.delegate = self;
}
-(void)byClick
{
    [self downLoadData];
}
-(void)loadTransitionView
{
    _transitionView = [[TransitionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) backgroundCorlor:[UIColor whiteColor] title:@"加载中…"];
    [self.view addSubview:_transitionView];
}
-(void)loadTableView
{
    _classroomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStyleGrouped];
    [self.view addSubview:_classroomTableView];
    _classroomTableView.dataSource = self;
    _classroomTableView.delegate = self;
    _classroomTableView.backgroundColor = [UIColor whiteColor];
    [_classroomTableView registerClass:[ClassroomTableViewCell class] forCellReuseIdentifier:classroomViewControllerTalbeViewCellId];
    _classroomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewPulldown)];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    _classroomTableView.mj_header = header;
}
-(void)tableViewPulldown
{
    [_classroomTableView.mj_header endRefreshing];
    [self downLoadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _classroomArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassroomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:classroomViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.courseNameLabel.text = [_classroomArray[indexPath.row] objectForKey:@"coursename"];
    cell.teacherNameLabel.text = [NSString stringWithFormat:@"教师：%@",[_classroomArray[indexPath.row] objectForKey:@"teachername"]];
    return cell;
}
-(void)whenClassroomTableViewCellClickWith:(NSIndexPath *)indexPath
{
    
    [self loadAlertControllerWithTitle:@"确定要退出这个课堂吗" indexPath:indexPath];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EnterClassroomViewController *enterClassroomViewController = [[EnterClassroomViewController alloc] init];
    enterClassroomViewController.title = [_classroomArray[indexPath.row] objectForKey:@"coursename"];
    enterClassroomViewController.hidesBottomBarWhenPushed = YES;
    enterClassroomViewController.course = _classroomArray[indexPath.row];
    [self.navigationController pushViewController:enterClassroomViewController animated:YES];
}
-(void)loadAlertControllerWithTitle:(NSString *) title indexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:[_classroomArray[indexPath.row] objectForKey:@"coursename"] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UserManager *userManager = [UserManager sharedUserManager];
        [userManager removeCourse:_classroomArray[indexPath.row] block:^(int result) {
            if (result == 1) {
                //删除成功
                [self downLoadData];
            }
            else
            {
                //删除失败
                [self loadAlertControllerWithTitle:@"操作失败！" massage:@"请检查网络后重试"];
            }
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction         * _Nonnull action) {}]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)loadAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
@end
