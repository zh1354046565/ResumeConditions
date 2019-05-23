//
//  MyResumePreviewCell.m
//  ZLResume
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "MyResumePreviewCell.h"
#import "MyResumePreviewSectionsModel.h"
#import "MyResumePreviewItemModel.h"

@interface MyResumePreviewCell()

@property (weak, nonatomic) UILabel *titleTextLable;

@property (weak, nonatomic) UILabel *subtitleTextLable;

@property (weak, nonatomic) UILabel *detailTextLable;

@end
@implementation MyResumePreviewCell


+(instancetype)dequeueMyResumePreviewCellWithSectionModel:(MyResumePreviewSectionsModel *)sectionModel forTableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyResumePreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionModel.cellIdentifier];
    
    if (sectionModel.shouldHorizontalDisplay) {
        [cell displayCellWithPreviewItems:sectionModel.previewItems];
    }else {
        [cell displayCellWithItemModel:sectionModel.previewItems[indexPath.row]];
    }
    
    return cell;
}

- (void)displayCellWithItemModel:(MyResumePreviewItemModel *)itemModel {
    _itemModel = itemModel;
    self.titleTextLable.text = itemModel.title;
    self.subtitleTextLable.text = itemModel.subtitle;
    self.detailTextLable.text = itemModel.detailText;
}

- (void)displayCellWithPreviewItems:(NSArray<MyResumePreviewItemModel *> *)previewItems {
    _previewItems = previewItems;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
