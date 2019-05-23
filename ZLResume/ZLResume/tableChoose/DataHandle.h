//
//  DataHandle.h
//  ZLResume
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataHandle : NSObject

+ (instancetype)shareDataHandle;

@property (nonatomic, strong)NSMutableDictionary *allDic;
@property (nonatomic, strong)NSMutableArray *allKeysArray;

- (NSString *)resetInstance;





@end
