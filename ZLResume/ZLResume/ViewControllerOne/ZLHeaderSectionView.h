//
//  ZLHeaderSectionView.h
//  ZLResume
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const MyResumePreviewTableHeaderViewIdentifier;
UIKIT_EXTERN CGFloat const MyResumePreviewTableHeaderViewHeight;
@class MyResumePreviewSectionsModel;
@interface ZLHeaderSectionView : UITableViewHeaderFooterView


+ (nullable __kindof UIView *)conifgMyResumePreviewTableHeaderViewWithSectionsModel:(MyResumePreviewSectionsModel *)sectionsModel forTableView:(UITableView *)tableView;

@end
NS_ASSUME_NONNULL_END
