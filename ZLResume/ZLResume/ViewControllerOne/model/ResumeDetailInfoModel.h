//
//  ResumeDetailInfoModel.h
//  ZLResume
//
//  Created by apple on 2018/9/12.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResumeDetailInfoModel : NSObject

/**
 简历列表ID
 */
@property (nonatomic,assign) NSInteger OperaResumeID;

/**
 简历ID
 */
@property (nonatomic,assign) NSInteger ResumeID;
/**
 列表ID
 */
@property (nonatomic,assign) NSInteger ListType;

/**
 简历编号
 */
@property (nonatomic,copy) NSString *ResumeNumber;

/**
 更新日期
 */
@property (nonatomic,copy) NSString *DataUpdateDate;

/**
 简历状态
 */
@property (nonatomic,assign) NSInteger DisposeState;

/**
 简历状态
 */
@property (nonatomic,copy) NSString *ResumeState;

/**
 人才手机号
 */
@property (nonatomic,copy) NSString *UserPhone;

/**
 人才邮箱
 */
@property (nonatomic,copy) NSString *UserEmail;

/**
 投递或推荐职位
 */
@property (nonatomic,copy) NSString *JobName;

/**
 投递、推荐、处理时间
 */
@property (nonatomic,copy) NSString *OperationDate;

/**
 是否显示联系方式
 */
@property (nonatomic, assign) BOOL IsShow;

/**
 下载套餐余量
 */
@property (nonatomic,assign) NSInteger DownSurplus;

/**
 是否有投递记录
 */
@property (nonatomic, assign) BOOL IsDeliver;

/**
 人才姓名
 */
@property (nonatomic,copy) NSString *UserName;

/**
 人才性别
 */
@property (nonatomic,assign) NSInteger UserSex;

/**
 人才头像
 */
@property (nonatomic,copy) NSString *HeadImg;

/**
 是否验证邮箱
 */
@property (nonatomic, assign) BOOL IsCheckEmail;

/**
 是否验证电话
 */
@property (nonatomic, assign) BOOL IsCheckPhone;

/**
 学历
 */
@property (nonatomic,copy) NSString *JobEducation;

/**
 工作年限
 */
@property (nonatomic,copy) NSString *WorkYear;

/**
 年龄
 */
@property (nonatomic,assign) NSInteger DateBirth;

/**
 出生年份
 */
@property (nonatomic,copy) NSString *DateYear;

/**
 民族
 */
@property (nonatomic,copy) NSString *Nation;

/**
 政治面貌
 */
@property (nonatomic,copy) NSString *PoliticsStatus;

/**
 婚姻状况
 */
@property (nonatomic,copy) NSString *MarriageState;

/**
 现居地
 */
@property (nonatomic,copy) NSString *Address;

/**
 出生地
 */
@property (nonatomic,copy) NSString *HomePlace;

/**
 是否高级人才
 */
@property (nonatomic, assign) BOOL IsHighUser;

/**
 自我评价
 */
@property (nonatomic,copy) NSString *SelfAssessment;

/**
 期望从事行业
 */
@property (nonatomic,copy) NSString *BegPositionIndustry;

/**
 期望从事岗位
 */
@property (nonatomic,copy) NSString *BegPositionPost;

/**
 期望工作地区
 */
@property (nonatomic,copy) NSString *BegPositionCity;

/**
 当前期望工资
 */
@property (nonatomic,copy) NSString *BegPositionPay;

/**
 预计到岗时间
 */
@property (nonatomic,copy) NSString *HopeArriveDate;

/**
 目前求职状况
 */
@property (nonatomic,copy) NSString *BegPositionInPlaceDate;



/**
 技能特长
 */
@property (nonatomic,copy) NSString *SkillDescribe;

/**
 登记表地址
 */
@property (nonatomic,copy) NSString *AttachePath;

/**
 上一位排序
 */
@property (nonatomic,assign) NSInteger UpIrank;

/**
 上一位简历列表ID
 */
@property (nonatomic,assign) NSInteger UpOperaResumeID;

/**
 上一位简历编号
 */
@property (nonatomic,copy) NSString *UpResumeNumber;

/**
 下一位排序
 */
@property (nonatomic,assign) NSInteger NtIrank;

/**
 下一位简历列表ID
 */
@property (nonatomic,assign) NSInteger NtOperaResumeID;

/**
 下一位简历编号
 */
@property (nonatomic,copy) NSString *NtResumeNumber;

@end














