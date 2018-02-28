//
//  ClassroomTableViewCell.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/13.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@protocol ClassroomTableViewCellDelegate<NSObject>
-(void)whenClassroomTableViewCellClickWith:(NSIndexPath *)indexPath;
@end

@interface ClassroomTableViewCell : UITableViewCell
@property (nonatomic,retain) UILabel *courseNameLabel;
@property (nonatomic,retain) UILabel *teacherNameLabel;
@property (nonatomic,retain) id<ClassroomTableViewCellDelegate> delegate;
@property (nonatomic,retain) NSIndexPath *indexPath;

@end
