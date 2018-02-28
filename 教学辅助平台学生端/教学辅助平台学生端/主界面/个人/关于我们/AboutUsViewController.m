//
//  AboutUsViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/2.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self loadOtherViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadOtherViews
{
    //logo
    UIImageView *bigLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_big_circle"]];
    [self.view addSubview:bigLogoImageView];
    [bigLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(25);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@90);
        make.height.equalTo(@90);
    }];
    UILabel *logoLabel = [[UILabel alloc] init];
    [self.view addSubview:logoLabel];
    [logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bigLogoImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@25);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
    }];
    logoLabel.text = @"六零学堂";
    logoLabel.textAlignment = NSTextAlignmentCenter;
    [logoLabel setFont:[UIFont systemFontOfSize:22]];
    
    UILabel *versionLabel = [[UILabel alloc] init];
    [self.view addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoLabel.mas_bottom).offset(15);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@20);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
    }];
    versionLabel.text = @"v1.0.0";
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.textColor = [UIColor darkGrayColor];
    [versionLabel setFont:[UIFont systemFontOfSize:17]];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
