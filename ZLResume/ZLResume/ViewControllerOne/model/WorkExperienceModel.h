//
//  WorkExperienceModel.h
//  ZLResume
//
//  Created by apple on 2018/9/12.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResumeExperienceModel.h"
#pragma mark - 工作经历
@interface WorkExperienceModel : ResumeExperienceModel
/**
 公司名称
 */
@property (nonatomic,copy) NSString *CompanyName;

/**
 开始时间,精确到年月
 */
@property (nonatomic,copy) NSString *StartDate;

/**
 结束时间，精确到年月
 */
@property (nonatomic,copy) NSString *EndDate;

/**
 职位
 */
@property (nonatomic,copy) NSString *JobName;

/**
 公司行业性质
 */
@property (nonatomic,copy) NSString *CompanyNature;


/**
 公司行业类型
 */
@property (nonatomic,copy) NSString *IndustryName;


/**
 公司规模对应枚举
 */
@property (nonatomic,copy) NSString *ScaleName;

/**
 所在部门
 */
@property (nonatomic,copy) NSString *DepartmentName;

/**
 薪资
 */
@property (nonatomic,assign) NSInteger WorkPay;

/**
 工作内容或者职责
 */
@property (nonatomic,copy) NSString *JobDetail;

@end
#pragma mark - 教育经历
@interface EducationExperienceModel : ResumeExperienceModel
/**
 开始时间
 */
@property (nonatomic,copy) NSString *StartDate;

/**
 结束时间
 */
@property (nonatomic,copy) NSString *EndDate;

/**
 教育大学
 */
@property (nonatomic,copy) NSString *SchoolName;

/**
 学历
 */
@property (nonatomic,copy) NSString *JobEducation;

/**
 专业
 */
@property (nonatomic,copy) NSString *MajorName;

/**
 专业描述
 */
@property (nonatomic,copy) NSString *MajorDescribe;

@end
#pragma mark - 培训经历
@interface TrainExperienceModel : ResumeExperienceModel
/**
 起始时间
 */
@property (nonatomic,copy) NSString *StartDate;
/**
 截止时间
 */
@property (nonatomic,copy) NSString *EndDate;
/**
 学校名称
 */
@property (nonatomic,copy) NSString *SchoolName;
/**
 培训主题
 */
@property (nonatomic,copy) NSString *TrainCourse;
/**
 培训地点
 */
@property (nonatomic,copy) NSString *TrainAddress;
/**
 所获证书
 */
@property (nonatomic,copy) NSString *GetCertificate;
/**
 培训内容
 */
@property (nonatomic,copy) NSString *TrainDescirbe;
@end
#pragma mark - 语言能力
@interface MyLanguageModel : ResumeExperienceModel
/**
 语言
 */
@property (nonatomic,copy) NSString *JobLanguage;
/**
 熟练度
 */
@property (nonatomic,copy) NSString *LanguageGrade;
@end
#pragma mark - 所获证书
@interface CertificateExperienceModel : ResumeExperienceModel
/**
 证书名称
 */
@property (nonatomic,copy) NSString *CertificateName;
/**
 证书年份
 */
@property (nonatomic,copy) NSString *sYear;
/**
 颁发单位
 */
@property (nonatomic,copy) NSString *IssueUnit;
/**
 证书地址
 */
@property (nonatomic,copy) NSString *ImgPath;

//缺一个证书描述
@end
