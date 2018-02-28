//
//  PersonalTableViewCell.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/9.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "PersonalTableViewCell.h"

@implementation PersonalTableViewCell

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
        UILabel *arrowsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:arrowsLabel];
        [arrowsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@20);
            make.height.equalTo(@20);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.top.equalTo(self.contentView.mas_top).offset(15);
        }];
        arrowsLabel.text = @">";
        arrowsLabel.textColor = [UIColor grayColor];
        [arrowsLabel setFont:[UIFont systemFontOfSize:17]];

        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(arrowsLabel.mas_left).offset(-10);
            make.top.equalTo(self.contentView.mas_top).offset(15);
        }];
        [_titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    return self;
}

@end
