//
//  RegisterViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/3.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "TransitionView.h"
#import "UserManager.h"
@interface RegisterViewController : UIViewController<UITextFieldDelegate>

{
    UITextField *_usernameTextField;
    UITextField *_passwordTextField;
    UIButton *_registerButton;
    TransitionView *_transitionView;
}
@end
