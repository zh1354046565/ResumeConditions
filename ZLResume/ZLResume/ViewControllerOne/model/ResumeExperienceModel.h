//
//  ResumeExperienceModel.h
//  ZLResume
//
//  Created by apple on 2018/9/12.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BJXMyResumeDisplayType) {
    kBJXMyResumeDisplayTypeBaseInfo = 0, // 基本信息
    kBJXMyResumeDisplayTypeSelfAppraisal = 1, // 自我评价
    kBJXMyResumeDisplayTypeJobIntension = 2, // 工作意向
    kBJXMyResumeDisplayTypeWorkExperience = 3, // 工作经验
    kBJXMyResumeDisplayTypeEducation = 4, // 教育背景
    kBJXMyResumeDisplayTypeTrain = 5, // 培训经历
    kBJXMyResumeDisplayTypeLanguage = 6, // 语言能力
    kBJXMyResumeDisplayTypeCertificate = 7, // 所获证书
    kBJXMyResumeDisplayTypeCharacterTraits = 8, // 个人特长
};

@interface ResumeExperienceModel : NSObject

/**
 模型的展示形式 - 基本信息呀 教育背景 这个必须实例化的时候给予赋值，否则将出现刷新错误
 */
@property (nonatomic,assign) BJXMyResumeDisplayType resumeDisplayType;

@property (nonatomic, copy)NSString *sectionTitle;

@end
