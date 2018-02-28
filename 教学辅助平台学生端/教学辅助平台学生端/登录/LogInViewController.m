//
//  LogInViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/29.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadOtherViews];
}
-(void)loadOtherViews
{
    //logo
    UIImageView *bigLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_big_circle"]];
    [self.view addSubview:bigLogoImageView];
    [bigLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@90);
        make.height.equalTo(@90);
        make.bottom.equalTo(self.view.mas_centerY).offset(-140);
    }];
    //线1
    UIImageView *line1 = [[UIImageView alloc] init];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(-70);
        make.height.equalTo(@1);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
    }];
    line1.backgroundColor = [UIColor colorWithRed:192/256.0 green:192/256.0 blue:192/256.0 alpha:1];
    //线2
    UIImageView *line2 = [[UIImageView alloc] init];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(-20);
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
    //登录按钮
    _logInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:_logInButton];
    [_logInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.height.equalTo(@50);
        make.top.equalTo(self.view.mas_centerY).offset(20);
    }];
    _logInButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:0.5];
    [_logInButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_logInButton setTitle:@"登录" forState:UIControlStateNormal];
    [_logInButton setTitle:@"登录" forState:UIControlStateHighlighted];
    _logInButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_logInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    _logInButton.layer.cornerRadius = 7;
    _logInButton.userInteractionEnabled = NO;
    //注册按钮
    _registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.height.equalTo(@50);
        make.top.equalTo(_logInButton.mas_bottom).offset(15);
    }];
    _registerButton.backgroundColor = [UIColor whiteColor];
    [_registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitle:@"注册" forState:UIControlStateHighlighted];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_registerButton setTitleColor:[UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1] forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1] forState:UIControlStateHighlighted];
    _registerButton.layer.cornerRadius = 7;
    _registerButton.layer.borderColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1].CGColor;
    _registerButton.layer.borderWidth = 1;
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
        _logInButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
        _logInButton.userInteractionEnabled = YES;
    }
    else
    {
        _logInButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:0.5];
        _logInButton.userInteractionEnabled = NO;
    }
}
-(void)loginButtonAction
{
    //放弃第一响应者
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    //开始动画
    [_transitionView transitionStart];
    UserManager *userManager = [UserManager sharedUserManager];
    [userManager logInUser:_usernameTextField.text with:_passwordTextField.text block:^(int result) {
        //先停止动画
        [_transitionView transitionStop];
        if (result == 1) {
            //登录成功
            [self dismissViewControllerAnimated:YES completion:^{}];
        }
        else if (result == -1)
        {
            //用户名不存在
            [self loadAlertControllerWithTitle:@"用户名不存在！" massage:@"请先进行注册"];
        }
        else if (result == -2)
        {
            //用户名或密码不正确
            [self loadAlertControllerWithTitle:@"用户名或密码不正确！" massage:@"请输入正确的用户名或者密码"];
        }
        else if (result == 0)
        {
            //登录失败
            [self loadAlertControllerWithTitle:@"登录失败！" massage:@"请检查网络"];
        }
    }];
}
-(void)registerButtonAction
{
    //放弃第一响应者
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    //弹出注册界面
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    registerViewController.title = @"注册";
    UINavigationController *registerNavigationController = [[UINavigationController alloc] initWithRootViewController:registerViewController];
    registerNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
    registerNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
    registerNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self presentViewController:registerNavigationController animated:YES completion:^{}];

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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _usernameTextField.text = nil;
    _passwordTextField.text = nil;
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
