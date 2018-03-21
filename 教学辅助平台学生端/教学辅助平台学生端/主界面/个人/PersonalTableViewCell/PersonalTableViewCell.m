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
        _arrowsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_arrowsLabel];
        [_arrowsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.left.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(15);
        }];
        _arrowsLabel.text = @">";
        _arrowsLabel.textColor = [UIColor grayColor];
        [_arrowsLabel setFont:[UIFont systemFontOfSize:17]];
        _arrowsLabel.textAlignment = NSTextAlignmentRight;

        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(15);
        }];
        [_titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    return self;
}

@end
