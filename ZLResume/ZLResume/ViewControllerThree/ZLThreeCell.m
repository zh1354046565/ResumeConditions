//
//  ZLThreeCell.m
//  ZLResume
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ZLThreeCell.h"
#import "ZLThreeModel.h"

@interface ZLThreeCell()

@property (weak, nonatomic) IBOutlet UIView *cycleView;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet UILabel *detailL;

@end
@implementation ZLThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.detailView.layer.masksToBounds = YES;
    self.detailView.layer.cornerRadius = 2;
    
    self.cycleView.layer.masksToBounds = YES;
    self.cycleView.layer.cornerRadius = 4;
}

- (void)setDataM:(ZLThreeDataModel *)dataM{
    self.titleL.text = dataM.model.Message;
    self.timeL.text = dataM.model.RecordDate;
    if (dataM.contentModel == nil) {
        self.detailView.hidden = YES;
        self.detailL.text = nil;
    }else {
        self.detailView.hidden = NO;
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 6.0f;
        NSDictionary *dic = @{NSParagraphStyleAttributeName:paraStyle};
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:dataM.detailStr attributes:dic];
        self.detailL.attributedText = attributeStr;
    }
    [self lineViewPath:dataM.model.first last:dataM.model.last];
}

- (void)lineViewPath:(BOOL)first last:(BOOL)last{
    self.topView.hidden = first;
    self.bottomView.hidden = last;
    self.cycleView.backgroundColor = first ? [UIColor redColor] : [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
