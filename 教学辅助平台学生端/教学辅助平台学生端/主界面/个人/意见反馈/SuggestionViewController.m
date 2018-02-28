//
//  SuggestionViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/2.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "SuggestionViewController.h"

@interface SuggestionViewController ()

@end

@implementation SuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadScrollView];
    [self buttonImageViewSingleTapAction];//默认反馈类型为功能异常
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:_scrollView];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, (self.view.frame.size.height-64)*1.5);
    _scrollView.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    [self loadOtherViews];
}
-(void)loadOtherViews
{
    UILabel *suggestionLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 20, self.view.frame.size.width-50, 20)];
    [_scrollView addSubview:suggestionLabel];
    suggestionLabel.text = @"反馈类型";
    [suggestionLabel setFont:[UIFont systemFontOfSize:16]];
    suggestionLabel.textColor = [UIColor darkGrayColor];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 120)];
    [_scrollView addSubview:backgroundImageView];
    backgroundImageView.backgroundColor = [UIColor whiteColor];
    backgroundImageView.userInteractionEnabled = YES;
    //线
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, backgroundImageView.frame.size.width, 1)];
    [backgroundImageView addSubview:line];
    line.backgroundColor = [UIColor colorWithRed:192/256.0 green:192/256.0 blue:192/256.0 alpha:1];
    //线2
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, backgroundImageView.frame.size.width, 1)];
    [backgroundImageView addSubview:line2];
    line2.backgroundColor = [UIColor colorWithRed:192/256.0 green:192/256.0 blue:192/256.0 alpha:1];
    //按钮1
    UIImageView *buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 0, self.view.frame.size.width-50, 40)];
    [backgroundImageView addSubview:buttonImageView];
    buttonImageView.backgroundColor = [UIColor whiteColor];
    buttonImageView.userInteractionEnabled = YES;
    _circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆形_未选中"] highlightedImage:[UIImage imageNamed:@"圆形_选中"]];
    [buttonImageView addSubview:_circleImageView];
    _circleImageView.userInteractionEnabled = YES;
    _circleImageView.frame = CGRectMake(0, 10, 20, 20);
    UILabel *functionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, buttonImageView.frame.size.width-40, 20)];
    [buttonImageView addSubview:functionLabel];
    functionLabel.text = @"功能异常：故障或不可用";
    [functionLabel setFont:[UIFont systemFontOfSize:17]];
    UITapGestureRecognizer *buttonImageViewSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonImageViewSingleTapAction)];
    [buttonImageView addGestureRecognizer:buttonImageViewSingleTap];
    //按钮2
    UIImageView *buttonImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 41, self.view.frame.size.width-50, 39)];
    [backgroundImageView addSubview:buttonImageView2];
    buttonImageView2.backgroundColor = [UIColor whiteColor];
    buttonImageView2.userInteractionEnabled = YES;
    _circleImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆形_未选中"] highlightedImage:[UIImage imageNamed:@"圆形_选中"]];
    [buttonImageView2 addSubview:_circleImageView2];
    _circleImageView2.userInteractionEnabled = YES;
    _circleImageView2.frame = CGRectMake(0, 10, 20, 20);
    UILabel *productionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, buttonImageView.frame.size.width-40, 20)];
    [buttonImageView2 addSubview:productionLabel];
    productionLabel.text = @"产品建议：我有更好的建议";
    [productionLabel setFont:[UIFont systemFontOfSize:17]];
    UITapGestureRecognizer *buttonImageViewSingleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonImageViewSingleTapAction2)];
    [buttonImageView2 addGestureRecognizer:buttonImageViewSingleTap2];
    //按钮3
    UIImageView *buttonImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 81, self.view.frame.size.width-50, 39)];
    [backgroundImageView addSubview:buttonImageView3];
    buttonImageView3.backgroundColor = [UIColor whiteColor];
    buttonImageView3.userInteractionEnabled = YES;
    _circleImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆形_未选中"] highlightedImage:[UIImage imageNamed:@"圆形_选中"]];
    [buttonImageView3 addSubview:_circleImageView3];
    _circleImageView3.userInteractionEnabled = YES;
    _circleImageView3.frame = CGRectMake(0, 10, 20, 20);
    UILabel *otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, buttonImageView.frame.size.width-40, 20)];
    [buttonImageView3 addSubview:otherLabel];
    otherLabel.text = @"其它问题";
    [otherLabel setFont:[UIFont systemFontOfSize:17]];
    UITapGestureRecognizer *buttonImageViewSingleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonImageViewSingleTapAction3)];
    [buttonImageView3 addGestureRecognizer:buttonImageViewSingleTap3];
    
    
    UILabel *detailDescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 180, self.view.frame.size.width-50, 20)];
    [_scrollView addSubview:detailDescribeLabel];
    detailDescribeLabel.text = @"详细描述";
    [detailDescribeLabel setFont:[UIFont systemFontOfSize:16]];
    detailDescribeLabel.textColor = [UIColor darkGrayColor];
    UIImageView *backgroundImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 210, self.view.frame.size.width, 120)];
    [_scrollView addSubview:backgroundImageView2];
    backgroundImageView2.backgroundColor = [UIColor whiteColor];
    backgroundImageView2.userInteractionEnabled = YES;
    //详细描述
    _detailDescribeTextView = [[UITextView alloc] initWithFrame:CGRectMake(25, 10, backgroundImageView2.frame.size.width-50, 100)];
    [backgroundImageView2 addSubview:_detailDescribeTextView];
    _detailDescribeTextView.backgroundColor = [UIColor whiteColor];
    _detailDescribeTextView.font = [UIFont systemFontOfSize:17];
    _detailDescribeTextView.delegate = self;
    _textViewPlacehoder = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backgroundImageView2.frame.size.width-50, 0)];
    [_detailDescribeTextView addSubview:_textViewPlacehoder];
    [_textViewPlacehoder setFont:[UIFont systemFontOfSize:17]];
    _textViewPlacehoder.textColor = [UIColor lightGrayColor];
    _textViewPlacehoder.text = @"请输入详细的问题或者建议...";
    _textViewPlacehoder.numberOfLines = 0;
    [_textViewPlacehoder sizeToFit];

    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 340, self.view.frame.size.width-50, 20)];
    [_scrollView addSubview:contactLabel];
    contactLabel.text = @"联系方式";
    [contactLabel setFont:[UIFont systemFontOfSize:16]];
    contactLabel.textColor = [UIColor darkGrayColor];
    UIImageView *backgroundImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 370, self.view.frame.size.width, 50)];
    [_scrollView addSubview:backgroundImageView3];
    backgroundImageView3.backgroundColor = [UIColor whiteColor];
    backgroundImageView3.userInteractionEnabled = YES;
    //联系方式
    _contactTextField = [[UITextField alloc] initWithFrame:CGRectMake(25, 15, backgroundImageView3.frame.size.width-50, 20)];
    [backgroundImageView3 addSubview:_contactTextField];
    _contactTextField.placeholder = @"手机/QQ/邮箱";
    [_contactTextField setFont:[UIFont systemFontOfSize:17]];
    _contactTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _contactTextField.delegate = self;
    [_contactTextField addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    
    //提交按钮
    _submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_scrollView addSubview:_submitButton];
    _submitButton.frame = CGRectMake(25, 440, _scrollView.frame.size.width-50, 50);
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
    _transitionView = [[TransitionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) backgroundCorlor:[UIColor clearColor] title:@"提交中…"];
    [self.view addSubview:_transitionView];
    //处理单击，来放弃第一响应者
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
    [self.view addGestureRecognizer:singleTap];
}
-(void)submitButtonAction
{
    //先开启动画
    [_transitionView transitionStart];
    [_detailDescribeTextView resignFirstResponder];
    [_contactTextField resignFirstResponder];
    
    UserManager *userManager = [UserManager sharedUserManager];
    [userManager updateUserInfoFromBackgroundWithblock:^(int result) {
        if (result == 1) {
            //更新成功，开始保存
            [userManager saveSuggestionToBackgroundWith:[userManager.userInfo objectForKey:@"username"] type:_suggestionType description:_detailDescribeTextView.text contact:_contactTextField.text block:^(int result) {
                //先关闭动画
                [_transitionView transitionStop];
                if (result == 1) {
                    //保存成功
                    [self loadSuccessAlertController];
                }
                else
                {
                    //保存失败
                    [self loadAlertControllerWithTitle:@"提交失败！" massage:@"请检查网络后重试"];
                }
            }];
        }
        else
        {
            //更新失败
            [_transitionView transitionStop];
            [self loadAlertControllerWithTitle:@"提交失败！" massage:@"请检查网络后重试"];
        }
    }];
}
-(void)buttonImageViewSingleTapAction
{
    _circleImageView.highlighted = YES;
    _circleImageView2.highlighted = NO;
    _circleImageView3.highlighted = NO;
    _suggestionType = @"功能异常";
}
-(void)buttonImageViewSingleTapAction2
{
    _circleImageView.highlighted = NO;
    _circleImageView2.highlighted = YES;
    _circleImageView3.highlighted = NO;
    _suggestionType = @"产品建议";
}
-(void)buttonImageViewSingleTapAction3
{
    _circleImageView.highlighted = NO;
    _circleImageView2.highlighted = NO;
    _circleImageView3.highlighted = YES;
    _suggestionType = @"其它问题";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_contactTextField resignFirstResponder];
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_detailDescribeTextView resignFirstResponder];
    [_contactTextField resignFirstResponder];
}
-(void)singleTapAction
{
    //放弃第一响应者
    [_detailDescribeTextView resignFirstResponder];
    [_contactTextField resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (!_detailDescribeTextView.text.length) {
        _textViewPlacehoder.alpha = 1;
    }
    else
    {
        _textViewPlacehoder.alpha = 0;
    }
    [self valueChanged];
}
-(void)valueChanged
{
    //只有检测到同时有值时才让提交按钮实质显示并且可点击
    if (_detailDescribeTextView.text.length&&_contactTextField.text.length) {
        _submitButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:1];
        _submitButton.userInteractionEnabled = YES;
    }
    else
    {
        _submitButton.backgroundColor = [UIColor colorWithRed:30/256.0 green:130/256.0 blue:210/256.0 alpha:0.5];
        _submitButton.userInteractionEnabled = NO;
    }
}
-(void)loadSuccessAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交成功！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)loadAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
@end
