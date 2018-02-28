//
//  DataTableViewCell.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/7.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "DataTableViewCell.h"

@implementation DataTableViewCell

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
        _folderOrDocumentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 10, 40, 40)];
        [self.contentView addSubview:_folderOrDocumentImageView];
        
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(_folderOrDocumentImageView.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.top.equalTo(self.contentView.mas_top).offset(20);
        }];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        
        _subheadLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_subheadLabel];
        [_subheadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.top.equalTo(self.contentView.mas_top).offset(42.5);
            make.height.equalTo(@15);
            make.left.equalTo(_folderOrDocumentImageView.mas_right).offset(10);
        }];
        _subheadLabel.font = [UIFont systemFontOfSize:13];
        _subheadLabel.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

@end

