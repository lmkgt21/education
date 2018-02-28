//
//  ChangePasswordViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/2.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    // Do any additional setup after loading the view.
    [self loadOtherViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadOtherViews
{
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    [self.view addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(35);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@100);
    }];
    backgroundImageView.backgroundColor = [UIColor whiteColor];
    backgroundImageView.userInteractionEnabled = YES;
    //线
    UIImageView *line = [[UIImageView alloc] init];
    [backgroundImageView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@50);
        make.height.equalTo(@1);
        make.left.equalTo(backgroundImageView.mas_left);
        make.right.equalTo(backgroundImageView.mas_right);
    }];
    line.backgroundColor = [UIColor colorWithRed:192/256.0 green:192/256.0 blue:192/256.0 alpha:1];
    //新密码标签
    UILabel *passwordLabel = [[UILabel alloc] init];
    [backgroundImageView addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundImageView.mas_left).offset(25);
        make.bottom.equalTo(line.mas_top).offset(-15);
        make.height.equalTo(@20);
        make.width.equalTo(@80);
    }];
    passwordLabel.text = @"新密码";
    [passwordLabel setFont:[UIFont systemFontOfSize:17]];
    //确认密码标签
    UILabel *passwordLabel2 = [[UILabel alloc] init];
    [backgroundImageView addSubview:passwordLabel2];
    [passwordLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundImageView.mas_left).offset(25);
        make.bottom.equalTo(backgroundImageView.mas_bottom).offset(-15);
        make.height.equalTo(@20);
        make.width.equalTo(@80);
    }];
    passwordLabel2.text = @"确认密码";
    [passwordLabel2 setFont:[UIFont systemFontOfSize:17]];
    //密码输入框1
    _passwordTextField = [[UITextField alloc] init];
    [backgroundImageView addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundImageView.mas_right).offset(-25);
        make.left.equalTo(passwordLabel.mas_right).offset(10);
        make.bottom.equalTo(line.mas_top).offset(-15);
        make.height.equalTo(@20);
    }];
    _passwordTextField.placeholder = @"请输入新密码";
    [_passwordTextField setFont:[UIFont systemFontOfSize:17]];
    _passwordTextField.delegate = self;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_passwordTextField addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    _passwordTextField.secureTextEntry = YES;
    //密码输入框2
    _passwordTextField2 = [[UITextField alloc] init];
    [backgroundImageView addSubview:_passwordTextField2];
    [_passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundImageView.mas_right).offset(-25);
        make.left.equalTo(passwordLabel2.mas_right).offset(10);
        make.bottom.equalTo(backgroundImageView.mas_bottom).offset(-15);
        make.height.equalTo(@20);
    }];
    _passwordTextField2.placeholder = @"请再次输入新密码";
    [_passwordTextField2 setFont:[UIFont systemFontOfSize:17]];
    _passwordTextField2.delegate = self;
    _passwordTextField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_passwordTextField2 addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    _passwordTextField2.secureTextEntry = YES;
    //密码说明标签
    UILabel *passwordExplainLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 150, self.view.frame.size.width-50, 0)];
    [self.view addSubview:passwordExplainLabel];
    [passwordExplainLabel setFont:[UIFont systemFontOfSize:16]];
    passwordExplainLabel.textColor = [UIColor darkGrayColor];
    passwordExplainLabel.text = @"密码长度6~14个字符，可包含数字、大小写字母，符号，不包含空格。";
    passwordExplainLabel.numberOfLines = 0;
    [passwordExplainLabel sizeToFit];
    //提交按钮
    _submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:_submitButton];
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.height.equalTo(@50);
        make.top.equalTo(self.view.mas_centerY).offset(-50);
    }];
    _submitButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:0.5];
    [_submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_submitButton setTitle:@"提交" forState:UIControlStateHighlighted];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    _submitButton.layer.cornerRadius = 7;
    _submitButton.userInteractionEnabled = NO;
    //过渡画面，要放到顶层
    _transitionView = [[TransitionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) backgroundCorlor:[UIColor clearColor] title:nil];
    [self.view addSubview:_transitionView];
    //处理单击，来放弃第一响应者
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
    [self.view addGestureRecognizer:singleTap];
}
-(void)singleTapAction
{
    //放弃第一响应者
    [_passwordTextField resignFirstResponder];
    [_passwordTextField2 resignFirstResponder];
}
-(void)valueChanged
{
    //只有检测到同时有值时才让提交按钮实质显示并且可点击
    if ((_passwordTextField.text != nil&&![_passwordTextField.text  isEqual: @""]) && (_passwordTextField2.text != nil&&![_passwordTextField2.text  isEqual: @""])) {
        _submitButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
        _submitButton.userInteractionEnabled = YES;
    }
    else
    {
        _submitButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:0.5];
        _submitButton.userInteractionEnabled = NO;
    }
}
-(void)submitButtonAction
{
    //放弃第一响应者
    [_passwordTextField resignFirstResponder];
    [_passwordTextField2 resignFirstResponder];
    //先对密码进行本地处理
    if ([_passwordTextField.text length] > 14 || [_passwordTextField.text length] < 6 || [_passwordTextField.text containsString:@" "])
    {
        //第一次输入密码不符合要求
        [self loadAlertControllerWithTitle:@"密码格式不正确！" massage:@"长度6~14个字符，可包含数字、大小写字母，符号，不包含空格"];
    }
    else
    {
        //第一次输入密码符合要求后再检查两次输入是否一致
        if ([_passwordTextField.text isEqualToString:_passwordTextField2.text]) {
            //开始动画
            [_transitionView transitionStart];
            UserManager *userManager = [UserManager sharedUserManager];
            [userManager changeWithNewPassword:_passwordTextField.text block:^(int result) {
                //先停止动画
                [_transitionView transitionStop];
                if (result == 1) {
                    [self loadSuccessAlertController];
                }
                else if (result == 0)
                {
                    [self loadAlertControllerWithTitle:@"修改失败！" massage:@"请检查网络后重试"];
                }
            }];
        }
        else
        {
            [self loadAlertControllerWithTitle:@"两次输入密码不一致！" massage:@"请确认两次输入密码一致后重试"];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_passwordTextField resignFirstResponder];
    [_passwordTextField2 resignFirstResponder];
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_passwordTextField resignFirstResponder];
    [_passwordTextField2 resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loadAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)loadSuccessAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改成功！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

@end
