//
//  SuggestionViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/2.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionView.h"
#import "UserManager.h"
@interface SuggestionViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>

{
    UIScrollView *_scrollView;
    
    UIImageView *_circleImageView;
    UIImageView *_circleImageView2;
    UIImageView *_circleImageView3;
    
    UITextView *_detailDescribeTextView;//获取详细描述数据
    UILabel *_textViewPlacehoder;
    
    UITextField *_contactTextField;//获取联系方式数据
    NSString *_suggestionType;//获取反馈类型
    
    UIButton *_submitButton;
    
    TransitionView *_transitionView;
}
@end
