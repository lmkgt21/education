//
//  CheckScoreViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/3/18.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>
@interface CheckScoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_checkScoreTableView;
}

@property (nonatomic,retain)  BmobObject *course;

@end
