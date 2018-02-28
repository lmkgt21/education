//
//  RegisterViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/3.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNavigationControllerSetting];
    [self loadOtherViews];
}
-(void)loadNavigationControllerSetting
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}
-(void)cancelButtonAction
{
    //放弃第一响应者
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    //弹出时由navigationController弹出，因此弹回 也由navigationController
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}
-(void)loadOtherViews
{
    UILabel *userLabel = [[UILabel alloc] init];
    [self.view addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@160);
        make.height.equalTo(@40);
        make.centerY.equalTo(self.view.mas_centerY).offset(-210);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    userLabel.text = @"用户注册";
    userLabel.textAlignment = NSTextAlignmentCenter;
    [userLabel setFont:[UIFont systemFontOfSize:30]];
    //userLabel.textColor = [UIColor grayColor];
    //线1
    UIImageView *line1 = [[UIImageView alloc] init];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(-120);
        make.height.equalTo(@1);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
    }];
    line1.backgroundColor = [UIColor colorWithRed:192/256.0 green:192/256.0 blue:192/256.0 alpha:1];
    //线2
    UIImageView *line2 = [[UIImageView alloc] init];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(-70);
        make.height.equalTo(@1);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
    }];
    line2.backgroundColor = [UIColor colorWithRed:192/256.0 green:192/256.0 blue:192/256.0 alpha:1];
    //用户标签
    UILabel *usernameLabel = [[UILabel alloc] init];
    [self.view addSubview:usernameLabel];
    [usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(25);
        make.bottom.equalTo(line1.mas_top).offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
    usernameLabel.text = @"用户";
    [usernameLabel setFont:[UIFont systemFontOfSize:17]];
    //密码标签
    UILabel *passwordLabel = [[UILabel alloc] init];
    [self.view addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(25);
        make.bottom.equalTo(line2.mas_top).offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
    passwordLabel.text = @"密码";
    [passwordLabel setFont:[UIFont systemFontOfSize:17]];
    //用户输入框
    _usernameTextField = [[UITextField alloc] init];
    [self.view addSubview:_usernameTextField];
    [_usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.left.equalTo(usernameLabel.mas_right).offset(20);
        make.bottom.equalTo(line1.mas_top).offset(-10);
        make.height.equalTo(@20);
    }];
    _usernameTextField.placeholder = @"请输入用户名";
    [_usernameTextField setFont:[UIFont systemFontOfSize:17]];
    _usernameTextField.delegate = self;
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_usernameTextField addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    _usernameTextField.keyboardType = UIKeyboardTypeDefault;
    //密码输入框
    _passwordTextField = [[UITextField alloc] init];
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.left.equalTo(passwordLabel.mas_right).offset(20);
        make.bottom.equalTo(line2.mas_top).offset(-10);
        make.height.equalTo(@20);
    }];
    _passwordTextField.placeholder = @"请输入登录密码";
    [_passwordTextField setFont:[UIFont systemFontOfSize:17]];
    _passwordTextField.delegate = self;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_passwordTextField addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    _passwordTextField.secureTextEntry = YES;
    //注册按钮
    _registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.height.equalTo(@50);
        make.top.equalTo(self.view.mas_centerY).offset(-30);
    }];
    _registerButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:0.5];
    [_registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitle:@"注册" forState:UIControlStateHighlighted];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    _registerButton.layer.cornerRadius = 7;
    _registerButton.userInteractionEnabled = NO;
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
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}
-(void)valueChanged
{
    //只有检测到用户名和密码同时有值时才让登录按钮实质显示并且可点击
    if ((_usernameTextField.text != nil&&![_usernameTextField.text  isEqual: @""]) && (_passwordTextField.text != nil&&![_passwordTextField.text  isEqual: @""])) {
        _registerButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
        _registerButton.userInteractionEnabled = YES;
    }
    else
    {
        _registerButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:0.5];
        _registerButton.userInteractionEnabled = NO;
    }
}
-(void)registerButtonAction
{
    //放弃第一响应者
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    //先对用户名和密码进行本地处理
    if ([_usernameTextField.text length] > 14 || [_usernameTextField.text containsString:@" "]) {
        //用户名不符合
        [self loadAlertControllerWithTitle:@"用户名格式不正确！" massage:@"最长14个英文或7个汉字，不能包含空格"];
    }
    else
    {
        if ([_passwordTextField.text length] > 14 || [_passwordTextField.text length] < 6 || [_passwordTextField.text containsString:@" "])
        {
            //密码不符合
            [self loadAlertControllerWithTitle:@"密码格式不正确！" massage:@"长度6~14个字符，可包含数字、大小写字母，符号，不包含空格"];
        }
        else
        {
            //用户名和密码都符合要求，即将提交到后台
            //开始动画
            [_transitionView transitionStart];
            UserManager *usermanager = [UserManager sharedUserManager];
            [usermanager toRegister:_usernameTextField.text with:_passwordTextField.text block:^(int result) {
                //先停止动画
                [_transitionView transitionStop];
                if (result == 1) {
                    [self loadSuccessAlertController];
                }
                else if (result == -1)
                {
                    [self loadAlertControllerWithTitle:@"用户名已存在！" massage:@"请重新输入"];
                }
                else if (result == 0)
                {
                    [self loadAlertControllerWithTitle:@"注册失败！" massage:@"请检查网络后重试"];
                }
            }];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)loadSuccessAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册成功！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    return YES;
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
