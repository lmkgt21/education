//
//  NewBookViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/7.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "TransitionView.h"
@class DataViewController;//接口中只用到了它的名称，实现部分用到了它的接口，因此在实现部分导入.h
@interface NewBookViewController : UIViewController

{
    UITextField *_nameTextField;//书名
    UITextField *_authorTextField;//作者
    UITextField *_ISBNTextField;//ISBN
    UITextView *_introductionTextView;//简介
    UITextField *_linkTextField;//链接
    UITextField *_passwordTextField;//密码
    
    TransitionView *_transitionView;
}
@property(nonatomic,retain) DataViewController *dataViewController;
@end
