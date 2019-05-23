//
//  ResumePreviewDetailTypeView.h
//  ZLResume
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 DisposeState
 {# 0 未处理  1待沟通  2面试通知  3 不合适  4自动处理  5已过滤  6待录用  7录用  8黑名单  9已失效  20 暂存简历  21转发简历  22回收站简历 23 恢复简历 移出黑名单 #}
 */
typedef enum : NSUInteger {
    ResumeDetailTypeDefault=0,
    ResumeDetailTypeWaitCommunicate=1,
    ResumeDetailTypeWaitInterview=2,
    ResumeDetailTypeWaitEmployed=6,
    ResumeDetailTypeEmployed=7,
} ResumeDetailType;

@interface ResumePreviewDetailTypeView : UIView

- (instancetype)initWithFrame:(CGRect)frame type:(ResumeDetailType)type;
@property (nonatomic, copy)void(^ResumePreviewBlock)(NSInteger indextag);
@end















