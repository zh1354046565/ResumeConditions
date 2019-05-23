//
//  ZLModel.h
//  ZLResume
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ContentModel;
@interface ZLThreeModel : NSObject


@property (nonatomic, assign) BOOL first;
@property (nonatomic, assign) BOOL last;

/**
 *  操作信息
 */
@property (nonatomic, copy) NSString *Message;
/**
 *  是否为面试记录
 */
@property (nonatomic, assign) BOOL IsInnerView;

/**
 *  操作时间
 */
@property (nonatomic, copy) NSString *RecordDate;
@end

@interface ContentModel : NSObject

//@property (nonatomic, copy)NSString *time;
//@property (nonatomic, assign)CGFloat timeHeight;
//@property (nonatomic, copy)NSString *info;
//@property (nonatomic, assign)CGFloat infoHeight;
//@property (nonatomic, copy)NSString *contact;
//@property (nonatomic, assign)CGFloat contactHeight;
//@property (nonatomic, copy)NSString *address;
//@property (nonatomic, assign)CGFloat addressHeight;



/**
  面试时间
 */
@property (nonatomic, copy)NSString *AppleDate;

/**
 *  联系人
 */
@property (nonatomic, copy)NSString *HRName;

/**
 *  联系电话
 */
@property (nonatomic, copy)NSString *MobilePhone;

/**
 *  面试地址
 */
@property (nonatomic, copy)NSString *Address;

/**
 *  备注信息
 */
@property (nonatomic, copy)NSString *Remark;
@end

