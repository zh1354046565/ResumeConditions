//
//  SBESearchConditionStatusModel.h
//  ZLResume
//
//  Created by apple on 2018/9/6.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBESearchConditionStatusModel : NSObject

//状态ID
@property (nonatomic, assign) NSInteger statusID;
//状态名称
@property (nonatomic, copy)  NSString *statusName;
@property (nonatomic, copy)  NSString  *str;
@property (nonatomic, assign)  BOOL isStatusShow;


//
@property (nonatomic, assign)BOOL is_Select;





@end
