//
//  DataViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/28.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import "ViewController.h"
#import "UserManager.h"
#import <BmobSDK/Bmob.h>
#import "DataTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "TransitionView.h"
#import "NoNetWorkingView.h"
#import "NewBookViewController.h"
#import "BookDetailViewController.h"
#import "TitleView.h"
@interface DataViewController : UIViewController
<UITableViewDelegate,
UITableViewDataSource,
NoNetWorkingViewDelegate
>

{
    NSArray *_foldersArray;
    NSArray *_booksArray;
    UITableView *_dataTableView;
    NoNetWorkingView *_noNetWorkingView;
    TransitionView *_transitionView;
    TitleView *_titleView;
}
@property (nonatomic,retain) NSString *path;

//在NewBookViewController中调用
-(void)editSuccess;

@end
