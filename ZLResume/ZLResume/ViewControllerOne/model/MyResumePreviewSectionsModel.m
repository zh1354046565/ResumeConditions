//
//  MyResumePreviewSectionsModel.m
//  ZLResume
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "MyResumePreviewSectionsModel.h"

MyResumePreviewCellIdentifier const MyResumePreviewUserInfoCellIdentifier = @"MyResumePreviewUserInfoCellIdentifier";

MyResumePreviewCellIdentifier const MyResumePreviewJustTextCellIdentifier = @"MyResumePreviewJustTextCellIdentifier";

MyResumePreviewCellIdentifier const MyResumePreviewHasTitleCellIdentifier = @"MyResumePreviewHasTitleCellIdentifier";

MyResumePreviewCellIdentifier const MyResumePreviewLanguagesCellIdentifier = @"MyResumePreviewLanguagesCellIdentifier";

@interface MyResumePreviewSectionsModel()

@property (nonatomic, copy)MyResumePreviewCellIdentifier cellIdentifier;
@property (nonatomic, copy) NSString *cellName;
@end
@implementation MyResumePreviewSectionsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSArray <MyResumePreviewSectionsModel *>*)myResumePreviewSectionsModelCovertFromModel:(MyResumePreviewDetailModel *)detailModel {
    NSMutableArray *userInfoList = @[].mutableCopy;
    //头部(暂时不写)
//    if (detailModel.infoModel) {
//        MyResumePreviewSectionsModel *assumeModel = [MyResumePreviewSectionsModel new];
//        assumeModel.cellIdentifier = MyResumePreviewUserInfoCellIdentifier;
//        [userInfoList addObject:assumeModel];
//    }
    
    //自我评价
    if (detailModel.infoModel.SelfAssessment.length) {
        MyResumePreviewSectionsModel *assumeModel = [MyResumePreviewSectionsModel new];
        assumeModel.cellIdentifier = MyResumePreviewJustTextCellIdentifier;
        assumeModel.title = @"自我评价";
        [userInfoList addObject:assumeModel];
        
        MyResumePreviewItemModel *itemModel = [MyResumePreviewItemModel new];
        
        itemModel.detailText = detailModel.infoModel.SelfAssessment;
        assumeModel.previewItems = [NSArray arrayWithObject:itemModel];
    }
    //求职意向
    if (detailModel.infoModel) {
        MyResumePreviewSectionsModel *assumeModel = [MyResumePreviewSectionsModel new];
        assumeModel.cellIdentifier = MyResumePreviewJustTextCellIdentifier;
        assumeModel.title = @"求职意向";
        [userInfoList addObject:assumeModel];
        
        assumeModel.previewItems = [NSArray arrayWithObject:[self covertJobIntentionWithModel:detailModel.infoModel]];
        
    }
    
    //工作经历
    if (detailModel.lstExperience > 0) {
        MyResumePreviewSectionsModel *assumeModel = [MyResumePreviewSectionsModel new];
        assumeModel.cellIdentifier = MyResumePreviewHasTitleCellIdentifier;
        assumeModel.title = @"工作经历";
        [userInfoList addObject:assumeModel];
        NSMutableArray *mutableArr = @[].mutableCopy;
        [detailModel.lstExperience enumerateObjectsUsingBlock:^(WorkExperienceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MyResumePreviewItemModel *itemModel = [MyResumePreviewItemModel new];
            itemModel.title = obj.CompanyName;
            itemModel.subtitle = [NSString stringWithFormat:@"%@ - %@  %@",obj.StartDate,obj.EndDate,obj.JobName];
            itemModel.detailText = obj.JobDetail;
            [mutableArr addObject:itemModel];
        }];
        assumeModel.previewItems = [NSArray arrayWithArray:mutableArr];
    }
    //教育经历
    if (detailModel.lstEducation.count > 0) {
        MyResumePreviewSectionsModel *assumeModel =  [[MyResumePreviewSectionsModel alloc] init];
        assumeModel.cellIdentifier = MyResumePreviewHasTitleCellIdentifier;
        assumeModel.title = @"教育经历";
        [userInfoList addObject:assumeModel];
        
        NSMutableArray *mutableArr = [NSMutableArray array];
        [detailModel.lstEducation enumerateObjectsUsingBlock:^(EducationExperienceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            MyResumePreviewItemModel *itemModel = [MyResumePreviewItemModel new];
            itemModel.title = obj.SchoolName;
            itemModel.subtitle = [NSString stringWithFormat:@"%@ - %@  %@  %@",obj.StartDate,obj.EndDate,obj.MajorName,obj.JobEducation];
            itemModel.detailText = obj.MajorDescribe;
            [mutableArr addObject:itemModel];
        }];
        assumeModel.previewItems = [NSArray arrayWithArray:mutableArr];
    }
    //培训经历
    if (detailModel.lstTrain.count > 0) {
        MyResumePreviewSectionsModel *assumeModel =  [[MyResumePreviewSectionsModel alloc] init];
        assumeModel.cellIdentifier = MyResumePreviewHasTitleCellIdentifier;
        assumeModel.title = @"培训经历";
        [userInfoList addObject:assumeModel];
        
        NSMutableArray *mutableArr = [NSMutableArray array];
        [detailModel.lstTrain enumerateObjectsUsingBlock:^(TrainExperienceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            MyResumePreviewItemModel *itemModel = [MyResumePreviewItemModel new];
            itemModel.title = obj.SchoolName;
            itemModel.subtitle = [NSString stringWithFormat:@"%@%@%@%@",obj.StartDate,obj.TrainCourse,obj.TrainAddress,obj.GetCertificate];
            itemModel.detailText = obj.TrainDescirbe;
            [mutableArr addObject:itemModel];
        }];
        assumeModel.previewItems = [NSArray arrayWithArray:mutableArr];
    }
    //语言能力
    if (detailModel.lstJobLanguage.count > 0) {
        MyResumePreviewSectionsModel *assumeModel =  [[MyResumePreviewSectionsModel alloc] init];
        assumeModel.shouldHorizontalDisplay = YES;
        assumeModel.cellIdentifier = MyResumePreviewLanguagesCellIdentifier;
        assumeModel.title = @"语言能力";
        [userInfoList addObject:assumeModel];

        NSMutableArray *mutableArr = [NSMutableArray array];
        [detailModel.lstJobLanguage enumerateObjectsUsingBlock:^(MyLanguageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MyResumePreviewItemModel *itemModel = [MyResumePreviewItemModel new];
            itemModel.title = obj.JobLanguage;
            itemModel.detailText = [NSString stringWithFormat:@"掌握程度: %@",obj.LanguageGrade];
            [mutableArr addObject:itemModel];
        }];
        assumeModel.previewItems = [NSArray arrayWithArray:mutableArr];
    }
    //所获证书
    if (detailModel.lstCertificate.count > 0) {
        MyResumePreviewSectionsModel *assumeModel = [MyResumePreviewSectionsModel new];
        assumeModel.cellIdentifier = MyResumePreviewHasTitleCellIdentifier;
        assumeModel.title = @"所获证书";
        [userInfoList addObject:assumeModel];
        NSMutableArray *mutableArr = @[].mutableCopy;
        [detailModel.lstCertificate enumerateObjectsUsingBlock:^(CertificateExperienceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            MyResumePreviewItemModel *itemModel = [MyResumePreviewItemModel new];
            itemModel.title = obj.CertificateName;
            itemModel.subtitle = [NSString stringWithFormat:@"%@  %@",obj.sYear,obj.IssueUnit];
            itemModel.detailText = obj.ImgPath;
            [mutableArr addObject:itemModel];
        }];
        assumeModel.previewItems  = [NSArray arrayWithArray:mutableArr];
    }
    
    //技能特长
    if (detailModel.infoModel.SkillDescribe.length > 0) {
        MyResumePreviewSectionsModel *assumeModel = [MyResumePreviewSectionsModel new];
        assumeModel.cellIdentifier = MyResumePreviewJustTextCellIdentifier;
        assumeModel.title = @"技能特长";
        [userInfoList addObject:assumeModel];
        
        MyResumePreviewItemModel *itemModel = [MyResumePreviewItemModel new];
        itemModel.detailText = detailModel.infoModel.SkillDescribe;
        assumeModel.previewItems = [NSArray arrayWithObject:itemModel];
    }
    return userInfoList;
}

+ (MyResumePreviewItemModel *)covertJobIntentionWithModel:(ResumeDetailInfoModel *)jobIntensionModel {
    MyResumePreviewItemModel *itemModel = [MyResumePreviewItemModel new];
    itemModel.detailText = ({
        NSString *detailText = [NSString stringWithFormat:@"期望从事行业 %@",jobIntensionModel.BegPositionIndustry];
        detailText = [NSString stringWithFormat:@"%@\n期望从事岗位：%@",detailText,jobIntensionModel.BegPositionPost];
        detailText = [NSString stringWithFormat:@"%@\n期望工作地区：%@",detailText,jobIntensionModel.BegPositionCity];
        detailText = [NSString stringWithFormat:@"%@\n当前期望薪资：%@",detailText,jobIntensionModel.BegPositionPay];
        detailText = [NSString stringWithFormat:@"%@\n目前求职状况：%@",detailText,jobIntensionModel.BegPositionInPlaceDate];
        detailText = [NSString stringWithFormat:@"%@\n预计到岗时间：%@",detailText,jobIntensionModel.HopeArriveDate];
    });
    return itemModel;
}

- (NSString *)cellName {
    if (_cellName == nil) {
        if (_cellIdentifier == MyResumePreviewUserInfoCellIdentifier) {
            _cellName = @"MyResumePreviewUserInfoCellIdentifier";
        }else if (_cellIdentifier == MyResumePreviewJustTextCellIdentifier) {
            _cellName = @"MyResumePreviewJustTextCell";
        } else if (_cellIdentifier == MyResumePreviewHasTitleCellIdentifier) {
            _cellName = @"MyResumePreviewHasTitleCell";
        } else if (_cellIdentifier == MyResumePreviewLanguagesCellIdentifier) {
            _cellName = @"MyResumePreviewLanguagesCell";
        } else {
            _cellName = nil;
        }
    }
    return _cellName;
}


@end
