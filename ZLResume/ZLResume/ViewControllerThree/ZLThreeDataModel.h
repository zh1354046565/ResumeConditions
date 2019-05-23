//
//  ZLThreeDataModel.h
//  ZLResume
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLThreeModel.h"

@interface ZLThreeDataModel : NSObject

@property (nonatomic, strong)ZLThreeModel *model;

@property (nonatomic, strong)ContentModel *contentModel;

/**
 详情Label
 */
@property (nonatomic, copy)NSString *detailStr;

+ (NSMutableArray <ZLThreeDataModel *>*)dataArr:(NSMutableArray <ZLThreeModel *>*)dataArr contentArr:(NSMutableArray <ContentModel *>*)contentArr;

@end
