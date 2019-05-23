//
//  MyResumePreviewJustTextCell.m
//  ZLResume
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "MyResumePreviewJustTextCell.h"

@implementation MyResumePreviewJustTextCell

- (void)displayCellWithItemModel:(MyResumePreviewItemModel *)itemModel {
    [super displayCellWithItemModel:itemModel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
