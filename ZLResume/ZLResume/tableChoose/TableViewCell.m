//
//  TableViewCell.m
//  ZLResume
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UIButton *maxBtn;//加号
@property (nonatomic, strong)UIButton *minBtn;//减号
@end
@implementation TableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.maxBtn];
        [self.contentView addSubview:self.minBtn];
        self.maxBtn.hidden = YES;
        self.minBtn.hidden = YES;
    }
    return self;
}

- (void)setModel:(SBESearchConditionStatusModel *)model indexTag:(NSInteger)tag  showWhatBtn:(ShowWhatBtn)showWhatBtn{
    self.titleL.text = model.statusName;
    if (showWhatBtn == ShowWhatBtnDef) {
        if (tag == 0) {
            if (model.is_Select) {
                self.minBtn.hidden = NO;
                self.maxBtn.hidden = YES;
            }else {
                self.minBtn.hidden = YES;
                self.maxBtn.hidden = YES;
            }
        }else {
            if (model.is_Select) {
                self.minBtn.hidden = YES;
                self.maxBtn.hidden = NO;
            }else {
                self.minBtn.hidden = YES;
                self.maxBtn.hidden = YES;
            }
        }
    }else if(showWhatBtn == ShowWhatBtnNotAdd){
        if (tag == 0) {
            if (model.is_Select) {
                self.minBtn.hidden = YES;
                self.maxBtn.hidden = NO;
            }else{
                self.minBtn.hidden = YES;
                self.maxBtn.hidden = YES;
            }
        }
    }
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.f];
    }
    return _titleL;
}

- (UIButton *)maxBtn {
    if (!_maxBtn) {
        _maxBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_maxBtn setTitle:@"加号" forState:(UIControlStateNormal)];
        _maxBtn.backgroundColor = [UIColor redColor];
        [_maxBtn addTarget:self action:@selector(maxAct) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _maxBtn;
}

- (UIButton *)minBtn {
    if (!_minBtn) {
        _minBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_minBtn setTitle:@"减号" forState:UIControlStateNormal];
        _minBtn.backgroundColor = [UIColor blueColor];
        [_minBtn addTarget:self action:@selector(minAct) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _minBtn;
}
//加号action
- (void)maxAct {
    if (_delegate && [_delegate respondsToSelector:@selector(maxCell:)]) {
        [_delegate maxCell:self.indexP];
    }
}
//减号action
- (void)minAct {
    if (_delegate && [_delegate respondsToSelector:@selector(minCell:)]) {
        [_delegate minCell:self.indexP];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _titleL.frame = CGRectMake(20, 10, 160, 30);
    _maxBtn.frame = CGRectMake(240, 10, 60, 30);
    _minBtn.frame = CGRectMake(320, 10, 60, 30);
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
