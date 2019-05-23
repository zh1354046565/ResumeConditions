//
//  TableViewCell.h
//  ZLResume
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SBESearchConditionStatusModel.h"

typedef NS_ENUM(NSInteger, ShowWhatBtn){
    ShowWhatBtnDef,
    ShowWhatBtnNotAdd
};

@protocol BtnActionDelegate<NSObject>
//减号协议
- (void)minCell:(NSIndexPath *)indexP;
//加号协议
- (void)maxCell:(NSIndexPath *)indexP;
@end
@interface TableViewCell : UITableViewCell

@property (nonatomic, strong)NSIndexPath *indexP;

@property (nonatomic, strong)SBESearchConditionStatusModel *model;

- (void)setModel:(SBESearchConditionStatusModel *)model indexTag:(NSInteger)tag  showWhatBtn:(ShowWhatBtn)showWhatBtn;

@property (nonatomic, assign)id<BtnActionDelegate>delegate;

@end
