//
//  ChangePasswordViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/2.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "TransitionView.h"
#import "UserManager.h"
@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate>

{
    UITextField *_passwordTextField;
    UITextField *_passwordTextField2;
    UIButton *_submitButton;
    TransitionView *_transitionView;
}
@end
