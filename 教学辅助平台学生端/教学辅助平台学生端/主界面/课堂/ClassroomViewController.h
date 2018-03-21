//
//  ClassroomViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/28.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import "ViewController.h"
#import "UserManager.h"
#import "AddCourseViewController.h"
#import "TitleView.h"
#import "NoNetWorkingView.h"
#import "TransitionView.h"
#import "ClassroomTableViewCell.h"


@interface ClassroomViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NoNetWorkingViewDelegate,ClassroomTableViewCellDelegate>

{
    UITableView *_classroomTableView;
    NSArray *_classroomArray;
    TitleView *_titleView;
    NoNetWorkingView *_noNetWorkingView;
    TransitionView *_transitionView;
}
-(void)downLoadData;
@end
