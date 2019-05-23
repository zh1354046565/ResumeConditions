//
//  MyResumePreviewUserInfoCell.m
//  ZLResume
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "MyResumePreviewUserInfoCell.h"
#pragma mark -- 目前用不上 先不写
@interface MyResumePreviewUserInfoCell()
@property (nonatomic, strong)UIImageView *headerImageV;


@property (nonatomic, strong)UIImageView *sexImageV;
@end
@implementation MyResumePreviewUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
