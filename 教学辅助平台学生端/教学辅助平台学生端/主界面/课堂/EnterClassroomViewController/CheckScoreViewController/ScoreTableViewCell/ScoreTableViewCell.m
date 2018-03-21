//
//  ScoreTableViewCell.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/3/18.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "ScoreTableViewCell.h"
#import <Masonry.h>
@implementation ScoreTableViewCell

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
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.height.equalTo(@30);
            make.left.equalTo(self.contentView.mas_left).offset(20);
        }];
        [_titleLabel setFont:[UIFont systemFontOfSize:17]];
        
        _scoreLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_scoreLabel];
        [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.height.equalTo(@30);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.left.equalTo(_titleLabel.mas_right);
            make.width.equalTo(_titleLabel.mas_width);
        }];
        [_scoreLabel setFont:[UIFont systemFontOfSize:17]];
    }
    return self;
}
@end
