//
//  MyResumePreviewDetailModel.h
//  ZLResume
//
//  Created by apple on 2018/9/12.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WorkExperienceModel.h"
#import "ResumeDetailInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface MyResumePreviewDetailModel : NSObject

@property (nonatomic, strong, nullable)ResumeDetailInfoModel *infoModel;
//先不写
@property (nonatomic, strong, nullable)NSMutableDictionary *DetailInfo;

@property (nonatomic, strong, nullable)NSMutableArray<WorkExperienceModel *> *lstExperience;

@property (nonatomic, strong, nullable)NSMutableArray<EducationExperienceModel *> *lstEducation;

@property (nonatomic, strong, nullable)NSMutableArray<TrainExperienceModel *> *lstTrain;

@property (nonatomic, strong, nullable)NSMutableArray<MyLanguageModel *> *lstJobLanguage;

@property (nonatomic, strong, nullable)NSMutableArray<CertificateExperienceModel *> *lstCertificate;



@end
NS_ASSUME_NONNULL_END
