//
//  BookDetailViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/8.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadScrollView];
}
-(void)loadScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:_scrollView];
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self loadOtherViews];
}
-(void)loadOtherViews
{
    CGFloat totalY = 20;
    UILabel *nameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, totalY, 75, 25)];
    [_scrollView addSubview:nameTitleLabel];
    nameTitleLabel.font = [UIFont systemFontOfSize:17];
    nameTitleLabel.text = @"书名：";
    totalY = totalY +nameTitleLabel.frame.size.height+10;
    
    _nameBackgroundView = [[UIView alloc] init];
    [_scrollView addSubview:_nameBackgroundView];
    _nameBackgroundView.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
    _nameBackgroundView.layer.cornerRadius = 7;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-50, 0)];
    [_nameBackgroundView addSubview:nameLabel];
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.text = self.bookName;
    nameLabel.numberOfLines = 0;
    [nameLabel sizeToFit];
    _nameBackgroundView.frame = CGRectMake(20, totalY, self.view.frame.size.width-40, nameLabel.frame.size.height+10);
    totalY = totalY+_nameBackgroundView.frame.size.height+10;
    
    UILabel *authorTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, totalY, 75, 25)];
    [_scrollView addSubview:authorTitleLabel];
    authorTitleLabel.font = [UIFont systemFontOfSize:17];
    authorTitleLabel.text = @"作者：";
    totalY = totalY +authorTitleLabel.frame.size.height+10;

    _authorBackgroundView = [[UIView alloc] init];
    [_scrollView addSubview:_authorBackgroundView];
    _authorBackgroundView.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
    _authorBackgroundView.layer.cornerRadius = 7;
    UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-50, 0)];
    [_authorBackgroundView addSubview:authorLabel];
    authorLabel.font = [UIFont systemFontOfSize:20];
    authorLabel.text = [self.bookInfo objectForKey:@"作者"];
    authorLabel.numberOfLines = 0;
    [authorLabel sizeToFit];
    _authorBackgroundView.frame = CGRectMake(20, totalY, self.view.frame.size.width-40, authorLabel.frame.size.height+10);
    totalY = totalY +_authorBackgroundView.frame.size.height+10;
    
    UILabel *ISBNTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, totalY, 75, 25)];
    [_scrollView addSubview:ISBNTitleLabel];
    ISBNTitleLabel.font = [UIFont systemFontOfSize:17];
    ISBNTitleLabel.text = @"ISBN：";
    totalY = totalY +ISBNTitleLabel.frame.size.height+10;

    _ISBNBackgroundView = [[UIView alloc] init];
    [_scrollView addSubview:_ISBNBackgroundView];
    _ISBNBackgroundView.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
    _ISBNBackgroundView.layer.cornerRadius = 7;
    UILabel *ISBNLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-50, 0)];
    [_ISBNBackgroundView addSubview:ISBNLabel];
    ISBNLabel.font = [UIFont systemFontOfSize:20];
    ISBNLabel.text = [self.bookInfo objectForKey:@"ISBN"];
    ISBNLabel.numberOfLines = 0;
    [ISBNLabel sizeToFit];
    _ISBNBackgroundView.frame = CGRectMake(20, totalY, self.view.frame.size.width-40, ISBNLabel.frame.size.height+10);
    totalY = totalY +_ISBNBackgroundView.frame.size.height+10;
    
    UILabel *introductionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, totalY, 75, 25)];
    [_scrollView addSubview:introductionTitleLabel];
    introductionTitleLabel.font = [UIFont systemFontOfSize:17];
    introductionTitleLabel.text = @"简介：";
    totalY = totalY +introductionTitleLabel.frame.size.height+10;

    _introductionBackgroundView = [[UIView alloc] init];
    [_scrollView addSubview:_introductionBackgroundView];
    _introductionBackgroundView.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
    _introductionBackgroundView.layer.cornerRadius = 7;
    UILabel *introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-50, 0)];
    [_introductionBackgroundView addSubview:introductionLabel];
    introductionLabel.font = [UIFont systemFontOfSize:20];
    introductionLabel.text = [self.bookInfo objectForKey:@"简介"];
    introductionLabel.numberOfLines = 0;
    [introductionLabel sizeToFit];
    _introductionBackgroundView.frame = CGRectMake(20, totalY, self.view.frame.size.width-40, introductionLabel.frame.size.height+10);
    totalY = totalY +_introductionBackgroundView.frame.size.height+10;
    
    UILabel *linkTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, totalY, 75, 25)];
    [_scrollView addSubview:linkTitleLabel];
    linkTitleLabel.font = [UIFont systemFontOfSize:17];
    linkTitleLabel.text = @"链接：";
    UIButton *clickToCopyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_scrollView addSubview:clickToCopyButton];
    clickToCopyButton.frame = CGRectMake(25+75, totalY+2.5, 100, 25);
    clickToCopyButton.backgroundColor = [UIColor colorWithRed:224/256.0 green:224/256.0 blue:224/256.0 alpha:1];
    [clickToCopyButton addTarget:self action:@selector(clickToCopyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [clickToCopyButton setTitle:@"点击复制" forState:UIControlStateNormal];
    [clickToCopyButton setTitle:@"点击复制" forState:UIControlStateHighlighted];
    clickToCopyButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [clickToCopyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clickToCopyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    clickToCopyButton.layer.cornerRadius = 10;
    totalY = totalY +linkTitleLabel.frame.size.height+10;

    _linkBackgroundView = [[UIView alloc] init];
    [_scrollView addSubview:_linkBackgroundView];
    _linkBackgroundView.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
    _linkBackgroundView.layer.cornerRadius = 7;
    UILabel *linkLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-50, 0)];
    [_linkBackgroundView addSubview:linkLabel];
    linkLabel.font = [UIFont systemFontOfSize:20];
    linkLabel.text = [self.bookInfo objectForKey:@"链接"];
    linkLabel.numberOfLines = 0;
    [linkLabel sizeToFit];
    _linkBackgroundView.frame = CGRectMake(20, totalY, self.view.frame.size.width-40, linkLabel.frame.size.height+10);
    totalY = totalY +_linkBackgroundView.frame.size.height+10;

    UILabel *passwordTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, totalY, 75, 25)];
    [_scrollView addSubview:passwordTitleLabel];
    passwordTitleLabel.font = [UIFont systemFontOfSize:17];
    passwordTitleLabel.text = @"密码：";
    totalY = totalY +passwordTitleLabel.frame.size.height+10;

    _passwordBackgroundView = [[UIView alloc] init];
    [_scrollView addSubview:_passwordBackgroundView];
    _passwordBackgroundView.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
    _passwordBackgroundView.layer.cornerRadius = 7;
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-50, 0)];
    [_passwordBackgroundView addSubview:passwordLabel];
    passwordLabel.font = [UIFont systemFontOfSize:20];
    passwordLabel.text = [self.bookInfo objectForKey:@"密码"];
    passwordLabel.numberOfLines = 0;
    [passwordLabel sizeToFit];
    _passwordBackgroundView.frame = CGRectMake(20, totalY, self.view.frame.size.width-40, passwordLabel.frame.size.height+10);
    totalY = totalY +_passwordBackgroundView.frame.size.height+20;

    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, totalY);
}
-(void)clickToCopyButtonAction
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@",[self.bookInfo objectForKey:@"链接"]];
    [self loadAlertControllerWithTitle:@"复制成功！" massage:nil];
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
-(void)loadAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

@end
