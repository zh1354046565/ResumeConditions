//
//  ZLFooterView.m
//  ZLResume
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ZLFooterView.h"

@interface ZLFooterView()
//恢复默认选项
@property (nonatomic, strong)UIButton *restoreBtn;
@end

@implementation ZLFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.restoreBtn];
    }
    return self;
}

- (UIButton *)restoreBtn {
    if (!_restoreBtn) {
        _restoreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_restoreBtn setTitle:@"恢复默认选项" forState:(UIControlStateNormal)];
        [_restoreBtn.titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:20.f]];
        [_restoreBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:(UIControlStateNormal)];
        [_restoreBtn addTarget:self action:@selector(restoreDefaultAct) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _restoreBtn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _restoreBtn.frame = CGRectMake(self.center.x-80, 30, 160, 40);
}

- (void)restoreDefaultAct {
    if (_delegate && [_delegate respondsToSelector:@selector(restoreDefaultOptions)]) {
        [_delegate restoreDefaultOptions];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
