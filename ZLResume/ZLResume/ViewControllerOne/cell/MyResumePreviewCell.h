//
//  MyResumePreviewCell.h
//  ZLResume
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyResumePreviewSectionsModel.h"
#import "Masonry.h"
#import "MyResumePreviewSectionsModel.h"
#import "MyResumePreviewItemModel.h"

@interface MyResumePreviewCell : UITableViewCell
//语言
@property (nonatomic, strong, readonly, nullable) NSArray<MyResumePreviewItemModel *> *previewItems;

//垂直栅展示形式
@property (nonatomic, strong, readonly, nullable) MyResumePreviewItemModel *itemModel;

+(instancetype)dequeueMyResumePreviewCellWithSectionModel:(MyResumePreviewSectionsModel *)sectionModel forTableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath;

//NS_REQUIRES_SUPER:继承时,必须调用[super ...];来实现父类方法
- (void)displayCellWithItemModel:(MyResumePreviewItemModel *)itemModel NS_REQUIRES_SUPER;

- (void)displayCellWithPreviewItems:(NSArray<MyResumePreviewItemModel *> *)previewItems NS_REQUIRES_SUPER;

@end
