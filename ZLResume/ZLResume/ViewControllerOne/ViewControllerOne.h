//
//  ViewControllerOne.h
//  ZLResume
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"


@class MyResumePreviewSectionsModel;
@interface ViewControllerOne : BaseTableViewController

@property (nonatomic, strong)NSArray <MyResumePreviewSectionsModel *>*dataArr;

@property (nonatomic, assign)NSInteger DisposeState;
- (instancetype)initWithContentsetY:(CGFloat)top;
- (void)reloadDatas;
@end
