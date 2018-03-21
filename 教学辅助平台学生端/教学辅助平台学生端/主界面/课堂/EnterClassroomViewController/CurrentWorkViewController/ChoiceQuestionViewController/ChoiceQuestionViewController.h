//
//  ChoiceQuestionViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/3/18.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>
#import "NoNetWorkingView.h"
#import "TransitionView.h"
#import "CurrentWorkViewController.h"
@interface ChoiceQuestionViewController : UIViewController<NoNetWorkingViewDelegate>

{
    NoNetWorkingView *_noNetWorkingView;
    TransitionView *_transitionView;
    
    UIScrollView *_scrollView;
    UIImageView *_circleImageView;
    UIImageView *_circleImageView2;
    UIImageView *_circleImageView3;
    UIImageView *_circleImageView4;
    NSString *_answer;

    UILabel *_questionLabel;
    UILabel *_choiceALabel;
    UILabel *_choiceBLabel;
    UILabel *_choiceCLabel;
    UILabel *_choiceDLabel;
    
    UIButton *_lastquestionButton;
    UIButton *_nextquestionButton;
}
@property (nonatomic,retain)    BmobObject *course;
@property (nonatomic,retain)    NSArray *questionsArray;
@property (atomic)   double score;
@property (atomic)   int count;
@property (nonatomic,retain)    CurrentWorkViewController *currentWorkViewController;
@end
