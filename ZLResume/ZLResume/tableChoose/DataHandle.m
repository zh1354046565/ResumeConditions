//
//  DataHandle.m
//  ZLResume
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "DataHandle.h"
#import "SBESearchConditionStatusModel.h"
static DataHandle *_dataHandleManager = nil;
static dispatch_once_t onceToken;
@interface DataHandle()

@end
@implementation DataHandle

+ (instancetype)shareDataHandle{
    dispatch_once(&onceToken, ^{
        _dataHandleManager = [self new];
        NSNumber *num = [[NSUserDefaults standardUserDefaults]objectForKey:@"isDefault"];
        if (num.intValue == YES) {
            [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"isDefault"];
            [_dataHandleManager initData:YES];
        }else {
            [_dataHandleManager initData:NO];
        }
    });
    return _dataHandleManager;
}

- (void)initData:(BOOL)isDefault{
    NSDictionary *dic;
    if (isDefault) {
        dic = @{@"one":@[@"意向行业",
                         @"意向地区",
                         @"学历要求",
                         @"工作年限",
                         @"年龄要求",
                         @"薪酬范围",
                         @"更新日期",],
                @"two":@[@"毕业院校",
                         @"专业名称",
                         @"性别要求",
                         @"户口所在地",
                         @"当前工作状态",
                         @"婚姻状态",
                         @"民族",
                         @"政治面貌",
                         @"所获证书",
                         @"语言能力",]
                };
    }else {
         dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"defaultData"];
    }
   
    
    self.allDic = @{}.mutableCopy;
    self.allKeysArray = [NSMutableArray arrayWithArray:dic.allKeys];
    for (NSString *key in self.allKeysArray) {
        NSMutableArray *array = [dic[key] mutableCopy];
        NSMutableArray *modelArray = @[].mutableCopy;
        for (NSString *title in array) {
            SBESearchConditionStatusModel *model = [SBESearchConditionStatusModel new];
            model.statusName = title;
//            [model setValuesForKeysWithDictionary:titleDic];
            if ([title isEqualToString:@"意向行业"] || [title isEqualToString:@"学历要求"] || [title isEqualToString:@"民族"]) {
                model.str = @"";
            }else {
                model.str = @"不限";
            }
            [modelArray addObject:model];
        }
        [self.allDic setValue:modelArray forKey:key];
    }
}

//重置单例
- (NSString *)resetInstance{
    onceToken = 0;
    _dataHandleManager = nil;
    return @"哈哈哈";
}

@end
