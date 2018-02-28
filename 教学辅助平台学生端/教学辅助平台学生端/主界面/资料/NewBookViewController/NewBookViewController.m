//
//  NewBookViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/7.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "NewBookViewController.h"
#import "DataViewController.h"
@interface NewBookViewController ()

@end

@implementation NewBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:224/256.0 green:224/256.0 blue:224/256.0 alpha:1];
    [self loadNavigationControllerSetting];
    [self loadTextView];
    [self loadTransitionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadNavigationControllerSetting
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem *savelButton = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonAction)];
    self.navigationItem.rightBarButtonItem = savelButton;
}
-(void)cancelButtonAction
{
    //放弃第一响应者
    [_nameTextField resignFirstResponder];
    [_authorTextField resignFirstResponder];
    [_ISBNTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_linkTextField resignFirstResponder];
    [_introductionTextView resignFirstResponder];
    //弹出时由navigationController弹出，因此弹回 也由navigationController
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}
-(void)saveButtonAction
{
    //保存前先放弃第一响应者
    [_nameTextField resignFirstResponder];
    [_authorTextField resignFirstResponder];
    [_ISBNTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_linkTextField resignFirstResponder];
    [_introductionTextView resignFirstResponder];
    //先开始动画
    [_transitionView transitionStart];
    NSDictionary *bookInfoDic = @{@"作者":_authorTextField.text,@"ISBN":_ISBNTextField.text,@"简介":_introductionTextView.text,@"链接":_linkTextField.text,@"密码":_passwordTextField.text};
    UserManager *userManager = [UserManager sharedUserManager];
    [userManager newBookWithName:_nameTextField.text info:bookInfoDic path:self.dataViewController.path block:^(int result) {
        [_transitionView transitionStop];//先关闭动画
        if (result == 1) {
            //成功直，接退出
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [self.dataViewController editSuccess];
            }];
        }
        else if (result == 0)
        {
            //失败，弹出保存失败
            [_transitionView transitionStop];
            [self loadAlertControllerWithTitle:@"提交失败！" massage:@"请检查网络后重试"];
        }
    }];
}
-(void)loadTextView
{
    _nameTextField = [[UITextField alloc] init];
    [self.view addSubview:_nameTextField];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@40);
    }];
    _nameTextField.backgroundColor = [UIColor whiteColor];
    _nameTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _nameTextField.layer.borderWidth = 1;
    _nameTextField.font = [UIFont systemFontOfSize:20];
    _nameTextField.placeholder = @" 书名";
    
    _authorTextField = [[UITextField alloc] init];
    [self.view addSubview:_authorTextField];
    [_authorTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTextField.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@40);
    }];
    _authorTextField.backgroundColor = [UIColor whiteColor];
    _authorTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _authorTextField.layer.borderWidth = 1;
    _authorTextField.font = [UIFont systemFontOfSize:20];
    _authorTextField.placeholder = @" 作者";

    _ISBNTextField = [[UITextField alloc] init];
    [self.view addSubview:_ISBNTextField];
    [_ISBNTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_authorTextField.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@40);
    }];
    _ISBNTextField.backgroundColor = [UIColor whiteColor];
    _ISBNTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _ISBNTextField.layer.borderWidth = 1;
    _ISBNTextField.font = [UIFont systemFontOfSize:20];
    _ISBNTextField.placeholder = @" ISBN";

    _passwordTextField = [[UITextField alloc] init];
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@40);
    }];
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _passwordTextField.layer.borderWidth = 1;
    _passwordTextField.font = [UIFont systemFontOfSize:20];
    _passwordTextField.placeholder = @" 密码";

    _linkTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 0)];
    [self.view addSubview:_linkTextField];
    [_linkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_passwordTextField.mas_top).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@40);
    }];
    _linkTextField.backgroundColor = [UIColor whiteColor];
    _linkTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _linkTextField.layer.borderWidth = 1;
    _linkTextField.font = [UIFont systemFontOfSize:20];
    _linkTextField.placeholder = @" 链接";
    
    UILabel *introductionLabel = [[UILabel alloc] init];
    [self.view addSubview:introductionLabel];
    [introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ISBNTextField.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@20);
    }];
    introductionLabel.text = @"内容简介：";
    introductionLabel.font = [UIFont systemFontOfSize:17];
    introductionLabel.textColor = [UIColor darkGrayColor];

    _introductionTextView = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 200, 0)];
    [self.view addSubview:_introductionTextView];
    [_introductionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introductionLabel.mas_bottom).offset(10);
        make.bottom.equalTo(_linkTextField.mas_top).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    _introductionTextView.backgroundColor = [UIColor whiteColor];
    _introductionTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _introductionTextView.layer.borderWidth = 1;
    _introductionTextView.font = [UIFont systemFontOfSize:20];

}
-(void)loadTransitionView
{
    _transitionView = [[TransitionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) backgroundCorlor:[UIColor clearColor] title:@"提交中…"];
    [self.view addSubview:_transitionView];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_nameTextField resignFirstResponder];
    [_authorTextField resignFirstResponder];
    [_ISBNTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_linkTextField resignFirstResponder];
    [_introductionTextView resignFirstResponder];
}
-(void)viewDidAppear:(BOOL)animate
{
    [super viewDidAppear:animate];
    [_nameTextField becomeFirstResponder];
}

-(void)loadAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

@end
