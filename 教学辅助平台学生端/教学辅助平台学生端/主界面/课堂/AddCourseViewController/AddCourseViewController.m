//
//  AddCourseViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/7.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "AddCourseViewController.h"
#import "ClassroomViewController.h"
static NSString *const addCourseViewControllerTalbeViewCellId = @"addCourseViewControllerTalbeViewCellId";
@interface AddCourseViewController ()

@end

@implementation AddCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self loadNavigationControllerSetting];
    [self loadSearchView];
    [self loadTableView];
    [self loadTransitionView];
    [self loadTransitionView2];
    [self loadNoNetWorkingView];
    [self loadEmptyCourseView];
    
    [self downloadCoursesWithKeyword:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_addCourseTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)downloadCoursesWithKeyword:(NSString *)keyword;
{
    //先让textfield不可交互
    _addCourseTextField.userInteractionEnabled = NO;
    //开启动画前先关闭无网络界面、空课程界面
    [_titleView titleViewDisappear];
    [_noNetWorkingView NoNetWorkingViewDisappear];
    //开启动画
    [_transitionView transitionStart];
    UserManager *usermanager = [UserManager sharedUserManager];
    [usermanager getCoursesWithKeyword:keyword block:^(int result, NSArray *array) {
        //先关闭动画
        [_transitionView transitionStop];
        if (result == 1) {
            //只有成功的情况下才让它textfield可交互
            _addCourseTextField.userInteractionEnabled = YES;
            if (array.count == 0) {
                //没有对应课程，显示无课程
                [_titleView titleViewAppear];
            }
            else
            {
                _coursesArray = array;
                [_addCourseTableView reloadData];
            }
        }
        else
        {
            //下载失败，显示无网络画面
            [_noNetWorkingView NoNetWorkingViewAppear];
        }
    }];
}
-(void)loadNavigationControllerSetting
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}
-(void)cancelButtonAction
{
    //先关闭键盘
    [_addCourseTextField resignFirstResponder];
    //弹出时由navigationController弹出，因此弹回 也由navigationController
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loadEmptyCourseView
{
    _titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64-50) title:@"没有相关课程"];
    [self.view addSubview:_titleView];
}
-(void)loadNoNetWorkingView
{
    _noNetWorkingView = [[NoNetWorkingView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64-50)];
    [self.view addSubview:_noNetWorkingView];
    _noNetWorkingView.delegate = self;
}
-(void)byClick
{
    //即使点击事件不能传递到self.view被处理，但无网络界面时的textfield不可交互，而这个时候键盘且已经关闭，因此可行
    if (_addCourseTextField.text.length == 0) {
        [self downloadCoursesWithKeyword:nil];
    }
    else
    {
        [self downloadCoursesWithKeyword:_addCourseTextField.text];
    }
}
-(void)loadTransitionView
{
    _transitionView = [[TransitionView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64-50) backgroundCorlor:[UIColor whiteColor] title:@"加载中…"];
    [self.view addSubview:_transitionView];
}
-(void)loadTransitionView2
{
    _transitionView2 = [[TransitionView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64-50) backgroundCorlor:[UIColor clearColor] title:@"提交中…"];
    [self.view addSubview:_transitionView2];
}
-(void)loadSearchView
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    backgroundView.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    [self.view addSubview:backgroundView];

    _addCourseTextField = [[UITextField alloc] initWithFrame:CGRectMake(25, 10, self.view.frame.size.width-50-45, 30)];
    [backgroundView addSubview:_addCourseTextField];
    _addCourseTextField.placeholder = @"教师/课程名";
    _addCourseTextField.backgroundColor = [UIColor whiteColor];
    _addCourseTextField.textAlignment = NSTextAlignmentCenter;
    _addCourseTextField.layer.cornerRadius = 7;
    _addCourseTextField.font = [UIFont systemFontOfSize:17];
    _addCourseTextField.delegate = self;
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backgroundView addSubview:searchButton];
    searchButton.frame = CGRectMake(self.view.frame.size.width-25-40, 15, 40, 20);
    [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:@"检索" forState:UIControlStateNormal];
    [searchButton setTitle:@"检索" forState:UIControlStateHighlighted];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
}
-(void)searchButtonAction
{
    //先关闭键盘
    [_addCourseTextField resignFirstResponder];
    if (_addCourseTextField.text.length == 0) {
        [self downloadCoursesWithKeyword:nil];
    }
    else
    {
        [self downloadCoursesWithKeyword:_addCourseTextField.text];
    }
}
-(void)loadTableView
{
    _addCourseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64-50) style:UITableViewStyleGrouped];
    [self.view addSubview:_addCourseTableView];
    _addCourseTableView.dataSource = self;
    _addCourseTableView.delegate = self;
    _addCourseTableView.backgroundColor = [UIColor whiteColor];
    [_addCourseTableView registerClass:[AddCourseTableViewCell class] forCellReuseIdentifier:addCourseViewControllerTalbeViewCellId];
    _addCourseTableView.bounces = NO;
    _addCourseTableView.tableHeaderView = [self createHeaderView];
    //_addCourseTableView.tableFooterView = [self createFooterView];
}
-(UIView *)createHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, self.view.frame.size.width-50, 20)];
    [headerView addSubview:label];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:17];
    label.text = @"可加入的课堂";
    label.textAlignment = NSTextAlignmentCenter;
    return headerView;
}
-(UIView *)createFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    footerView.backgroundColor = [UIColor whiteColor];
    return footerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _coursesArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addCourseViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.courseNameLabel.text = [_coursesArray[indexPath.row] objectForKey:@"coursename"];
    cell.teacherNameLabel.text = [NSString stringWithFormat:@"教师：%@",[_coursesArray[indexPath.row] objectForKey:@"teachername"]];
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
    //先开始动画
    [_transitionView2 transitionStart];
    UserManager *usermanager = [UserManager sharedUserManager];
    [usermanager addCourse:_coursesArray[indexPath.row] block:^(int result) {
        //请求结束后先关闭动画
        [_transitionView2 transitionStop];
        if (result == 1) {
            [self loadSuccessAlertController];
        }
        else
        {
            [self loadAlertControllerWithTitle:@"加入失败！" massage:@"请检查网络"];
        }
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_addCourseTextField resignFirstResponder];
    return YES;
}
-(void)loadAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)loadSuccessAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"加入成功！" message:@"注意，重复加入无效" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [self.classroomViewController downLoadData];
        }];
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
@end
