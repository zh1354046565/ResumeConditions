//
//  TwoCell.h
//  ZLResume
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLLabelView.h"

@interface ZLTwoModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, strong)NSArray *labelArr;

/**
 排序
 */
@property (nonatomic, assign)NSInteger Irank;
/**
 评价ID
 */
@property (nonatomic, assign)NSInteger EvalID;

/**
 头像地址
 */
@property (nonatomic,copy) NSString *HRImg;

/**
 HR姓名
 */
@property (nonatomic,copy) NSString *HRName;

/**
 评价内容
 */
@property (nonatomic,copy) NSString *EvalContent;

/**
 评价标签
 */
@property (nonatomic,copy) NSString *EvalLable;

/**
 评价时间
 */
@property (nonatomic,copy) NSString *RecordDate;
/**
 评价来源
 */
@property (nonatomic, assign)NSInteger OperationSource;


//Pager {
//    TotalPage (integer, optional):总页数 ,
//    TotalCount (integer, optional):总条数
//}


//标签View高度
@property (nonatomic, assign)CGFloat LabelsHeight;
@property (nonatomic, strong)ZLLabelView *labelView;

@end

@interface TwoCell : UITableViewCell

@property (nonatomic, strong)ZLLabelView *labelView;

@property (nonatomic, strong)ZLTwoModel *model;



@end


