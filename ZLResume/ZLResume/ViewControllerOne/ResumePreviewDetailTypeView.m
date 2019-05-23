//
//  ResumePreviewDetailTypeView.m
//  ZLResume
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ResumePreviewDetailTypeView.h"
#import "UIButton+ImageTitleSpacing.h"
#import "Masonry.h"
#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width
@interface ResumePreviewDetailTypeView()

@property (nonatomic, strong)UIButton *btn1;

@property (nonatomic, strong)UIButton *btn2;

@property (nonatomic, strong)UIButton *btn3;

@end
@implementation ResumePreviewDetailTypeView

- (instancetype)initWithFrame:(CGRect)frame type:(ResumeDetailType)type {
    self = [super initWithFrame:frame];
    if (self) {
        switch (type) {
            case ResumeDetailTypeDefault:
                [self defaultType];
                break;
            case ResumeDetailTypeWaitCommunicate:
                [self waitCommunicateType];
                break;
            case ResumeDetailTypeWaitInterview:
                [self waitInterviewType];
                break;
            case ResumeDetailTypeWaitEmployed:
                [self waitEmployedType];
                break;
            case ResumeDetailTypeEmployed:
                [self employedType];
                break;
            default:
                [self defaultType];
                break;
        }
    }
    return self;
}
//未处理 默认
- (void)defaultType {
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.33);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [self getBtn:self.btn1 color:[UIColor whiteColor] indexTag:10001 title:@"暂存" imageStr:@"staging"];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btn2];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btn1.mas_right);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [self getBtn:self.btn2 color:[UIColor colorWithRed:255/255.0 green:120/255.0 blue:0/255.0 alpha:1] indexTag:10002 title:@"下载简历" imageStr:@"downLoad"];
    
}
//待沟通
- (void)waitCommunicateType {
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self getBtn:self.btn1 color:[UIColor colorWithRed:255/255.0 green:68/255.0 blue:0/255.0 alpha:1] indexTag:10003 title:@"待沟通" imageStr:@"waitCommunication"];
}
//待面试
- (void)waitInterviewType {
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self getBtn:self.btn1 color:[UIColor colorWithRed:255/255.0 green:68/255.0 blue:0/255.0 alpha:1] indexTag:10004 title:@"待面试" imageStr:@"interview"];
}
//待录用
- (void)waitEmployedType {
    //不合适
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.24);
    }];
    [self getBtn:self.btn1 color:[UIColor whiteColor] indexTag:10005 title:@"不合适" imageStr:@"notfit"];
    //待录用
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btn2];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btn1.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.38);
    }];
    [self getBtn:self.btn2 color:[UIColor colorWithRed:255/255.0 green:68/255.0 blue:0/255.0 alpha:1] indexTag:1006 title:@"待录用" imageStr:@"waitEmployed"];
    
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btn3];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btn2.mas_right);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.mas_height);
    }];
    [self getBtn:self.btn3 color:[UIColor colorWithRed:34/255.0 green:191/255.0 blue:142/255.0 alpha:1] indexTag:1007 title:@"录用" imageStr:@"employed"];
}
//录用
- (void)employedType {
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.33);
    }];
    [self getBtn:self.btn1 color:[UIColor whiteColor] indexTag:10005 title:@"不合适" imageStr:@"notfit"];
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btn3];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btn1.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.mas_height);
        make.right.mas_equalTo(self.mas_right);
    }];
    [self getBtn:self.btn3 color:[UIColor colorWithRed:34/255.0 green:191/255.0 blue:142/255.0 alpha:1] indexTag:1007 title:@"录用" imageStr:@"employed"];
}

- (void)btnAction:(UIButton *)sender {
    if (_ResumePreviewBlock) {
        _ResumePreviewBlock(sender.tag);
    }
    
}

- (void)getBtn:(UIButton *)sender color:(UIColor *)color indexTag:(NSInteger)indexTag title:(NSString *)title imageStr:(NSString *)imageStr{
//    sender =
    sender.backgroundColor = color;
    sender.tag = indexTag;
    sender.tintColor = [UIColor whiteColor];
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [sender layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:14 titleFont:14.f];
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
