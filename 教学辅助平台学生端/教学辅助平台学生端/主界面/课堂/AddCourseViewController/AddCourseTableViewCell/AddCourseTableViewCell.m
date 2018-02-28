//
//  AddCourseTableViewCell.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/11.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "AddCourseTableViewCell.h"

@implementation AddCourseTableViewCell

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
        _courseNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_courseNameLabel];
        [_courseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.top.equalTo(self.contentView.mas_top).offset(7.5);
            make.height.equalTo(@20);
        }];
        _courseNameLabel.font = [UIFont systemFontOfSize:17];
        
        _teacherNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_teacherNameLabel];
        [_teacherNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.top.equalTo(self.contentView.mas_top).offset(32.5);
            make.height.equalTo(@15);
        }];
        _teacherNameLabel.font = [UIFont systemFontOfSize:13];
        _teacherNameLabel.textColor = [UIColor darkGrayColor];
    }
    return self;
}

@end
