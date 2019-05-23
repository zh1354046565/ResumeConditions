//
//  MyResumePreviewLanguageItem.h
//  ZLResume
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const MyResumePreviewLanguageItemHeight;

UIKIT_EXTERN NSString *const MyResumePreviewLanguageItemIdentifier;

@class MyResumePreviewItemModel;

@interface MyResumePreviewLanguageItem : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *languageTextLable;


@property (weak, nonatomic) IBOutlet UILabel *controlTextLable;

@property (nonatomic, strong, readonly)MyResumePreviewItemModel *itemModel;
// 配置显示数据
- (void)configLanguageItemWithModel:(MyResumePreviewItemModel *)itemModel;

@end
