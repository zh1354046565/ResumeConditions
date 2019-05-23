//
//  MyResumePreviewItemModel.h
//  ZLResume
//
//  Created by apple on 2018/9/12.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface MyResumePreviewItemModel : NSObject

/**
 标题-黑色加粗
 */
@property (nonatomic, copy) NSString *title;

/**
 一些图片链接 - 证书、头像等
 */
@property (nonatomic, copy) NSString *iconUrls;

/**
 紧挨着标题-副标题
 */
@property (nonatomic, copy, nullable) NSString *subtitle;

/**
 详细的文本描述
 */
@property (nonatomic, copy, nullable) NSString *detailText;

/**
 性别等信息 0 女 1男
 */
@property (nonatomic, assign) NSInteger userSex;


@end
NS_ASSUME_NONNULL_END
