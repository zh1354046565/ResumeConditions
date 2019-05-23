//
//  MyResumePreviewDetailModel.m
//  ZLResume
//
//  Created by apple on 2018/9/12.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "MyResumePreviewDetailModel.h"

@implementation MyResumePreviewDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setDetailInfo:(NSMutableDictionary *)DetailInfo {
    if (_DetailInfo != DetailInfo) {
        _DetailInfo = DetailInfo;
    }
    self.infoModel = [[ResumeDetailInfoModel alloc]init];
    [self.infoModel setValuesForKeysWithDictionary:DetailInfo];
}

- (void)setLstExperience:(NSMutableArray<WorkExperienceModel *> *)lstExperience {
    if (_lstExperience != lstExperience) {
        _lstExperience = lstExperience;
    }
    NSMutableArray *tempArr = @[].mutableCopy;
    for (NSDictionary *dic in _lstExperience) {
        WorkExperienceModel *model = [[WorkExperienceModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [tempArr addObject:model];
    }
    _lstExperience = [NSMutableArray arrayWithArray:tempArr];
}

- (void)setLstEducation:(NSMutableArray<EducationExperienceModel *> *)lstEducation {
    if (_lstEducation != lstEducation) {
        _lstEducation = lstEducation;
    }
    NSMutableArray *tempArr = @[].mutableCopy;
    for (NSDictionary *dic in _lstEducation) {
        EducationExperienceModel *model = [[EducationExperienceModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [tempArr addObject:model];
    }
    _lstEducation = [NSMutableArray arrayWithArray:tempArr];
}

- (void)setLstTrain:(NSMutableArray<TrainExperienceModel *> *)lstTrain {
    if (_lstTrain != lstTrain) {
        _lstTrain = lstTrain;
    }
    NSMutableArray *tempArr = @[].mutableCopy;
    for (NSDictionary *dic in _lstTrain) {
        TrainExperienceModel *model = [[TrainExperienceModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [tempArr addObject:model];
    }
    _lstTrain = [NSMutableArray arrayWithArray:tempArr];
}

- (void)setLstJobLanguage:(NSMutableArray<MyLanguageModel *> *)lstJobLanguage {
    if (_lstJobLanguage != lstJobLanguage) {
        _lstJobLanguage = lstJobLanguage;
    }
    NSMutableArray *tempArr = @[].mutableCopy;
    for (NSDictionary *dic in _lstJobLanguage) {
        MyLanguageModel *model = [[MyLanguageModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [tempArr addObject:model];
    }
    _lstJobLanguage = [NSMutableArray arrayWithArray:tempArr];
}

- (void)setLstCertificate:(NSMutableArray<CertificateExperienceModel *> *)lstCertificate {
    if (_lstCertificate != lstCertificate) {
        _lstCertificate = lstCertificate;
    }
    NSMutableArray *tempArr = @[].mutableCopy;
    for (NSDictionary *dic in _lstCertificate) {
        CertificateExperienceModel *model = [[CertificateExperienceModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [tempArr addObject:model];
    }
    _lstCertificate = [NSMutableArray arrayWithArray:tempArr];
}


@end
