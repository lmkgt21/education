//
//  PersonalViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/28.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import "ViewController.h"
#import "PersonalTableViewCell.h"
#import "LogInViewController.h"
#import "UserManager.h"
#import "ChangePasswordViewController.h"
#import "AboutUsViewController.h"
#import "SuggestionViewController.h"
@interface PersonalViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_personalTableView;
}
@end
