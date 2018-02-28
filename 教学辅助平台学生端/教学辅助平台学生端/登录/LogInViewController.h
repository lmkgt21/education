//
//  LogInViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/29.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "TransitionView.h"
#import "RegisterViewController.h"
@interface LogInViewController : ViewController<UITextFieldDelegate>

{
    UITextField *_usernameTextField;
    UITextField *_passwordTextField;
    UIButton *_logInButton;
    UIButton *_registerButton;
    TransitionView *_transitionView;
}
@end
