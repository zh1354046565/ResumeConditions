//
//  ZLThreeCell.h
//  ZLResume
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLThreeDataModel.h"


typedef enum : NSUInteger {
    shapeDefault,
    shapeOnly,
} ShapeType;

@interface ZLThreeCell : UITableViewCell


@property (nonatomic, strong)ZLThreeDataModel *dataM;

@end
