//
//  main.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/26.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [Bmob registerWithAppKey:@"553fe6bda09a05e020153c9c8aee2dd7"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
