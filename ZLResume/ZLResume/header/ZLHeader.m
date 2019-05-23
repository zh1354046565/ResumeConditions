//
//  ZLHeader.m
//  ZLResume
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ZLHeader.h"


#define TextColor [UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.00]
@interface LayerView()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, copy)NSString *titleStr;
@end
@implementation LayerView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleStr = title;
//        self.backgroundColor = [UIColor greenColor];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [self drawPath].CGPath;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:shapeLayer];
        
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 2, self.bounds.size.width - 20, self.bounds.size.height - 4)];
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.f];
        _titleLabel.textColor = TextColor;
        _titleLabel.text = self.titleStr;
    }
    return _titleLabel;
}

- (UIBezierPath *)drawPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(20, 20)];
    path.lineWidth = 1.f;
    [path closePath];
    
    return path;
}

@end

@interface ZLHeader()

@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UILabel *topNameL;

@property (nonatomic, strong)UILabel *topNumberL;
@property (nonatomic, strong)UILabel *numberL;

@property (nonatomic, strong)UILabel *topPositionL;
@property (nonatomic, strong)UILabel *positionL;

@property (nonatomic, strong)UILabel *topTimeL;
@property (nonatomic, strong)UILabel *timeL;
/*****/
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *nameL;
@property (nonatomic, strong)UILabel *emailL;
@property (nonatomic, strong)UILabel *phoneL;
@property (nonatomic, strong)UIButton *phoneBtn;
@property (nonatomic, strong)UILabel *infoL;
@property (nonatomic, strong)NSArray *infoArr;
@property (nonatomic, strong)LayerView *layerView;
@end
@implementation ZLHeader

- (instancetype)initWithFrame:(CGRect)frame infoArr:(NSArray *)infoArr{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.infoArr = [NSArray arrayWithArray:infoArr];
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
        
        [self.bottomView addSubview:self.imageV];
        [self.bottomView addSubview:self.nameL];
        [self.bottomView addSubview:self.infoL];
        [self.bottomView addSubview:self.emailL];
        [self.bottomView addSubview:self.phoneL];
        [self.bottomView addSubview:self.phoneBtn];
        
        self.layerView = [[LayerView alloc]initWithFrame:CGRectMake(self.frame.size.width - 120, 15, 120, 40) title:@"3天前更新"];
        [self.bottomView addSubview:self.layerView];
    }
    return self;
}

#pragma mark ---
- (NSString *)getInfoStr:(NSArray *)arr {
    NSString *str = [arr componentsJoinedByString:@" | "];
    return str;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode infoStr:(NSString *)infoStr{
    CGSize result;
    if (!font) font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.f];
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;

    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = lineBreakMode;
    attr[NSParagraphStyleAttributeName] = paragraphStyle;
    CGRect rect = [infoStr boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attr context:nil];
    result = rect.size;
    return result;
}
#pragma mark - 拨打电话
- (void)make_a_PhoneCall {
    
}

#pragma mark - lazyLoad
- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.userInteractionEnabled = NO;
        _topView.multipleTouchEnabled = YES;
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.userInteractionEnabled = NO;
        _bottomView.multipleTouchEnabled = YES;
    }
    return _bottomView;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [UIImageView new];
        _imageV.backgroundColor =[UIColor redColor];
    }
    return _imageV;
}

- (UILabel *)nameL {
    if (!_nameL) {
        _nameL = [UILabel new];
        _nameL.text = @"谢先生";
        _nameL.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:22.f];
//        _nameL.font = [UIFont boldSystemFontOfSize:22.f];
        _nameL.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    return _nameL;
}

- (UILabel *)infoL {
    if (!_infoL) {
        
        _infoL = [UILabel new];
        _infoL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.f];
        _infoL.numberOfLines = 0;
        
    }
    return _infoL;
}

- (NSArray *)infoArr {
    if (!_infoArr) {
        _infoArr = @[];
    }
    return _infoArr;
}

- (UILabel *)emailL {
    if (!_emailL) {
        _emailL = [UILabel new];
        _emailL.text = @"邮箱：47961924@qq.com";
        _emailL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.f];
        _emailL.textColor = TextColor;
    }
    return _emailL;
}

- (UILabel *)phoneL {
    if (!_phoneL) {
        _phoneL = [UILabel new];
        _phoneL.textColor = TextColor;
        _phoneL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.f];
        
    }
    return _phoneL;
}

- (UIButton *)phoneBtn {
    if (!_phoneBtn) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtn setTitle:@"拨打" forState:UIControlStateNormal];
        _phoneBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.f];
        [_phoneBtn setTitleColor:[UIColor colorWithRed:1.00 green:0.37 blue:0.17 alpha:1.00] forState:UIControlStateNormal];
        [_phoneBtn addTarget:self action:@selector(make_a_PhoneCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}

#pragma mark - System
- (void)layoutSubviews {
    [super layoutSubviews];
    _topView.frame = CGRectMake(0, 0, self.bounds.size.width, 70);
    
    _bottomView.frame = CGRectMake(0, 80, self.bounds.size.width, 230);
    
    _imageV.frame = CGRectMake(15, 27, 60, 60);
    
    _nameL.frame = CGRectMake(CGRectGetWidth(_imageV.frame) + _imageV.frame.origin.x+15,
                              17,
                              100,
                              40);
    
    NSString *infoStr = [self getInfoStr:self.infoArr];
    _infoL.text = infoStr;
    CGSize stringSize = [self sizeForFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:15.f] size:CGSizeMake(260, 1000) mode:NSLineBreakByWordWrapping infoStr:infoStr];
    _infoL.frame = CGRectMake(_nameL.frame.origin.x,
                              _nameL.frame.size.height + _nameL.frame.origin.y + 10,
                              stringSize.width,
                              stringSize.height);
    
    _emailL.frame = CGRectMake(_nameL.frame.origin.x,
                               _infoL.frame.size.height + _infoL.frame.origin.y + 5,
                               200,
                               30);


    _phoneL.text = @"电话：17610885130";
    CGSize phoneLSize = [self sizeForFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:15.f] size:CGSizeMake(200, 1000) mode:NSLineBreakByWordWrapping infoStr:_phoneL.text];
    _phoneL.frame = CGRectMake(_nameL.frame.origin.x,
                               _emailL.frame.size.height + _emailL.frame.origin.y + 10,
                               phoneLSize.width,
                               phoneLSize.height);

    _phoneBtn.frame = CGRectMake(_nameL.frame.origin.x + _phoneL.frame.size.width + 10,
                                 _phoneL.frame.origin.y,
                                 40,
                                 _phoneL.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
