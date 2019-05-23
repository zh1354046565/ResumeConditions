//
//  ZLThreeDataModel.m
//  ZLResume
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ZLThreeDataModel.h"



@implementation ZLThreeDataModel


+ (NSMutableArray <ZLThreeDataModel *>*)dataArr:(NSMutableArray <ZLThreeModel *>*)dataArr contentArr:(NSMutableArray <ContentModel *>*)contentArr {
    NSMutableArray *arr = @[].mutableCopy;
    [dataArr enumerateObjectsUsingBlock:^(ZLThreeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZLThreeDataModel *dataM = [ZLThreeDataModel new];
        dataM.model = obj;
        if (obj.IsInnerView) {
            dataM.contentModel = contentArr[idx];
            dataM.detailStr = ({
                NSString *detailStr = [NSString stringWithFormat:@"面试时间: %@",dataM.contentModel.AppleDate];
                detailStr = [NSString stringWithFormat:@"%@\n联系人: %@  %@",detailStr,dataM.contentModel.HRName,dataM.contentModel.MobilePhone];
                detailStr = [NSString stringWithFormat:@"%@\n面试地址: %@",detailStr,dataM.contentModel.Address];
                
                detailStr = [NSString stringWithFormat:@"%@\n备注信息: %@",detailStr,dataM.contentModel.Remark];
            });
        }
        [arr addObject:dataM];
    }];
    
    
    return arr;
}

//- (NSString *)getStr:(ContentModel *)contentModel {
//    return ({
//        NSString *detailStr = [NSString stringWithFormat:@"面试时间: %@",contentModel.AppleDate];
//        detailStr = [NSString stringWithFormat:@"%@\n联系人: %@  %@",detailStr,contentModel.HRName,contentModel.MobilePhone];
//        detailStr = [NSString stringWithFormat:@"%@\n面试地址: %@",detailStr,contentModel.Address];
//
//        detailStr = [NSString stringWithFormat:@"%@\n备注信息: %@",detailStr,contentModel.Remark];
//    });
//}


@end
