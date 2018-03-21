//
//  ChoiceQuestionViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/3/18.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "ChoiceQuestionViewController.h"
#import "UserManager.h"
@interface ChoiceQuestionViewController ()

@end

@implementation ChoiceQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadScrollView];
    [self loadNoNetWorkingView];
    [self loadTransitionView];
    if (_questionsArray == nil) {
        [self downLoadData];
    }
    else
    {
        [self ChoiceQuestionReload];
    }
    [self circleImageViewSingleTapAction];//默认选A
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)downLoadData
{
    [_transitionView transitionStart];
    UserManager *userManager = [UserManager sharedUserManager];
    [userManager getQuestionsOfCourse:self.course WithType:@"choice" block:^(int result, NSArray *array) {
        [_transitionView transitionStop];
        if (result == 1) {
            //下载成功
            self.questionsArray = array;
            [self ChoiceQuestionReload];
        }
        else
        {
            //下载失败，显示无网络界面
            [_noNetWorkingView NoNetWorkingViewAppear];
        }
    }];
}
-(void)loadNoNetWorkingView
{
    _noNetWorkingView = [[NoNetWorkingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:_noNetWorkingView];
    _noNetWorkingView.delegate = self;
}
-(void)byClick
{
    [self downLoadData];
}
-(void)loadTransitionView
{
    _transitionView = [[TransitionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) backgroundCorlor:[UIColor whiteColor] title:@"加载中…"];
    [self.view addSubview:_transitionView];
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
-(void)loadNavigationControllerSetting
{
    UIBarButtonItem *savelButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishButtonAction)];
    self.navigationItem.rightBarButtonItem = savelButton;
}
-(void)finishButtonAction
{
    double totalScore = self.score;
    if ([_answer isEqualToString:[_questionsArray[_count] objectForKey:@"answer"]]) {
        totalScore += [[_questionsArray[_count] objectForKey:@"score"] doubleValue];
    }
    UserManager *userManager = [UserManager sharedUserManager];
    [userManager submitChoiceScore:totalScore toCourse:self.course block:^(int result) {
        if (result == 1) {
            //提交成功
            [self loadSuccessAlertControllerWithTitle:@"提交成功！" massage:[NSString stringWithFormat:@"您的分数为：%f",totalScore]];
        }
        else
        {
            [self loadAlertControllerWithTitle:@"提交失败！" massage:@"请检查网络后重试"];
        }
    }];
}
-(void)loadOtherViews
{
    _questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, _scrollView.frame.size.width-20-20, 30)];
    [_scrollView addSubview:_questionLabel];
    [_questionLabel setFont:[UIFont systemFontOfSize:20]];
    
    _choiceALabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, _scrollView.frame.size.width-55-20, 30)];
    [_scrollView addSubview:_choiceALabel];
    [_choiceALabel setFont:[UIFont systemFontOfSize:20]];


    _choiceBLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, _scrollView.frame.size.width-55-20, 30)];
    [_scrollView addSubview:_choiceBLabel];
    [_choiceBLabel setFont:[UIFont systemFontOfSize:20]];

    _choiceCLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, _scrollView.frame.size.width-55-20, 30)];
    [_scrollView addSubview:_choiceCLabel];
    [_choiceCLabel setFont:[UIFont systemFontOfSize:20]];

    _choiceDLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, _scrollView.frame.size.width-55-20, 30)];
    [_scrollView addSubview:_choiceDLabel];
    [_choiceDLabel setFont:[UIFont systemFontOfSize:20]];
    
    _circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"方形_未选中"] highlightedImage:[UIImage imageNamed:@"方形_选中"]];
    [_scrollView addSubview:_circleImageView];
    _circleImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *circleImageViewSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleImageViewSingleTapAction)];
    [_circleImageView addGestureRecognizer:circleImageViewSingleTap];
    
    _circleImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"方形_未选中"] highlightedImage:[UIImage imageNamed:@"方形_选中"]];
    [_scrollView addSubview:_circleImageView2];
    _circleImageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *circleImageViewSingleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleImageViewSingleTapAction2)];
    [_circleImageView2 addGestureRecognizer:circleImageViewSingleTap2];
    
    _circleImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"方形_未选中"] highlightedImage:[UIImage imageNamed:@"方形_选中"]];
    [_scrollView addSubview:_circleImageView3];
    _circleImageView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *circleImageViewSingleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleImageViewSingleTapAction3)];
    [_circleImageView3 addGestureRecognizer:circleImageViewSingleTap3];
    
    _circleImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"方形_未选中"] highlightedImage:[UIImage imageNamed:@"方形_选中"]];
    [_scrollView addSubview:_circleImageView4];
    _circleImageView4.userInteractionEnabled = YES;
    UITapGestureRecognizer *circleImageViewSingleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleImageViewSingleTapAction4)];
    [_circleImageView4 addGestureRecognizer:circleImageViewSingleTap4];
    
    //上一题按钮
    _lastquestionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:_lastquestionButton];
    _lastquestionButton.frame = CGRectMake(25, self.view.frame.size.height-64-60, 90, 30);
    _lastquestionButton.backgroundColor = [UIColor whiteColor];
    [_lastquestionButton addTarget:self action:@selector(lastquestionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_lastquestionButton setTitle:@"上一题" forState:UIControlStateNormal];
    [_lastquestionButton setTitle:@"上一题" forState:UIControlStateHighlighted];
    _lastquestionButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_lastquestionButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_lastquestionButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    _lastquestionButton.layer.cornerRadius = 7;
    _lastquestionButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _lastquestionButton.layer.borderWidth = 1;
    
    //下一题按钮
    _nextquestionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:_nextquestionButton];
    _nextquestionButton.frame = CGRectMake(self.view.frame.size.width-25-90, self.view.frame.size.height-64-60, 90, 30);
    _nextquestionButton.backgroundColor = [UIColor whiteColor];
    [_nextquestionButton addTarget:self action:@selector(nextquestionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_nextquestionButton setTitle:@"下一题" forState:UIControlStateNormal];
    [_nextquestionButton setTitle:@"下一题" forState:UIControlStateHighlighted];
    _nextquestionButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_nextquestionButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_nextquestionButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    _nextquestionButton.layer.cornerRadius = 7;
    _nextquestionButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _nextquestionButton.layer.borderWidth = 1;
}
-(void)buttonReload
{
    if (_count == 0) {
        _lastquestionButton.hidden = YES;
    }
    else
    {
        _lastquestionButton.hidden = NO;
    }
    if (_count == _questionsArray.count - 1) {
        _nextquestionButton.hidden = YES;
    }
    else
    {
        _nextquestionButton.hidden = NO;
    }
}
-(void)ChoiceQuestionReload
{
    CGFloat totalY = 20;
    _questionLabel.frame = CGRectMake(20, totalY, _scrollView.frame.size.width-20-20, 20);
    _questionLabel.text = [NSString stringWithFormat:@"问题：%@（%@分）",[_questionsArray[_count] objectForKey:@"question"],[_questionsArray[_count] objectForKey:@"score"]];
    _questionLabel.numberOfLines = 0;
    [_questionLabel sizeToFit];
    
    totalY = totalY + _questionLabel.frame.size.height+20;
    _choiceALabel.frame = CGRectMake(55, totalY, _scrollView.frame.size.width-55-20, 20);
    _choiceALabel.text = [NSString stringWithFormat:@"A.%@",[_questionsArray[_count] objectForKey:@"choiceA"]];
    _choiceALabel.numberOfLines = 0;
    [_choiceALabel sizeToFit];
    _circleImageView.frame = CGRectMake(20, totalY, 25, 25);

    totalY = totalY + _choiceALabel.frame.size.height+20;
    _choiceBLabel.frame = CGRectMake(55, totalY, _scrollView.frame.size.width-55-20, 20);
    _choiceBLabel.text = [NSString stringWithFormat:@"B.%@",[_questionsArray[_count] objectForKey:@"choiceB"]];
    _choiceBLabel.numberOfLines = 0;
    [_choiceBLabel sizeToFit];
    _circleImageView2.frame = CGRectMake(20, totalY, 25, 25);

    totalY = totalY + _choiceBLabel.frame.size.height+20;
    _choiceCLabel.frame = CGRectMake(55, totalY, _scrollView.frame.size.width-55-20, 20);
    _choiceCLabel.text = [NSString stringWithFormat:@"C.%@",[_questionsArray[_count] objectForKey:@"choiceC"]];
    _choiceCLabel.numberOfLines = 0;
    [_choiceCLabel sizeToFit];
    _circleImageView3.frame = CGRectMake(20, totalY, 25, 25);

    totalY = totalY + _choiceCLabel.frame.size.height+20;
    _choiceDLabel.frame = CGRectMake(55, totalY, _scrollView.frame.size.width-55-20, 20);
    _choiceDLabel.text = [NSString stringWithFormat:@"D.%@",[_questionsArray[_count] objectForKey:@"choiceD"]];
    _choiceDLabel.numberOfLines = 0;
    [_choiceDLabel sizeToFit];
    _circleImageView4.frame = CGRectMake(20, totalY, 25, 25);
    
    [self buttonReload];
    [self loadNavigationControllerSetting];
}
-(void)circleImageViewSingleTapAction
{
    _circleImageView.highlighted = YES;
    _circleImageView2.highlighted = NO;
    _circleImageView3.highlighted = NO;
    _circleImageView4.highlighted = NO;
    _answer = @"A";
}
-(void)circleImageViewSingleTapAction2
{
    _circleImageView.highlighted = NO;
    _circleImageView2.highlighted = YES;
    _circleImageView3.highlighted = NO;
    _circleImageView4.highlighted = NO;
    _answer = @"B";
}
-(void)circleImageViewSingleTapAction3
{
    _circleImageView.highlighted = NO;
    _circleImageView2.highlighted = NO;
    _circleImageView3.highlighted = YES;
    _circleImageView4.highlighted = NO;
    _answer = @"C";
}
-(void)circleImageViewSingleTapAction4
{
    _circleImageView.highlighted = NO;
    _circleImageView2.highlighted = NO;
    _circleImageView3.highlighted = NO;
    _circleImageView4.highlighted = YES;
    _answer = @"D";
}
-(void)lastquestionButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)nextquestionButtonAction
{
    ChoiceQuestionViewController *choiceQuestionViewController = [[ChoiceQuestionViewController alloc] init];
    choiceQuestionViewController.hidesBottomBarWhenPushed = YES;
    choiceQuestionViewController.questionsArray = self.questionsArray;
    choiceQuestionViewController.course = self.course;
    choiceQuestionViewController.currentWorkViewController = self.currentWorkViewController;
    if ([_answer isEqualToString:[_questionsArray[_count] objectForKey:@"answer"]]) {
        choiceQuestionViewController.score = self.score + [[_questionsArray[_count] objectForKey:@"score"] doubleValue];
    }
    else
    {
        choiceQuestionViewController.score = self.score;
    }
    choiceQuestionViewController.count = _count+1;
    choiceQuestionViewController.title = [NSString stringWithFormat:@"选择题%d",choiceQuestionViewController.count+1];
    [self.navigationController pushViewController:choiceQuestionViewController animated:YES];

}

-(void)loadAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
-(void)loadSuccessAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToViewController:self.currentWorkViewController animated:YES];
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
@end
