//
//  BookDetailViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/8.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailViewController : UIViewController

{
    UIScrollView *_scrollView;
    
    UIView *_nameBackgroundView;
    UIView *_authorBackgroundView;
    UIView *_ISBNBackgroundView;
    UIView *_introductionBackgroundView;
    UIView *_linkBackgroundView;
    UIView *_passwordBackgroundView;
}
@property (nonatomic,retain) NSString *bookName;
@property (nonatomic,retain) NSDictionary *bookInfo;
@end
