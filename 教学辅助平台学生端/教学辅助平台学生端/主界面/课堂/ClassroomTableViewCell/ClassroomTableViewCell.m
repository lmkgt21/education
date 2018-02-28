//
//  ClassroomTableViewCell.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/13.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "ClassroomTableViewCell.h"

@implementation ClassroomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backgroundView = [[UIView alloc] init];
        [self.contentView addSubview:backgroundView];
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@60);
            make.width.equalTo(@60);
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.top.equalTo(self.contentView.mas_top).offset(10);
        }];
        backgroundView.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
        backgroundView.layer.cornerRadius = 30;
        
        UILabel *label = [[UILabel alloc] init];
        [backgroundView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroundView.mas_left).offset(10);
            make.right.equalTo(backgroundView.mas_right).offset(-10);
            make.top.equalTo(backgroundView.mas_top).offset(20);
            make.height.equalTo(@20);
        }];
        label.font = [UIFont systemFontOfSize:17];
        label.text = @"课程";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];

        UIView *backgroundView2 = [[UIView alloc] init];
        [self.contentView addSubview:backgroundView2];
        [backgroundView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.left.equalTo(backgroundView.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.top.equalTo(self.contentView.mas_top).offset(15);
        }];
        backgroundView2.backgroundColor = [UIColor colorWithRed:128/256.0 green:176/256.0 blue:216/256.0 alpha:1];
        backgroundView2.layer.cornerRadius = 7;

        _courseNameLabel = [[UILabel alloc] init];
        [backgroundView2 addSubview:_courseNameLabel];
        [_courseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroundView2.mas_left).offset(10);
            make.right.equalTo(backgroundView2.mas_right).offset(-40);
            make.top.equalTo(backgroundView2.mas_top).offset(5);
            make.height.equalTo(@20);
        }];
        _courseNameLabel.font = [UIFont systemFontOfSize:17];
        _courseNameLabel.textColor = [UIColor whiteColor];
        
        _teacherNameLabel = [[UILabel alloc] init];
        [backgroundView2 addSubview:_teacherNameLabel];
        [_teacherNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroundView2.mas_left).offset(10);
            make.right.equalTo(backgroundView2.mas_right).offset(-40);
            make.top.equalTo(backgroundView2.mas_top).offset(30);
            make.height.equalTo(@17);
        }];
        _teacherNameLabel.font = [UIFont systemFontOfSize:15];
        _teacherNameLabel.textColor = [UIColor whiteColor];
        
        UIImageView *buttonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"叉"]];
        [backgroundView2 addSubview:buttonImageView];
        [buttonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@25);
            make.top.equalTo(backgroundView2.mas_top).offset(12.5);
            make.right.equalTo(backgroundView2.mas_right).offset(-10);
        }];
        buttonImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *buttonImageViewSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonImageViewSingleTapAction)];
        [buttonImageView addGestureRecognizer:buttonImageViewSingleTap];

    }
    return self;
}
-(void)buttonImageViewSingleTapAction
{
    [_delegate whenClassroomTableViewCellClickWith:self.indexPath];
}
@end
