//
//  ResumeExperienceModel.m
//  ZLResume
//
//  Created by apple on 2018/9/12.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ResumeExperienceModel.h"

@implementation ResumeExperienceModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
    }
    return self;
}

/**
 传入一个数据源返回一个实例对象
 
 @param dict 传入数据源
 @return 返回实例对象
 */
+ (instancetype)resumeExperienceModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


/**
 计算内部零件的位置和详细内容
 */
- (void)caculateResumeExperienceDisplayTextAndSubViewsFrame{
    
}
@end
