//
//  MyResumePreviewLanguageItem.m
//  ZLResume
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "MyResumePreviewLanguageItem.h"
#import "MyResumePreviewItemModel.h"

NSString *const MyResumePreviewLanguageItemIdentifier = @"MyResumePreviewLanguageItemIdentifier";

CGFloat const MyResumePreviewLanguageItemHeight = 62.f;

@implementation MyResumePreviewLanguageItem

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.layer.cornerRadius = 4.0f;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderWidth = 1.f;
    self.contentView.layer.borderColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0].CGColor;
}

- (void)configLanguageItemWithModel:(MyResumePreviewItemModel *)itemModel {
    _itemModel = itemModel;
    self.languageTextLable.text = itemModel.title;
    self.controlTextLable.text = itemModel.detailText;
}
@end
