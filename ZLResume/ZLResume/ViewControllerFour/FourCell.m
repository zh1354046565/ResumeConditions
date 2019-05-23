//
//  ThreeCell.m
//  ZLResume
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "FourCell.h"

@interface FourCell()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)CAShapeLayer *cycleLayer;
@property (nonatomic, strong)CAShapeLayer *bottomLineLayer;
@property (nonatomic, strong)CAShapeLayer *topLineLayer;
@end
@implementation FourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.timeLabel];
        
        _cycleLayer = [self drawCycle:CGRectMake(16, 20, 8, 8) radius:4 fillColor:[UIColor groupTableViewBackgroundColor].CGColor];
        [self.contentView.layer addSublayer:_cycleLayer];
        
        _bottomLineLayer = [self drawLine:CGPointMake(20, 28) toPoint:CGPointMake(20, 70)];
        [self.contentView.layer addSublayer:_bottomLineLayer];
        
        _topLineLayer = [self drawLine:CGPointMake(20, 20) toPoint:CGPointMake(20, 0)];
        [self.contentView.layer addSublayer:_topLineLayer];
        
    }
    return self;
}

- (void)setModel:(ZLThreeModel *)model{
    _titleLabel.text = model.Message;
    _timeLabel.text = model.RecordDate;
    [self drawPath:model.first last:model.last];
}

- (void)drawPath:(BOOL)first last:(BOOL)last{
    [self typeDefault:(BOOL)first last:(BOOL)last];
}

- (void)typeDefault:(BOOL)first last:(BOOL)last {
    _topLineLayer.hidden = first;
    _bottomLineLayer.hidden = last;
    _cycleLayer.fillColor = first ? [UIColor redColor].CGColor : [UIColor groupTableViewBackgroundColor].CGColor;
}

#pragma mark - 画小圆点
- (CAShapeLayer *)drawCycle:(CGRect)rect radius:(CGFloat)radius fillColor:(CGColorRef)fillColor {
    UIBezierPath *cyclePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    //    cyclePath.lineWidth =
    [cyclePath closePath];
    CAShapeLayer *cycleLayer = [CAShapeLayer layer];
    cycleLayer.path = cyclePath.CGPath;
    cycleLayer.strokeColor = [UIColor clearColor].CGColor;
    cycleLayer.fillColor = fillColor;
//    [self.contentView.layer addSublayer:cycleLayer];
    return cycleLayer;
}
#pragma mark - 画线
- (CAShapeLayer *)drawLine:(CGPoint)point toPoint:(CGPoint)toPoint{
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:point];
    [linePath addLineToPoint:toPoint];
    linePath.lineWidth = 1;
    [linePath closePath];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = [UIColor groupTableViewBackgroundColor].CGColor;
    lineLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
    lineLayer.lineJoin = kCALineJoinRound;
    lineLayer.lineCap = kCALineCapRound;
//    [self.contentView.layer addSublayer:lineLayer];
    return lineLayer;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.f];
        
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.f];
        _timeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    }
    return _timeLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(40, 10, self.contentView.bounds.size.width - 60, 30);
    _timeLabel.frame = CGRectMake(_titleLabel.frame.origin.x,
                                  _titleLabel.frame.origin.y + _titleLabel.frame.size.height,
                                  _titleLabel.frame.size.width,
                                  20);
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

