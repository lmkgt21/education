//
//  AddCourseViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/7.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionView.h"
#import "NoNetWorkingView.h"
#import "TitleView.h"
#import "UserManager.h"
#import "AddCourseTableViewCell.h"
@class ClassroomViewController;
@interface AddCourseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NoNetWorkingViewDelegate,UITextFieldDelegate>
{
    NoNetWorkingView *_noNetWorkingView;
    TransitionView *_transitionView;
    TransitionView *_transitionView2;
    TitleView *_titleView;
    UITableView *_addCourseTableView;
    UITextField *_addCourseTextField;
    NSArray *_coursesArray;
}
@property (nonatomic,retain) ClassroomViewController *classroomViewController;
@end
