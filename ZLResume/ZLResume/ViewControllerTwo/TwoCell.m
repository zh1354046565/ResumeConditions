//
//  TwoCell.m
//  ZLResume
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "TwoCell.h"
#import "Masonry.h"
#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width

@interface TwoCell()

@property (nonatomic, strong)UIImageView *headImageV;
@property (nonatomic, strong)UILabel *nameL;
@property (nonatomic, strong)UILabel *infoL;
@property (nonatomic, strong)UILabel *timeL;
@property (nonatomic, strong)UILabel *fromL;


//@property (nonatomic, strong)UICollectionView *collectionView;

@end
@implementation TwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageV];
        [self.contentView addSubview:self.nameL];
        [self.contentView addSubview:self.infoL];
        [self.contentView addSubview:self.timeL];
        [self.contentView addSubview:self.fromL];
        [self.contentView addSubview:self.labelView];
    }
    return self;
}

- (void)setModel:(ZLTwoModel *)model {
    _nameL.text = [model.HRName stringByAppendingString:@":"];
    _infoL.text = model.EvalContent;
    _timeL.text = model.RecordDate;
    if (model.OperationSource == 501) {
        _fromL.text = @"来自微信小程序";
    }
    _labelView.frame = CGRectMake(60, 30, SCREEN_WIDTH - 70, model.LabelsHeight);
    _labelView.titleArr = [NSArray arrayWithArray:model.labelArr];
}

- (ZLLabelView *)labelView {
    if (!_labelView) {
        _labelView = [ZLLabelView new];
    }
    return _labelView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.height.mas_equalTo(30);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageV.mas_right).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [_infoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameL.mas_right).offset(5);
        make.top.mas_equalTo(self.nameL.mas_top);
        make.height.mas_equalTo(20);
    }];
    
    
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameL.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [_fromL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.timeL.mas_bottom);
        make.height.mas_equalTo(20);
        
    }];
}

- (UIImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc]init];
        _headImageV.backgroundColor = [UIColor redColor];
    }
    return _headImageV;
}

- (UILabel *)nameL {
    if (!_nameL) {
        _nameL = [UILabel new];
        _nameL.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _nameL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.f];
    }
    return _nameL;
}

- (UILabel *)infoL {
    if (!_infoL) {
        _infoL = [UILabel new];
        _infoL.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _infoL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.f];
    }
    return _infoL;
}

- (UILabel *)timeL {
    if (!_timeL) {
        _timeL = [UILabel new];
        _timeL.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _timeL.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12.f];
    }
    return _timeL;
}

- (UILabel *)fromL {
    if (!_fromL) {
        _fromL = [UILabel new];
        _fromL.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _fromL.textAlignment = NSTextAlignmentRight;
        _fromL.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12.f];
    }
    return _fromL;
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

@implementation ZLTwoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

