//
//  DataViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/28.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import "DataViewController.h"
static NSString *const dataViewControllerTalbeViewCellId = @"dataViewControllerTalbeViewCellId";

@interface DataViewController ()

{
    NSString *_tempObjectId;
}
@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadTableView];
    [self loadEmptyDirView];
    [self loadTransitionView];
    [self loadNoNetWorkingView];
    
    UserManager *userManager = [UserManager sharedUserManager];
    _tempObjectId = [userManager getObjectIdFromLocal];//视图加载完成，记录当前用户
    //先开始动画，然后再进行下载数据
    [_transitionView transitionStart];
    [self downLoadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UserManager *userManager = [UserManager sharedUserManager];
    if (![_tempObjectId isEqualToString: [userManager getObjectIdFromLocal]]) {
        //先去掉按钮
        self.navigationItem.rightBarButtonItem = nil;
        _tempObjectId = [userManager getObjectIdFromLocal];//更新当前用户
        //当用户发生改变时，重新开始动画，然后再进行下载数据
        [_transitionView transitionStart];
        [self downLoadData];
    }
}
-(void)downLoadData
{
    //下载前先将上一次数据置空
    _foldersArray = nil;
    _booksArray = nil;
    UserManager *userManager = [UserManager sharedUserManager];
//    [userManager updateUserInfoFromBackgroundWithblock:^(int result) {
//        if (result == 1) {
    //同时下载文件夹和书籍数据
    [userManager getFolderWithPath:self.path block:^(int result, NSArray *array) {
        if (result == 1) {
            //下载成功，处理数据后停止动画
            _foldersArray = array;
            if (_foldersArray!=nil&&_booksArray!=nil) {
                //当文件夹和书籍都下载完毕后再加载tableView
                [_dataTableView reloadData];
                [_transitionView transitionStop];
                [_dataTableView.mj_header endRefreshing];
                [self loadNavigationControllerSetting];
                if ([_foldersArray count] == 0 && [_booksArray count] == 0) {
                    //当无内容时显示无内容
                    [_titleView titleViewAppear];
                }
            }
        }
        else
        {
            //下载失败，停止动画后进入无网络界面
            [_transitionView transitionStop];
            [_noNetWorkingView NoNetWorkingViewAppear];
            [_dataTableView.mj_header endRefreshing];
        }
    }];
    [userManager getBookWithPath:self.path block:^(int result, NSArray *array) {
        if (result == 1) {
            //下载成功，处理数据后停止动画
            _booksArray = array;
            if (_foldersArray!=nil&&_booksArray!=nil) {
                //当文件夹和书籍都下载完毕后再加载tableView
                [_dataTableView reloadData];
                [_transitionView transitionStop];
                [_dataTableView.mj_header endRefreshing];
                [self loadNavigationControllerSetting];
                if ([_foldersArray count] == 0 && [_booksArray count] == 0) {
                    //当无内容时显示无内容
                    [_titleView titleViewAppear];
                }
            }
        }
        else
        {
            //下载失败，停止动画后进入无网络界面
            [_transitionView transitionStop];
            [_noNetWorkingView NoNetWorkingViewAppear];
            [_dataTableView.mj_header endRefreshing];
        }
    }];
//        }
//        else if (result == 0)
//        {
//            //更新失败，停止动画后进入无网络界面
//            [_transitionView transitionStop];
//            [_noNetWorkingView NoNetWorkingViewAppear];
//            [_dataTableView.mj_header endRefreshing];
//        }
//    }];
}
-(void)loadEmptyDirView
{
    _titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49) title:@"空目录"];
    [self.view addSubview:_titleView];
}
-(void)loadNavigationControllerSetting
{
    UserManager *userManager = [UserManager sharedUserManager];
    if ([userManager getIsManagerFromLocal]) {
        //只有管理员才能编辑
        UIBarButtonItem *menulButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonAction)];
        self.navigationItem.rightBarButtonItem = menulButton;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}
-(void)loadNoNetWorkingView
{
    _noNetWorkingView = [[NoNetWorkingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49)];
    [self.view addSubview:_noNetWorkingView];
    _noNetWorkingView.delegate = self;
}
-(void)loadTransitionView
{
    _transitionView = [[TransitionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49) backgroundCorlor:[UIColor whiteColor] title:@"加载中…"];
    [self.view addSubview:_transitionView];
}
-(void)loadTableView
{
    _dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStyleGrouped];
    [self.view addSubview:_dataTableView];
    //设置
    _dataTableView.delegate = self;
    _dataTableView.dataSource = self;
    [_dataTableView registerClass:[DataTableViewCell class] forCellReuseIdentifier:dataViewControllerTalbeViewCellId];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewPulldown)];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    _dataTableView.mj_header = header;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_foldersArray count] + [_booksArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dataViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < [_foldersArray count]) {
        //文件夹数据
        [cell.folderOrDocumentImageView setImage:[UIImage imageNamed:@"文件夹"]];
        cell.nameLabel.text = [_foldersArray[indexPath.row] objectForKey:@"folderName"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        cell.subheadLabel.text = [dateFormatter stringFromDate:[_foldersArray[indexPath.row] createdAt]];
        cell.subheadLabel.textColor = [UIColor grayColor];
    }
    else
    {
        //书籍数据
        [cell.folderOrDocumentImageView setImage:[UIImage imageNamed:@"文件"]];
        cell.nameLabel.text = [_booksArray[indexPath.row-[_foldersArray count]] objectForKey:@"bookName"];
        cell.subheadLabel.text = [NSString stringWithFormat:@"作者：%@",[[_booksArray[indexPath.row-[_foldersArray count]] objectForKey:@"bookInfo"] objectForKey:@"作者"]];
        cell.subheadLabel.textColor = [UIColor darkGrayColor];
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [_foldersArray count]){
        //点击文件夹
        DataViewController *dataViewController = [[DataViewController alloc] init];
        dataViewController.title = [_foldersArray[indexPath.row] objectForKey:@"folderName"];
        dataViewController.path = [NSString stringWithFormat:@"%@/%@",self.path,[_foldersArray[indexPath.row] objectForKey:@"folderName"]];
        [self.navigationController pushViewController:dataViewController animated:YES];
    }
    else
    {
        //点击书籍
        BookDetailViewController *bookDetailViewController = [[BookDetailViewController alloc] init];
        bookDetailViewController.title = @"书籍信息";
        bookDetailViewController.hidesBottomBarWhenPushed = YES;
        bookDetailViewController.bookName = [_booksArray[indexPath.row-[_foldersArray count]] objectForKey:@"bookName"];
        bookDetailViewController.bookInfo = [_booksArray[indexPath.row-[_foldersArray count]] objectForKey:@"bookInfo"];
        [self.navigationController pushViewController:bookDetailViewController animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }
    return 0;
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
-(void)byClick
{
    //点击重试后，先关闭无网络界面，再开始动画，最后进行重新下载
    [_noNetWorkingView NoNetWorkingViewDisappear];
    [_transitionView transitionStart];
    [self downLoadData];
}
-(void)tableViewPulldown
{
    //不进行动画后直接进行下载
    [self downLoadData];
}
-(void)menuButtonAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"新建文件夹" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loadNewFolderAlertController];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"删除文件夹" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loadDeleteFolderAlertController];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"新建书籍" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NewBookViewController *newBookViewController = [[NewBookViewController alloc] init];
        UINavigationController *newBookNavigationController = [[UINavigationController alloc] initWithRootViewController:newBookViewController];
        newBookNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
        newBookNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
        newBookNavigationController.navigationBar.tintColor = [UIColor whiteColor];
        newBookViewController.dataViewController = self;
        [self presentViewController:newBookNavigationController animated:YES completion:^{}];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"删除书籍" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loadDeleteBookAlertController];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction         * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)loadNewFolderAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新建文件夹" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {}];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UserManager *userManager = [UserManager sharedUserManager];
        [userManager newFolderWithName:alertController.textFields[0].text path:self.path block:^(int result) {
            if (result == 1) {
                [self editSuccess];
            }
            else if (result == 0)
            {
                [self loadAlertControllerWithTitle:@"新建失败！" massage:@"请检查网络后重试"];
            }
            else if (result == -1)
            {
                
                [self loadAlertControllerWithTitle:@"提示" massage:[NSString stringWithFormat:@"名称'%@'已存在，请使用其它名称",alertController.textFields[0].text]];
            }
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction         * _Nonnull action) {}]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

-(void)loadDeleteFolderAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除文件夹" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {}];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *objectId = nil;
        for (BmobObject *bmobObject in _foldersArray) {
            if ([alertController.textFields[0].text isEqualToString:[bmobObject objectForKey:@"folderName"]]) {
                objectId = [bmobObject objectId];
                break;
            }
        }
        if (objectId == nil) {
            [self loadAlertControllerWithTitle:@"该文件名不存在！" massage:nil];
        }
        else
        {
            UserManager *userManager = [UserManager sharedUserManager];
            [userManager removeFolderWithObjectId:objectId Name:alertController.textFields[0].text path:self.path block:^(int result) {
                if (result == 1) {
                    [self editSuccess];
                }
                else if (result == 0)
                {
                    [self loadAlertControllerWithTitle:@"删除失败！" massage:@"请检查网络后重试"];
                }
                else if (result == -1)
                {
                    [self loadAlertControllerWithTitle:@"只能删除空文件夹！" massage:@"若要删除，请先删除其内容"];
                }
            }];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction         * _Nonnull action) {}]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)loadDeleteBookAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除书籍" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {}];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *objectId = nil;
        for (BmobObject *bmobObject in _booksArray) {
            if ([alertController.textFields[0].text isEqualToString:[bmobObject objectForKey:@"bookName"]]) {
                objectId = [bmobObject objectId];
                break;//当遇到第一个匹配的书籍名时退出循环，因此删除同名书籍时永远删除第一个
            }
        }
        if (objectId == nil) {
            [self loadAlertControllerWithTitle:@"该书籍不存在！" massage:nil];
        }
        else
        {
            UserManager *userManager = [UserManager sharedUserManager];
            [userManager removeBookWithObjectId:objectId block:^(int result) {
                if (result == 1) {
                    [self editSuccess];
                }
                else
                {
                    [self loadAlertControllerWithTitle:@"删除失败！" massage:@"请检查网络后重试"];
                }
            }];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction         * _Nonnull action) {}]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)loadAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)editSuccess
{
    //成功后立即开始动画后进行下载
    //对于当前目录为空的情况，先关闭没有内容画面
    [_titleView titleViewDisappear];
    [_transitionView transitionStart];
    [self downLoadData];
}
@end
