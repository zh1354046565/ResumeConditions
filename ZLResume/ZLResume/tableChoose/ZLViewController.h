//
//  ViewControllerTwo.h
//  ZLResume
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBESearchConditionStatusModel.h"

@interface ZLViewController : UIViewController
//传过来的原始数据源
@property (nonatomic, strong)NSMutableArray <SBESearchConditionStatusModel *>*sourceArr;


@property (nonatomic, copy)void(^SBESearchConditionStatusBlock)(NSMutableArray <SBESearchConditionStatusModel *>* arr);


@end
