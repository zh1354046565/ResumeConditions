//
//  MyResumePreviewSectionsModel.h
//  ZLResume
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MyResumePreviewDetailModel.h"
#import "WorkExperienceModel.h"
#import "ResumeDetailInfoModel.h"
#import "MyResumePreviewItemModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NSString* MyResumePreviewCellIdentifier NS_STRING_ENUM;

FOUNDATION_EXPORT MyResumePreviewCellIdentifier const MyResumePreviewUserInfoCellIdentifier;
FOUNDATION_EXPORT MyResumePreviewCellIdentifier const MyResumePreviewJustTextCellIdentifier;
FOUNDATION_EXPORT MyResumePreviewCellIdentifier const MyResumePreviewHasTitleCellIdentifier;
FOUNDATION_EXPORT MyResumePreviewCellIdentifier const MyResumePreviewLanguagesCellIdentifier;

@class MyResumePreviewItemModel;
@interface MyResumePreviewSectionsModel : NSObject

@property (nonatomic, assign) BOOL shouldHorizontalDisplay;

/**
 cell的样式标识
 */
@property (nonatomic, copy, readonly) MyResumePreviewCellIdentifier  cellIdentifier;
/**
 cell的名称
 */
@property (nonatomic, copy, readonly) NSString *cellName;
/**
 组的标题
 */
@property (nonatomic, copy, nullable)NSString *title;


@property (nonatomic, strong, nullable)NSArray <MyResumePreviewItemModel *>*previewItems;

+ (NSArray <MyResumePreviewSectionsModel *>*)myResumePreviewSectionsModelCovertFromModel:(MyResumePreviewDetailModel *)detailModel;

@end
NS_ASSUME_NONNULL_END
