//
//  DataTableViewCell.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/7.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
@interface DataTableViewCell : UITableViewCell

@property (nonatomic,retain) UIImageView *folderOrDocumentImageView;
@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UILabel *subheadLabel;
@property (nonatomic,retain) NSString *path;
@end

